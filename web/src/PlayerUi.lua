local var_0_0 = class("PlayerUi")

PlayerUi = var_0_0
var_0_0.GRAVE_WIDTH = 54
var_0_0.GRAVE_COUNT = 3

local var_0_1 = ClientView.SCR_CW - 28
local var_0_2 = 176

var_0_0.Pos = {
	attack_fortress_area = 500,
	use_area = 210,
	defend_fortress_area = 200,
	boss = cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 180),
	attacker_fortress = cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 250),
	defender_fortress = cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 250),
	attacker_grave = cc.p(ClientView.SCR_CW - 524, ClientView.SCR_CH - 75),
	defender_grave = cc.p(ClientView.SCR_CW - 524, ClientView.SCR_CH + 77),
	attacker_rare = cc.p(ClientView.SCR_CW - 524, ClientView.SCR_CH - 210),
	defender_rare = cc.p(ClientView.SCR_CW - 525, ClientView.SCR_CH + 214),
	attacker_cover = cc.p(ClientView.SCR_CW + 460, ClientView.SCR_CH - 60),
	defender_cover = cc.p(ClientView.SCR_CW + 458, ClientView.SCR_CH + 58),
	attacker_gems = {
		cc.p(ClientView.SCR_CW - 458, ClientView.SCR_CH - 86),
		cc.p(ClientView.SCR_CW - 458, ClientView.SCR_CH - 150),
		cc.p(ClientView.SCR_CW - 458, ClientView.SCR_CH - 218)
	},
	defender_gems = {
		cc.p(ClientView.SCR_CW - 458, ClientView.SCR_CH + 86),
		cc.p(ClientView.SCR_CW - 458, ClientView.SCR_CH + 154),
		cc.p(ClientView.SCR_CW - 458, ClientView.SCR_CH + 218)
	},
	attacker_hand_y = ClientView.SCR_CH - 370,
	defender_hand_y = ClientView.SCR_CH + 410,
	attacker_board_x = {
		var_0_1,
		var_0_1 + var_0_2,
		var_0_1 - var_0_2,
		var_0_1 + var_0_2 * 2,
		var_0_1 - var_0_2 * 2,
		var_0_1 + var_0_2
	},
	defender_board_x = {
		var_0_1,
		var_0_1 - var_0_2,
		var_0_1 + var_0_2,
		var_0_1 - var_0_2 * 2,
		var_0_1 + var_0_2 * 2,
		var_0_1 - var_0_2
	},
	attacker_board_y = ClientView.SCR_CH - 150,
	defender_board_y = ClientView.SCR_CH + 150,
	board_pos_dy = {
		100,
		60
	},
	attacker_area = ClientView.SCR_CH + 70,
	cover_offset = cc.size(86, 86)
}
var_0_0.Action = {
	boss_attack_fortress = 214,
	update_negative_status = 332,
	fortress_atk_dec = 324,
	replace_board_card = 32,
	hp_update = 313,
	replace_hand_card = 31,
	fortress_hp_update = 311,
	times_update = 315,
	boss_hurt = 223,
	hp_dec = 326,
	fortress_hp_dec = 322,
	hp_inc = 325,
	card_hurt = 222,
	attack_card = 213,
	fortress_atk_inc = 323,
	fortress_die = 224,
	boss_attack_card = 215,
	fortress_hp_inc = 321,
	atk_inc = 327,
	atk_dec = 328,
	update_positive_status = 331,
	fortress_atk_update = 312,
	attack_boss = 212,
	avoid_attack = 341,
	fortress_hurt = 221,
	atk_update = 314,
	update_bind = 333,
	attack_fortress = 211,
	change_nature = 351,
	boss_die = 225
}
var_0_0.EventType = {
	dialog_cannot_effect = 8,
	dialog_not_enough_gem = 2,
	dialog_board_card_full = 3,
	dialog_attacker_hand_cards = 14,
	dialog_trap_existed = 10,
	dialog_adding_board_card = 9,
	dialog_defender_hand_cards = 1,
	efc_screen_fortress_hurt = 105,
	efc_camera_to = 201,
	dialog_not_your_round = 4,
	send_use_card = 401,
	update_card_pile_count = 301,
	dialog_target_unattackable = 11,
	dialog_cannot_change_posture = 13,
	dialog_cannot_attack = 12,
	dialog_special_summon_invalid = 7,
	dialog_card_need_target = 6,
	efc_screen_fortress_die = 104,
	efc_screen_attack_card = 103,
	efc_screen_to_board = 101,
	efc_screen_equip_book = 102,
	dialog_card_need_aim = 5
}
var_0_0.EVENT = "PLAYER_UI_EVENT"

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._scene = ClientData._battleScene
	arg_1_0._battleUi = arg_1_1
	arg_1_0._audioEngine = arg_1_1._audioEngine
	arg_1_0._player = arg_1_2
	arg_1_0._isAttacker = arg_1_2._isAttacker
	arg_1_0._isController = arg_1_0._isAttacker == arg_1_0._battleUi._isAttacker
	arg_1_0._sceneType = arg_1_3
	arg_1_0._cardBackId = arg_1_4

	if not arg_1_0._cardBackId or arg_1_0._cardBackId == 0 or not arg_1_0._isController then
		arg_1_0._cardBackId = Data.PropsId.card_back
	end

	if arg_1_0._player._privilege and P.hasPrivilege(arg_1_0._player, Data.Privilege.foot_crown) and ClientData.getServerTick() <= 2018072300 then
		arg_1_0._player._crown = {
			_infoId = 7208,
			_num = 0
		}
	elseif arg_1_0._player._privilege and (P.hasPrivilege(arg_1_0._player, Data.Privilege.arena_mvp) or P.hasPrivilege(arg_1_0._player, Data.Privilege.clash_mvp) or P.hasPrivilege(arg_1_0._player, Data.Privilege.dark_mvp)) then
		arg_1_0._player._crown = {
			_infoId = 7207,
			_num = 0
		}
	end

	arg_1_0._hideHandCards = not arg_1_0._isController

	if arg_1_0._battleUi._isObserver then
		arg_1_0._hideHandCards = true
	end

	arg_1_0._handPos = arg_1_0._isAttacker and var_0_0.Pos.attacker_hand_y or var_0_0.Pos.defender_hand_y

	if arg_1_0._isAttacker then
		arg_1_0._handPos = arg_1_0._handPos - (1 - arg_1_0._battleUi._scale) * 320

		if ClientData.isIPhoneX() then
			arg_1_0._handPos = arg_1_0._handPos + 12
		end
	end

	if false then
		local var_1_0 = cc.DrawNode:create()

		var_1_0:setContentSize(arg_1_0._scene:getContentSize())
		lc.addChildToCenter(arg_1_0._battleUi, var_1_0)

		for iter_1_0 = 1, 22 do
			var_1_0:drawRect(cc.p((iter_1_0 - 1) * 64, 0), cc.p((iter_1_0 - 1) * 64, 768), cc.c4f(1, 1, 1, 0.2))
		end

		for iter_1_1 = 1, 12 do
			var_1_0:drawRect(cc.p(0, (iter_1_1 - 1) * 64), cc.p(1366, (iter_1_1 - 1) * 64), cc.c4f(1, 1, 1, 0.2))
		end
	end

	arg_1_0:initBoardRects()
	arg_1_0:initUIControl()
end

function var_0_0.initUIControl(arg_2_0)
	if arg_2_0._player._fortress._type == Data.CardType.boss then
		arg_2_0:createBoss(arg_2_0._player._bossId)
	end

	local var_2_0 = arg_2_0._battleUi._layer
	local var_2_1 = lc.createSprite("bat_avatar_bg_01")
	local var_2_2 = lc.createNode(var_2_1:getContentSize(), arg_2_0._isController and cc.p(0, 0) or cc.p(ClientView.SCR_W, ClientView.SCR_H), arg_2_0._isController and cc.p(0, 0) or cc.p(1, 1))

	var_2_2._battleUi = arg_2_0._battleUi
	var_2_2._statusEfc = {}

	var_2_0:addChild(var_2_2)

	arg_2_0._avatarFrame = var_2_2

	var_2_1:setFlippedX(not arg_2_0._isController)
	var_2_1:setFlippedY(not arg_2_0._isController)
	lc.addChildToCenter(var_2_2, var_2_1)

	var_2_2._frame1 = var_2_1

	local var_2_3 = arg_2_0._battleUi._battleType

	if arg_2_0._player._crown ~= nil and arg_2_0._player._crown._infoId ~= 0 and var_2_3 ~= Data.BattleType.PVP_clash_ex then
		local var_2_4 = arg_2_0._player._crown._infoId
		local var_2_5 = arg_2_0._player._crown._num
		local var_2_6 = ClientView.createShaderButton(nil, function(arg_3_0)
			require("DescForm").create({
				_infoId = var_2_4
			}):show()
		end)

		var_2_6:setContentSize(cc.size(50, 50))
		lc.addChildToPos(var_2_2, var_2_6, arg_2_0._isController and cc.p(112, 20) or cc.p(lc.w(var_2_2) - 112, lc.h(var_2_2) - 22), 2)

		local var_2_7 = ClientView.createCrown(var_2_4, var_2_5)

		lc.addChildToPos(var_2_6, var_2_7, cc.p(lc.cw(var_2_6), 10))

		var_2_2._crown = var_2_6
	end

	if arg_2_0._player._legendCrown ~= nil and arg_2_0._player._legendCrown._infoId ~= 0 and var_2_3 ~= Data.BattleType.PVP_clash_ex then
		local var_2_8 = arg_2_0._player._legendCrown._infoId
		local var_2_9 = arg_2_0._player._legendCrown._num
		local var_2_10 = ClientView.createShaderButton(nil, function(arg_4_0)
			require("DescForm").create({
				_infoId = var_2_8
			}):show()
		end)

		var_2_10:setContentSize(cc.size(50, 50))
		lc.addChildToPos(var_2_2, var_2_10, arg_2_0._isController and cc.p(150, 20) or cc.p(lc.w(var_2_2) - 150, lc.h(var_2_2) - 22), 2)

		local var_2_11 = ClientView.createCrown(var_2_8, var_2_9)

		lc.addChildToPos(var_2_10, var_2_11, cc.p(lc.cw(var_2_10), 10))

		var_2_2._legendCrown = var_2_10
	end

	if arg_2_0._player._name then
		local var_2_12 = cc.Label:createWithTTF(arg_2_0._player._name, ClientView.TTF_FONT, 20)

		var_2_12:setRotation(14)
		lc.addChildToPos(var_2_2, var_2_12, arg_2_0._isController and cc.p(210, 30) or cc.p(lc.w(var_2_2) - 210, lc.h(var_2_2) - 30), 2)

		var_2_2._name = var_2_12

		if var_2_3 == Data.BattleType.PVP_clash_ex then
			var_2_12:setVisible(false)
		end
	end

	local var_2_13 = lc.createSprite(arg_2_0._isController and "bat_avatar_bg_03" or "bat_avatar_bg_04")

	lc.addChildToCenter(var_2_2, var_2_13, 1)

	var_2_2._frame3 = var_2_13

	local var_2_14 = ClientData.getAvatarName(arg_2_0._player._avatar)

	if lc.FrameCache:getSpriteFrame(var_2_14) == nil then
		if ClientData.isAnotherSkin() then
			var_2_14 = string.format("avatar_%02d_2", arg_2_0._player._avatar)
		elseif ClientData.isAnotherSkin2() then
			var_2_14 = string.format("avatar_%02d_3", arg_2_0._player._avatar)
		else
			var_2_14 = string.format("avatar_%02d", arg_2_0._player._avatar)
		end
	end

	if lc.FrameCache:getSpriteFrame(var_2_14) == nil then
		var_2_14 = ClientData.isAnotherSkin() and "avatar_00_2" or "avatar_00"
	end

	if var_2_3 == Data.BattleType.PVP_clash_ex then
		var_2_14 = "avatar_5101"
	end

	local var_2_15

	if not arg_2_0._battleUi._isObserver and var_2_3 ~= Data.BattleType.PVP_clash_ex then
		var_2_15 = ClientView.createShaderButton(var_2_14, function()
			arg_2_0._battleUi:showChat(arg_2_0._isController)
		end)

		var_2_15:setZoomScale(0)
	else
		var_2_15 = lc.createSprite(var_2_14)
	end

	local var_2_16 = arg_2_0._isController and cc.p(lc.w(var_2_15) / 2, lc.h(var_2_15) / 2) or cc.p(lc.w(var_2_1) - lc.w(var_2_15) / 2, lc.h(var_2_1) - lc.h(var_2_15) / 2)

	lc.addChildToPos(var_2_1, var_2_15, var_2_16)

	var_2_2._avatar = var_2_15
	arg_2_0._avatarFrame._avatarPos = var_2_16

	if arg_2_0._player._privilege and P.hasPrivilege(arg_2_0._player, Data.Privilege.dark_mvp) then
		local var_2_17 = Particle.create("touxiang")

		lc.addChildToCenter(var_2_15, var_2_17)

		arg_2_0._darkParticle = var_2_17
	end

	arg_2_0._pHpLabel = cc.Label:createWithBMFont(ClientView.BMFont.num_43, 8000)

	local var_2_18 = arg_2_0._isController and cc.p(90, 104) or cc.p(220, 40)

	arg_2_0._pHpLabel:setPosition(var_2_18)
	arg_2_0._pHpLabel:setRotation(14)
	var_2_13:addChild(arg_2_0._pHpLabel)

	arg_2_0._avatarFrame._labelPos = var_2_18

	arg_2_0:updateFortressHp()

	if arg_2_0._player._fortress._type == Data.CardType.boss and not arg_2_0._isController then
		local var_2_19 = lc.createSprite("card_atk")

		var_2_19:setScale(0.8)
		var_2_19:setPosition(ClientView.SCR_CW - 40, 800)
		var_2_0:addChild(var_2_19)

		arg_2_0._pAtkLabel = cc.Label:createWithBMFont(ClientView.BMFont.huali_32, 1000)

		arg_2_0._pAtkLabel:setPosition(ClientView.SCR_CW + 20, 800)
		var_2_0:addChild(arg_2_0._pAtkLabel)
		arg_2_0:updateFortressAtk()
	end

	local var_2_20 = arg_2_0._isController and var_0_0.Pos.attacker_cover or var_0_0.Pos.defender_cover
	local var_2_21 = var_0_0.Pos.cover_offset

	arg_2_0._coverPos = {}

	for iter_2_0 = 1, 6 do
		arg_2_0._coverPos[iter_2_0] = cc.p(var_2_20.x + var_2_21.width * ((iter_2_0 - 1) % 2), var_2_20.y + var_2_21.height * math.floor((iter_2_0 - 1) / 2) * (arg_2_0._isController and -1 or 1))
	end

	local var_2_22 = lc.createSprite("bat_pile_count")

	lc.addChildToPos(var_2_0, var_2_22, cc.p(arg_2_0._isController and ClientView.SCR_W - 60 - ClientView.SCR_EDGE or 60 + ClientView.SCR_EDGE, arg_2_0._isController and 40 or ClientView.SCR_H - 40))

	local var_2_23 = cc.Label:createWithBMFont(ClientView.BMFont.huali_26, 0)

	lc.addChildToPos(var_2_22, var_2_23, cc.p(lc.w(var_2_22) / 2 + 22, lc.h(var_2_22) / 2), 1)

	var_2_22._label = var_2_23
	arg_2_0._pile = var_2_22

	if arg_2_0._player._playerType == BattleData.PlayerType.observe then
		local var_2_24 = ClientView.createShaderButton("bat_btn_2", function(arg_6_0)
			arg_2_0:hideHandCards(arg_6_0)
		end)

		lc.addChildToPos(var_2_0, var_2_24, cc.p(lc.left(arg_2_0._battleUi._btnInitiative) - 40, lc.y(var_2_22)))

		local var_2_25 = lc.createSprite("eye_open")

		lc.addChildToCenter(var_2_24, var_2_25)

		var_2_24._eyeSpr = var_2_25
		var_2_2._hideBtn = var_2_24
	elseif arg_2_0._player._opponent._playerType == BattleData.PlayerType.observe then
		local var_2_26 = ClientView.createShaderButton("bat_btn_2", function(arg_7_0)
			arg_2_0:hideHandCards(arg_7_0)
		end)

		lc.addChildToPos(var_2_0, var_2_26, cc.p(lc.right(var_2_22) + 40, lc.y(var_2_22)))
		var_2_26:setVisible(false)

		local var_2_27 = lc.createSprite("eye_close")

		lc.addChildToCenter(var_2_26, var_2_27)

		var_2_26._eyeSpr = var_2_27
		var_2_2._hideBtn = var_2_26
	end

	local var_2_28 = ClientView.createBMFont(ClientView.BMFont.huali_32, 0)

	lc.addChildToPos(arg_2_0._battleUi, var_2_28, arg_2_0._isController and var_0_0.Pos.attacker_grave or var_0_0.Pos.defender_grave, BattleUi.ZOrder.card + 1)

	arg_2_0._pGraveLabel = var_2_28

	local var_2_29 = ClientView.createBMFont(ClientView.BMFont.huali_32, 0)

	lc.addChildToPos(arg_2_0._battleUi, var_2_29, arg_2_0._isController and var_0_0.Pos.attacker_rare or var_0_0.Pos.defender_rare, BattleUi.ZOrder.card + 1)

	arg_2_0._pRareLabel = var_2_29

	arg_2_0:updateFortressSkill()

	arg_2_0._gemStones = {}

	for iter_2_1 = 1, 3 do
		local var_2_30 = lc.createSprite("bat_gem_bg_01")

		lc.addChildToPos(arg_2_0._battleUi, var_2_30, arg_2_0._isController and var_0_0.Pos.attacker_gems[iter_2_1] or var_0_0.Pos.defender_gems[iter_2_1], BattleUi.ZOrder.ui)
		var_2_30:setVisible(false)

		arg_2_0._gemStones[#arg_2_0._gemStones + 1] = var_2_30
	end

	arg_2_0._boardLockIcons = {}

	for iter_2_2 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_2_31 = lc.createSprite("efc_board_lock")
		local var_2_32 = arg_2_0._isController and var_0_0.Pos.attacker_board_x or var_0_0.Pos.defender_board_x
		local var_2_33 = arg_2_0._isController and var_0_0.Pos.attacker_board_y or var_0_0.Pos.defender_board_y

		lc.addChildToPos(arg_2_0._battleUi, var_2_31, cc.p(var_2_32[iter_2_2], var_2_33))
		var_2_31:setVisible(false)

		arg_2_0._boardLockIcons[iter_2_2] = var_2_31
	end

	if arg_2_0._player._battleType == Data.BattleType.PVP_survival or arg_2_0._player._battleType == Data.BattleType.PVP_survival_ex then
		local var_2_34 = lc.createSprite(arg_2_0._isController and "bat_survival_time_bg_1" or "bat_survival_time_bg_2")

		lc.addChildToPos(var_2_2, var_2_34, arg_2_0._isController and cc.p(lc.cw(var_2_34), lc.h(var_2_2)) or cc.p(lc.w(var_2_2) - lc.cw(var_2_34), 0), 10)

		local var_2_35 = lc.createSprite("bat_survival_clock")

		lc.addChildToPos(var_2_34, var_2_35, cc.p(lc.cw(var_2_35), 46))

		local var_2_36 = ClientView.createTTF("", ClientView.FontSize.M1)

		var_2_36:setRotation(15)
		lc.addChildToPos(var_2_34, var_2_36, cc.p(lc.cw(var_2_35) + lc.cw(var_2_34), lc.ch(var_2_34) - 3))

		function var_2_34.update(arg_8_0)
			var_2_36:setString(ClientData.formatTime(math.max(arg_2_0._player._survivalTimeStamp - arg_8_0, 0), true))
		end

		function var_2_34.startCountDown()
			var_2_34:runAction(lc.rep(lc.sequence(function()
				local var_10_0 = ClientData.getCurrentTime()

				var_2_34.update(var_10_0)
			end, 0.5)))
		end

		arg_2_0._survivalCountDown = var_2_34
	end

	if arg_2_0._player._isOnlinePvp and not arg_2_0._player._isNewRound then
		-- block empty
	end

	arg_2_0._roundTimerBg = ClientView.createProgressSector("battle_round_bar_bg")

	arg_2_0._roundTimerBg:setVisible(false)
	lc.addChildToPos(var_2_2, arg_2_0._roundTimerBg, arg_2_0._isController and cc.p(lc.cw(arg_2_0._roundTimerBg) + ClientView.SCR_EDGE, lc.h(var_2_2) + 60) or cc.p(lc.w(var_2_2) - lc.cw(arg_2_0._roundTimerBg), -10 - lc.ch(arg_2_0._roundTimerBg)), 10)

	arg_2_0._roundTimer = ClientView.createProgressSector("battle_round_bar_1")

	lc.addChildToCenter(arg_2_0._roundTimerBg, arg_2_0._roundTimer)

	arg_2_0._roundTimer2 = ClientView.createProgressSector("battle_round_bar_2")

	lc.addChildToCenter(arg_2_0._roundTimerBg, arg_2_0._roundTimer2)

	arg_2_0._roundTimer3 = ClientView.createProgressSector("battle_round_bar_3")

	lc.addChildToCenter(arg_2_0._roundTimerBg, arg_2_0._roundTimer3)

	local var_2_37 = ClientView.createBMFont(ClientView.BMFont.num_43, "")

	lc.addChildToCenter(arg_2_0._roundTimerBg, var_2_37)

	arg_2_0._roundTimerLabel = var_2_37
end

function var_0_0.hideHandCards(arg_11_0, arg_11_1)
	arg_11_0._hideHandCards = not arg_11_0._hideHandCards

	if arg_11_0._avatarFrame._hideBtn then
		arg_11_0._avatarFrame._hideBtn._eyeSpr:setSpriteFrame(not arg_11_0._hideHandCards and "eye_open" or "eye_close")
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._pHandCards) do
		if arg_11_0._hideHandCards then
			iter_11_1:initBack()
			iter_11_1:updateZOrder(false)
		else
			iter_11_1:initNormal()
		end
	end

	arg_11_0:updateHandCardsPos()

	for iter_11_2, iter_11_3 in ipairs(arg_11_0._pRareCards) do
		if arg_11_0._hideHandCards then
			iter_11_3:initBack()
			iter_11_3:setRotation3D({
				z = 0,
				x = 0,
				y = 0
			})
		else
			iter_11_3:initDead()
		end
	end
end

function var_0_0.updateHandCardsPos(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._pHandCards) do
		local var_12_0, var_12_1 = arg_12_0:calHandCardPosAndRot(iter_12_1)

		iter_12_1:setPosition(var_12_0)
		iter_12_1:setRotation3D(var_12_1)
	end
end

function var_0_0.updateBoardCardsPos(arg_13_0)
	for iter_13_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_13_0 = arg_13_0._pBoardCards[iter_13_0]

		if var_13_0 ~= nil then
			local var_13_1 = arg_13_0:calBoardCardPos(var_13_0)

			var_13_0._pFrame._image:stopAllActions()
			var_13_0._pFrame._image:startFloat()
			var_13_0._pFrame._image:setScale(ClientView.getCardBattleScale(var_13_0._card._infoId))
			var_13_0:setPosition(var_13_1)

			var_13_0._default._rotation = {
				z = 0,
				x = 0,
				y = 0
			}

			var_13_0:setScale(1)
			var_13_0:setRotation3D(var_13_0._default._rotation)
		end
	end
end

function var_0_0.sendEvent(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = cc.EventCustom:new(var_0_0.EVENT)

	var_14_0._sender = arg_14_0
	var_14_0._type = arg_14_1
	var_14_0._val = arg_14_2

	lc.Dispatcher:dispatchEvent(var_14_0)
end

function var_0_0.createBoss(arg_15_0, arg_15_1)
	if arg_15_1 == 100 then
		arg_15_0._boss = arg_15_0._battleUi:createDragonBones("boss_jinchan", cc.p(ClientView.SCR_CW, 820), arg_15_0._battleUi, "wait", false, 1.3333333333333333, BattleUi.ZOrder.ui)
	else
		arg_15_0._boss = arg_15_0._battleUi:createDragonBones(string.format("boss_%d", arg_15_1 <= 112 and 101 or arg_15_1), cc.p(ClientView.SCR_CW, 520), arg_15_0._battleUi, "wait", false, 1, BattleUi.ZOrder.card_action + 1)
	end

	arg_15_0._boss._statusEfc = {}
	arg_15_0._boss._battleUi = arg_15_0._battleUi
	arg_15_0._boss._card = arg_15_0._player._fortress
end

function var_0_0.createCardSprite(arg_16_0, arg_16_1)
	local var_16_0 = CardSprite.create(arg_16_1, arg_16_0)

	var_16_0._ownerUi = arg_16_0

	var_16_0:retain()

	if arg_16_0._cardSprites[arg_16_1._id] ~= nil then
		arg_16_0:removeCardSprite(arg_16_0._cardSprites[arg_16_1._id])
	end

	arg_16_0._cardSprites[arg_16_1._id] = var_16_0

	if arg_16_1._status == BattleData.CardStatus.board then
		if arg_16_1:isMonsterRare() then
			var_16_0:initFight()
		end
	elseif arg_16_1._status == BattleData.CardStatus.grave and arg_16_1._sourceStatus ~= BattleData.CardStatus.pile then
		arg_16_0:addGraveCard(var_16_0)
	elseif arg_16_1._status == BattleData.CardStatus.rare then
		arg_16_0:addRareCard(var_16_0)
	end

	return var_16_0
end

function var_0_0.createMaskCardSprite(arg_17_0, arg_17_1)
	if arg_17_1 == nil then
		return nil
	end

	local var_17_0 = CardSprite.create(arg_17_1, arg_17_0)

	var_17_0._ownerUi = arg_17_0

	var_17_0:retain()
	var_17_0:initFight()

	var_17_0._isMask = true

	return var_17_0
end

function var_0_0.removeCardSprite(arg_18_0, arg_18_1)
	if arg_18_1 == nil then
		return
	end

	if arg_18_1:getParent() ~= nil then
		arg_18_1:removeFromParent()
	end

	arg_18_1:release()
end

function var_0_0.hideCardSprite(arg_19_0, arg_19_1)
	if arg_19_1 == nil then
		return
	end

	arg_19_1:setVisible(false)
end

function var_0_0.resetCardSprites(arg_20_0)
	if arg_20_0._cardSprites == nil then
		arg_20_0._cardSprites = {}

		return
	end

	for iter_20_0, iter_20_1 in pairs(arg_20_0._cardSprites) do
		arg_20_0:removeCardSprite(iter_20_1)
	end

	arg_20_0._cardSprites = {}
end

function var_0_0.resetCard(arg_21_0, arg_21_1)
	arg_21_1._pHorse = nil
	arg_21_1._pHero = nil
end

function var_0_0.resetWhenBattleStart(arg_22_0)
	arg_22_0._actionDelay = 0
	arg_22_0._pHandCards = {}
	arg_22_0._pBoardCards = {}
	arg_22_0._pGraveCards = {}
	arg_22_0._pRareCards = {}
	arg_22_0._pCoverCards = {}
	arg_22_0._pShowCards = {}
	arg_22_0._pFieldCard = nil

	arg_22_0:resetCardSprites()
	arg_22_0:updateFortressSkill()
	arg_22_0:switchBoard(true)
end

function var_0_0.resetWhenRoundBegin(arg_23_0)
	return
end

function var_0_0.resetWhenInitialDeal(arg_24_0)
	for iter_24_0 = 1, #arg_24_0._pGraveCards do
		local var_24_0 = arg_24_0._pGraveCards[iter_24_0]

		if var_24_0 ~= nil then
			var_24_0:removeFromParent()
		end
	end

	arg_24_0._pGraveCards = {}

	for iter_24_1 = 1, #arg_24_0._player._graveCards do
		local var_24_1 = arg_24_0._player._graveCards[iter_24_1]

		if var_24_1 ~= nil then
			local var_24_2 = arg_24_0:getCardSprite(var_24_1)

			arg_24_0._pGraveCards[iter_24_1] = var_24_2
		end
	end

	for iter_24_2 = 1, #arg_24_0._player._rareCards do
		local var_24_3 = arg_24_0._player._rareCards[iter_24_2]
		local var_24_4 = arg_24_0:createCardSprite(var_24_3)

		arg_24_0._battleUi:addChild(var_24_4)

		arg_24_0._pRareCards[iter_24_2] = var_24_4
	end

	arg_24_0:updateFortressHp()

	local var_24_5 = arg_24_0:getLabelColor(arg_24_0._player._fortress._hp, arg_24_0._player._fortress._maxHp)

	arg_24_0._pHpLabel:setColor(var_24_5)
	arg_24_0:updateGraveArea()
	arg_24_0:updateRareArea()
end

function var_0_0.start(arg_25_0)
	return
end

function var_0_0.finish(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._player:getResult()

	if var_26_0 == Data.BattleResult.lose then
		if arg_26_0._player._fortress._type == Data.CardType.boss then
			arg_26_1 = arg_26_0:playAction(nil, var_0_0.Action.boss_die, arg_26_1)
		else
			arg_26_1 = arg_26_0:playAction(nil, var_0_0.Action.fortress_die, arg_26_1)
		end
	elseif var_26_0 == Data.BattleResult.win then
		if arg_26_0._opponentUi._player._fortress._type == Data.CardType.boss then
			arg_26_1 = arg_26_0._opponentUi:playAction(nil, var_0_0.Action.boss_die, arg_26_1)
		else
			arg_26_1 = arg_26_0._opponentUi:playAction(nil, var_0_0.Action.fortress_die, arg_26_1)
		end
	end

	return arg_26_1
end

function var_0_0.forward(arg_27_0)
	arg_27_0._battleUi:stopAllActions()

	for iter_27_0 = 1, #arg_27_0._player._handCards do
		local var_27_0 = arg_27_0._player._handCards[iter_27_0]
		local var_27_1 = arg_27_0:createCardSprite(var_27_0)

		arg_27_0._pHandCards[var_27_0._pos] = var_27_1

		arg_27_0._battleUi:addChild(var_27_1)
	end

	arg_27_0:doReorderHand()

	for iter_27_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_27_2 = arg_27_0._player._boardCards[iter_27_1]

		if var_27_2 ~= nil and var_27_2._type ~= Data.CardType.boss then
			local var_27_3 = arg_27_0:createCardSprite(var_27_2)

			arg_27_0._pBoardCards[var_27_2._pos] = var_27_3

			arg_27_0._battleUi:addChild(var_27_3)
			var_27_3:updateZOrder()
		end
	end

	arg_27_0:switchBoard(arg_27_0._player._boardCards[Data.MAX_CARD_COUNT_ON_BOARD + 1] == nil)
	arg_27_0:doReorderBoard()
	arg_27_0._opponentUi:doReorderBoard()

	for iter_27_2 = 1, #arg_27_0._player._graveCards do
		local var_27_4 = arg_27_0._player._graveCards[iter_27_2]
		local var_27_5 = arg_27_0:createCardSprite(var_27_4)

		arg_27_0._battleUi:addChild(var_27_5)

		arg_27_0._pGraveCards[iter_27_2] = var_27_5
	end

	for iter_27_3 = 1, #arg_27_0._player._rareCards do
		local var_27_6 = arg_27_0._player._rareCards[iter_27_3]
		local var_27_7 = arg_27_0:createCardSprite(var_27_6)

		arg_27_0._battleUi:addChild(var_27_7)

		arg_27_0._pRareCards[iter_27_3] = var_27_7
	end

	for iter_27_4 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		local var_27_8 = arg_27_0._player._coverCards[iter_27_4]

		if var_27_8 then
			local var_27_9 = arg_27_0:createCardSprite(var_27_8)

			arg_27_0._battleUi:addChild(var_27_9)

			arg_27_0._pCoverCards[var_27_8._pos] = var_27_9
			var_27_9._default._position = arg_27_0._coverPos[var_27_8._pos]

			var_27_9:initCover()
			var_27_9:setPosition(var_27_9._default._position)
		end
	end

	for iter_27_5 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		local var_27_10 = arg_27_0._player._showCards[iter_27_5]

		if var_27_10 then
			local var_27_11 = arg_27_0:createCardSprite(var_27_10)

			arg_27_0._battleUi:addChild(var_27_11)

			arg_27_0._pShowCards[var_27_10._pos] = var_27_11
			var_27_11._default._position = arg_27_0._coverPos[var_27_10._pos]

			var_27_11:initShow()
			var_27_11:setPosition(var_27_11._default._position)
		end
	end

	local var_27_12 = arg_27_0._player._fieldCard

	if var_27_12 then
		local var_27_13 = arg_27_0:createCardSprite(var_27_12)

		arg_27_0._battleUi:addChild(var_27_13)

		arg_27_0._pFieldCard = var_27_13
		var_27_13._default._position = arg_27_0._coverPos[Data.MAX_CARD_COUNT_ON_COVER + 1]

		var_27_13:initField()
		var_27_13:setPosition(var_27_13._default._position)
	end

	arg_27_0:updateFortressHp()

	local var_27_14 = arg_27_0:getLabelColor(arg_27_0._player._fortress._hp, arg_27_0._player._fortress._maxHp)

	arg_27_0._pHpLabel:setColor(var_27_14)
	arg_27_0:updateFortressSkill()

	if arg_27_0._player == arg_27_0._player:getActionPlayer() then
		arg_27_0:updateGem()
	end

	arg_27_0:sendEvent(var_0_0.EventType.update_card_pile_count)
	arg_27_0._battleUi:updateCardZOrder()
	arg_27_0:updateGraveArea()
	arg_27_0:updateRareArea()
	arg_27_0:updateBoardCardsActive()
end

function var_0_0.roundBegin(arg_28_0)
	arg_28_0:resetWhenRoundBegin()
	arg_28_0:updateGem()
	arg_28_0:updateFortressHp()
end

function var_0_0.roundEnd(arg_29_0, arg_29_1)
	arg_29_0:updateGem()

	return arg_29_1
end

function var_0_0.action(arg_30_0)
	arg_30_0:updateGem()
end

function var_0_0.getCardSprite(arg_31_0, arg_31_1)
	if arg_31_1 == nil then
		return nil
	end

	if arg_31_0._player._fortress._type == Data.CardType.boss and arg_31_1._id == arg_31_0._player._fortress._id then
		return arg_31_0._boss
	end

	return arg_31_0._cardSprites[arg_31_1._id]
end

function var_0_0.getHandCardSprite(arg_32_0, arg_32_1)
	for iter_32_0 = 1, Data.MAX_CARD_COUNT_IN_HAND do
		local var_32_0 = arg_32_0._pHandCards[iter_32_0]

		if var_32_0 ~= nil and var_32_0._card == arg_32_1 then
			return var_32_0, iter_32_0
		end
	end

	return nil, 0
end

function var_0_0.getBoardCardSprite(arg_33_0, arg_33_1)
	for iter_33_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_33_0 = arg_33_0._pBoardCards[iter_33_0]

		if var_33_0 ~= nil and var_33_0._card == arg_33_1 then
			return var_33_0, iter_33_0
		end
	end

	return nil, 0
end

function var_0_0.getGraveCardSprite(arg_34_0, arg_34_1)
	for iter_34_0 = 1, #arg_34_0._pGraveCards do
		local var_34_0 = arg_34_0._pGraveCards[iter_34_0]

		if var_34_0 and var_34_0._card == arg_34_1 then
			return var_34_0, iter_34_0
		end
	end

	return nil, 0
end

function var_0_0.getRareCardSprite(arg_35_0, arg_35_1)
	for iter_35_0 = 1, #arg_35_0._pRareCards do
		local var_35_0 = arg_35_0._pRareCards[iter_35_0]

		if var_35_0 ~= nil and var_35_0._card == arg_35_1 then
			return var_35_0, iter_35_0
		end
	end

	return nil, 0
end

function var_0_0.getHandCardSpriteByInfoId(arg_36_0, arg_36_1, arg_36_2)
	for iter_36_0 = 1, Data.MAX_CARD_COUNT_IN_HAND do
		local var_36_0 = arg_36_0._pHandCards[iter_36_0]

		if var_36_0 ~= nil and var_36_0._card:isInfoId(arg_36_1) and (not arg_36_2 or var_36_0._card._isFromEvent) then
			return var_36_0
		end
	end

	return nil
end

function var_0_0.getBoardCardSpriteByInfoId(arg_37_0, arg_37_1, arg_37_2)
	for iter_37_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_37_0 = arg_37_0._pBoardCards[iter_37_0]

		if var_37_0 ~= nil and var_37_0._card:isInfoId(arg_37_1) and (not arg_37_2 or var_37_0._card._isFromEvent) then
			return var_37_0
		end
	end

	return nil
end

function var_0_0.getIsEndAllOperation(arg_38_0)
	return false
end

function var_0_0.getIsMoreOperation(arg_39_0)
	if arg_39_0._battleUi._isAddingBoardCard then
		return false
	end

	if arg_39_0._player:canUseHandCard() then
		return true
	end

	local var_39_0 = arg_39_0._player:getBoardCards()

	for iter_39_0 = 1, #var_39_0 do
		if var_39_0[iter_39_0]:canAction() then
			return true
		end
	end

	return false
end

function var_0_0.getIsShowHandCardActive(arg_40_0)
	if not arg_40_0._battleUi._isOperating then
		return false
	end

	if arg_40_0._battleUi._isAddingBoardCard then
		return false
	end

	return true
end

function var_0_0.calHandCardPosAndRot(arg_41_0, arg_41_1)
	local var_41_0 = #arg_41_0._pHandCards
	local var_41_1 = 0

	for iter_41_0 = 1, Data.MAX_CARD_COUNT_IN_HAND do
		local var_41_2 = arg_41_0._pHandCards[iter_41_0]

		if var_41_2 ~= nil and var_41_2._card._id == arg_41_1._card._id then
			var_41_1 = iter_41_0

			break
		end
	end

	local var_41_3 = 292 - (1 - arg_41_0._battleUi._scale) * 500
	local var_41_4 = var_41_3
	local var_41_5 = var_41_3
	local var_41_6 = -4
	local var_41_7 = ClientView.SCR_W - var_41_4 - var_41_5
	local var_41_8 = ClientView.CARD_SIZE.width * CardSprite.Scale.normal
	local var_41_9 = ClientView.CARD_SIZE.height * CardSprite.Scale.normal
	local var_41_10 = (var_41_7 - var_41_0 * var_41_8) / (var_41_0 + 1)
	local var_41_11 = var_41_4 + var_41_8 / 2 + var_41_10
	local var_41_12 = arg_41_0._isController and var_0_0.Pos.attacker_hand_y or var_0_0.Pos.defender_hand_y

	if arg_41_0._isController then
		var_41_12 = var_41_12 - (1 - arg_41_0._battleUi._scale) * 320

		if ClientData.isIPhoneX() then
			var_41_12 = var_41_12 + 12
		end
	end

	local var_41_13 = (ClientView.SCR_H - var_41_9 * arg_41_0._battleUi._scale) / math.cos(ClientView.BATTLE_ROTATION_X * math.pi / 360) / arg_41_0._battleUi._scale

	if not arg_41_0._battleUi._isObserver and arg_41_0._battleUi._battleType ~= Data.BattleType.replay or not arg_41_0._isController and not arg_41_0._battleUi._isReverse then
		-- block empty
	elseif not arg_41_0._isController and arg_41_0._battleUi._isReverse then
		var_41_12 = ClientView.SCR_H - 13
	elseif arg_41_0._isController and not arg_41_0._battleUi._isReverse then
		var_41_12 = 13
	elseif arg_41_0._isController and arg_41_0._battleUi._isReverse then
		var_41_12 = lc.ch(arg_41_0._battleUi) - 328 - var_41_9 / 2
	end

	if var_41_6 < var_41_10 then
		var_41_11 = var_41_11 + (var_41_10 - var_41_6) * (var_41_0 - 1) / 2
		var_41_10 = var_41_6
	else
		var_41_11 = var_41_11 - var_41_10
		var_41_10 = var_41_10 * (var_41_0 + 1) / (var_41_0 - 1)
	end

	arg_41_1._default._position = cc.p(var_41_11 + (var_41_1 - 1) * (var_41_8 + var_41_10), var_41_12)
	arg_41_1._default._rotation = {
		z = 0,
		y = 0,
		x = arg_41_0._battleUi._battleType == Data.BattleType.layout and 0 or arg_41_0._battleUi._isReverse and -ClientView.BATTLE_ROTATION_X or ClientView.BATTLE_ROTATION_X
	}

	return arg_41_1._default._position, arg_41_1._default._rotation
end

function var_0_0.calBoardCardCount(arg_42_0)
	if arg_42_0._player._isDeamon then
		return 6
	end

	local var_42_0 = Data.MAX_CARD_COUNT_ON_BOARD

	for iter_42_0 = Data.MAX_CARD_COUNT_ON_BOARD, 1, -1 do
		if arg_42_0._pBoardCards[iter_42_0] == nil then
			var_42_0 = var_42_0 - 1
		else
			break
		end
	end

	return var_42_0
end

function var_0_0.calBoardCardStep(arg_43_0)
	local var_43_0 = arg_43_0:calBoardCardCount()

	if var_43_0 == 1 then
		return 76
	else
		return 180 + (5 - var_43_0) * 20
	end
end

function var_0_0.calBoardCardPos(arg_44_0, arg_44_1)
	local var_44_0 = 0

	for iter_44_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_44_1 = arg_44_0._pBoardCards[iter_44_0]

		if var_44_1 and var_44_1._card._id == arg_44_1._card._id then
			var_44_0 = iter_44_0

			break
		end
	end

	local var_44_2 = arg_44_0._isController and var_0_0.Pos.attacker_board_x or var_0_0.Pos.defender_board_x
	local var_44_3 = arg_44_0._isController and var_0_0.Pos.attacker_board_y or var_0_0.Pos.defender_board_y

	if arg_44_1:isSmall() then
		var_44_3 = var_44_3 + (arg_44_0._isController and (var_44_0 == 6 and var_0_0.Pos.board_pos_dy[1] or -var_0_0.Pos.board_pos_dy[2]) or var_44_0 == 6 and -var_0_0.Pos.board_pos_dy[1] or var_0_0.Pos.board_pos_dy[2])
	end

	arg_44_1._default._position = cc.p(var_44_2[var_44_0], var_44_3)

	return arg_44_1._default._position
end

function var_0_0.calLengthAndAngle(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = math.sqrt((arg_45_1.x - arg_45_2.x) * (arg_45_1.x - arg_45_2.x) + (arg_45_1.y - arg_45_2.y) * (arg_45_1.y - arg_45_2.y))

	if var_45_0 == 0 then
		return 0, 0
	end

	local var_45_1 = math.deg(math.asin((arg_45_2.y - arg_45_1.y) / var_45_0))

	if arg_45_2.x < arg_45_1.x then
		if arg_45_2.y >= arg_45_1.y then
			var_45_1 = 180 - var_45_1
		else
			var_45_1 = -180 - var_45_1
		end
	end

	return var_45_0, var_45_1
end

function var_0_0.updateFortressHp(arg_46_0, arg_46_1)
	arg_46_1 = arg_46_1 or (arg_46_0._player and arg_46_0._player._fortress and arg_46_0._player._fortress._hp) or (arg_46_0._player and arg_46_0._player._fortressHp) or 8000

	if (not arg_46_0._player._fortressHp or arg_46_0._player._fortressHp == 0) and not (arg_46_0._player and arg_46_0._player._fortress and arg_46_0._player._fortress._hp) then
		arg_46_0._pHpLabel:setString("8000")
	else
		ClientView.updateValueLabel(arg_46_0._pHpLabel, arg_46_1, nil, 1.4)
	end
end

function var_0_0.updateFortressAtk(arg_47_0, arg_47_1)
	arg_47_1 = arg_47_1 ~= nil and arg_47_1 or arg_47_0._player._fortress._atk

	arg_47_0._pAtkLabel:setString(arg_47_1)
end

function var_0_0.updateFortressSkill(arg_48_0)
	return
end

function var_0_0.updateGem(arg_49_0)
	return
end

function var_0_0.updateBoardLocks(arg_50_0)
	local var_50_0 = arg_50_0._player._fortress:getBuffValue(false, BattleData.NegativeType.boardLock)
	local var_50_1 = {}

	if type(var_50_0) == "table" then
		for iter_50_0 = 1, #var_50_0 do
			var_50_1[var_50_0[iter_50_0]] = true
		end
	end

	for iter_50_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		if var_50_1[iter_50_1] then
			if not arg_50_0._boardLockIcons[iter_50_1]:isVisible() then
				local var_50_2 = arg_50_0:efcDragonBones2("cdtx", "effect", 1, true)
				local var_50_3, var_50_4 = arg_50_0._boardLockIcons[iter_50_1]:getPosition()

				lc.addChildToPos(arg_50_0._battleUi, var_50_2, cc.p(var_50_3 + 20, var_50_4 - 20))
				arg_50_0._boardLockIcons[iter_50_1]:setOpacity(255)
				arg_50_0._boardLockIcons[iter_50_1]:setVisible(true)
			end
		elseif arg_50_0._boardLockIcons[iter_50_1]:isVisible() then
			arg_50_0._boardLockIcons[iter_50_1]:runAction(lc.sequence(lc.fadeOut(0.5), lc.hide()))
		end
	end
end

function var_0_0.updateCardsActive(arg_51_0)
	if not arg_51_0._isController then
		return
	end

	if arg_51_0:getIsShowHandCardActive() then
		local var_51_0 = arg_51_0._player

		for iter_51_0, iter_51_1 in ipairs(arg_51_0._pHandCards) do
			local var_51_1 = iter_51_1._card

			if var_51_1:isMonsterRare() then
				iter_51_1:updateActive(var_51_0:canUseMonster(var_51_1, false))
			elseif var_51_1._type == Data.CardType.magic then
				iter_51_1:updateActive(var_51_0:canUseMagic(var_51_1, false))
			elseif var_51_1._type == Data.CardType.trap then
				iter_51_1:updateActive(var_51_0:canUseTrap(var_51_1, false))
			else
				iter_51_1:updateActive(true)
			end
		end
	else
		for iter_51_2, iter_51_3 in ipairs(arg_51_0._pHandCards) do
			iter_51_3:updateActive(false)
		end
	end
end

function var_0_0.updateBoardCardsActive(arg_52_0)
	for iter_52_0, iter_52_1 in pairs(arg_52_0._pBoardCards) do
		iter_52_1:updateBoardActive()
	end
end

function var_0_0.updateFortressActive(arg_53_0, arg_53_1)
	if arg_53_1 then
		if arg_53_0._boardGlow == nil then
			local var_53_0 = lc.createNode()

			lc.addChildToCenter(arg_53_0._avatarFrame, var_53_0, -1)
			arg_53_0._battleUi:createDragonBones("gjxz", cc.p(100, 60), var_53_0, "effect", false, 1)

			arg_53_0._boardGlow = var_53_0

			local var_53_1 = lc.rep(lc.sequence(cc.ScaleTo:create(0.4, 1.03), cc.ScaleTo:create(0.4, 1)))

			var_53_1:setTag(255)
			arg_53_0._avatarFrame:runAction(var_53_1)
		end
	elseif arg_53_0._boardGlow ~= nil then
		arg_53_0._boardGlow:removeFromParent()

		arg_53_0._boardGlow = nil

		arg_53_0._avatarFrame:stopActionByTag(255)
		arg_53_0._avatarFrame:setScale(1)
	end
end

function var_0_0.updateBoardCardsInitialSkills(arg_54_0)
	if arg_54_0._isController and arg_54_0._player == arg_54_0._player:getActionPlayer() and arg_54_0._battleUi._dropLayer == nil and not arg_54_0._battleUi._isAuto then
		arg_54_0._battleUi._btnInitiative:setEnabled(#arg_54_0._player:getBattleCardsByCanCastInitiativeSkill("BSDGHL", nil, nil, true) > 0)

		local var_54_0 = #arg_54_0._player:getBattleCardsByCanCastInitiativeSkill("R", nil, nil, true) > 0

		arg_54_0._battleUi._btnRare:setEnabled(var_54_0)
		arg_54_0._battleUi._btnRare2:setEnabled(var_54_0)
	else
		arg_54_0._battleUi._btnInitiative:setEnabled(false)
		arg_54_0._battleUi._btnRare:setEnabled(false)
		arg_54_0._battleUi._btnRare2:setEnabled(false)
	end

	if arg_54_0._battleUi._btnInitiative:isEnabled() then
		if arg_54_0._battleUi._btnInitiative._particle == nil then
			arg_54_0._battleUi._btnInitiative._particle = arg_54_0:efcParticle("zhudong", cc.p(34, 18), true, false, arg_54_0._battleUi._btnInitiative)
		end
	elseif arg_54_0._battleUi._btnInitiative._particle ~= nil then
		arg_54_0._battleUi._btnInitiative._particle:removeFromParent()

		arg_54_0._battleUi._btnInitiative._particle = nil
	end

	if arg_54_0._battleUi._btnRare:isEnabled() then
		if arg_54_0._battleUi._btnRare._particle == nil then
			arg_54_0._battleUi._btnRare._particle = arg_54_0:efcParticle("zhudong", cc.p(34, 18), true, false, arg_54_0._battleUi._btnRare)
		end
	elseif arg_54_0._battleUi._btnRare._particle ~= nil then
		arg_54_0._battleUi._btnRare._particle:removeFromParent()

		arg_54_0._battleUi._btnRare._particle = nil
	end

	if arg_54_0._battleUi._btnRare2:isEnabled() then
		if arg_54_0._battleUi._btnRare2._particle == nil then
			arg_54_0._battleUi._btnRare2._particle = arg_54_0:efcParticle("zhudong", cc.p(34, 18), true, false, arg_54_0._battleUi._btnRare2)
		end
	elseif arg_54_0._battleUi._btnRare2._particle ~= nil then
		arg_54_0._battleUi._btnRare2._particle:removeFromParent()

		arg_54_0._battleUi._btnRare2._particle = nil
	end

	for iter_54_0, iter_54_1 in pairs(arg_54_0._pBoardCards) do
		iter_54_1:updateInitiativeSkills()
	end
end

function var_0_0.castInitiativeSkill(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_0:getCardSprite(arg_55_1) or arg_55_0._opponentUi:getCardSprite(arg_55_1)

	if var_55_0 == nil and arg_55_1._status == BattleData.CardStatus.leave then
		var_55_0 = arg_55_0:createCardSprite(arg_55_1)

		arg_55_0:hideCardSprite(var_55_0)
	end

	local var_55_1, var_55_2, var_55_3 = arg_55_1._owner:isGraveSkill(arg_55_2, nil, true)
	local var_55_4 = arg_55_1:getSkillIndex(arg_55_2)

	if arg_55_1:hasSkills({
		7144,
		7373
	}) or arg_55_1._status == BattleData.CardStatus.board and arg_55_1:hasSkills({
		2243,
		2318
	}) or arg_55_1._status == BattleData.CardStatus.hand and arg_55_1:hasSkills({
		2982
	}) or arg_55_1._status == BattleData.CardStatus.grave and arg_55_1:hasSkills({
		2985
	}) or arg_55_2._id == 3705 or arg_55_2._id == 3850 or arg_55_2._id == 2324 or arg_55_2._id == 4978 or arg_55_2._id == 4980 or arg_55_2._id == 5430 or arg_55_2._id == 5431 or arg_55_2._id == 5452 or arg_55_2._id == 5470 or arg_55_2._id == 5485 or arg_55_2._id == 5544 or arg_55_2._id == 5549 or arg_55_2._id == 7673 or arg_55_2._id == 7674 or arg_55_2._id == 7732 or arg_55_2._id == 7785 or arg_55_2._id == 7831 or arg_55_2._id == 9796 or arg_55_2._id == 9868 or arg_55_2._id == 13119 or arg_55_2._id == 13259 or arg_55_2._id == 13264 or arg_55_2._id == 13292 or arg_55_2._id == 13348 or arg_55_2._id == 13718 or arg_55_2._id == 13736 or arg_55_2._id == 13850 or arg_55_2._id == 13920 or arg_55_2._id == 13989 or arg_55_2._id == 14390 or arg_55_2._id == 14519 or arg_55_2._id == 14487 or arg_55_2._id == 14541 or arg_55_2._id == 14555 then
		arg_55_0:showChoiceMerge(var_55_0, nil, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 7576 then
		arg_55_0:showChoiceCeremony(var_55_0, nil, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_1._status == BattleData.CardStatus.rare and arg_55_1:hasSkills({
		3874,
		3885,
		2375
	}) then
		local var_55_5 = arg_55_1
		local var_55_6 = B.sortCardsByBoardPos(arg_55_0._player:getMergeCandidatesByTriggerCard(var_55_5, var_55_0._card))

		arg_55_0:showChoiceGrave(var_55_0, nil, var_55_6, #Data._rareInfo[var_55_5._infoId]._joinComponent, var_55_4 * BattleData.ChoiceId.stage_3 + 1, var_55_5)
	elseif arg_55_1:hasSkills({
		2437,
		2560,
		3940,
		6349,
		9453,
		9462
	}) then
		arg_55_0:showChoiceSync(var_55_0, nil, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 2611 then
		arg_55_0:showChoiceSync(var_55_0, nil, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_1._status == BattleData.CardStatus.board and arg_55_1:hasSkillFast(2781) then
		arg_55_0:showChoiceSync(var_55_0, nil, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_1._status == BattleData.CardStatus.board and arg_55_1:hasSkillFast(9685) then
		arg_55_0:showChoiceSync(var_55_0, nil, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 9507 or arg_55_2._id == 13007 or arg_55_2._id == 7824 then
		arg_55_0:showChoiceSync(var_55_0, nil, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_1._status == BattleData.CardStatus.rare and arg_55_2._id == 3851 then
		local var_55_7 = arg_55_1
		local var_55_8 = B.sortCardsByBoardPos(arg_55_0._player:getSyncCandidatesByTriggerCard(var_55_7, var_55_7))

		arg_55_0:showChoiceGrave(var_55_0, nil, var_55_8, #Data._rareInfo[var_55_7._infoId]._joinComponent, var_55_4 * BattleData.ChoiceId.stage_3 + 1, var_55_7)
	elseif arg_55_1._status == BattleData.CardStatus.rare and arg_55_2._id == 6753 then
		local var_55_9 = arg_55_1
		local var_55_10 = B.sortCardsByBoardPos(arg_55_0._player:getXYZCandidatesByTriggerCard(var_55_9, var_55_9))

		arg_55_0:showChoiceGrave(var_55_0, nil, var_55_10, #Data._rareInfo[var_55_9._infoId]._joinComponent, var_55_4 * BattleData.ChoiceId.stage_3 + 1, var_55_9)
	elseif arg_55_1._status == BattleData.CardStatus.rare and arg_55_2._id == 9298 then
		local var_55_11 = arg_55_1
		local var_55_12

		if arg_55_1._infoId == 40551 or arg_55_1._infoId == 40692 or arg_55_1._infoId == 40713 then
			var_55_12 = B.sortCardsByOwnerAndBoardPos(arg_55_0._player:getLinkCandidatesByTriggerCard(var_55_11, var_55_11), var_55_11._owner._isAttacker)
		else
			var_55_12 = B.sortCardsByBoardPos(arg_55_0._player:getLinkCandidatesByTriggerCard(var_55_11, var_55_11))
		end

		arg_55_0:showChoiceGrave(var_55_0, nil, var_55_12, var_55_11._linkCountNode._subNodes[2]:value(), var_55_4 * BattleData.ChoiceId.stage_3 + 1, var_55_11)
	elseif arg_55_1:hasSkillFast(9431) then
		arg_55_0:showChoiceNumber(var_55_0, nil, 1, math.min(3, #arg_55_0._player._pileCards), var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 9537 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 1, 6, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 9714 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 1, 3, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 7480 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 1, 6, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 8116 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 5, 9, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 13153 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 4, 5, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 13240 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 3, 5, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 13831 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 1, 8, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 13899 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 7, 8, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 13980 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 1, 4, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 14095 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 1, 8, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 14386 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 1, 12, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif arg_55_2._id == 7791 then
		arg_55_0:showChoiceNumber(var_55_0, nil, 4, 5, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif var_55_1 then
		arg_55_0:showChoiceGrave(var_55_0, nil, var_55_2, var_55_3, var_55_4 * BattleData.ChoiceId.stage_3)
	elseif B.isSkillChoiceSkill(arg_55_2) then
		arg_55_0:showChoiceSkill(var_55_0, nil, nil, var_55_4 * BattleData.ChoiceId.stage_3)
	else
		return arg_55_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_55_1,
			_choice = var_55_4 * BattleData.ChoiceId.stage_3
		})
	end
end

function var_0_0.getMaskCardSprites(arg_56_0)
	local var_56_0 = {}

	for iter_56_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_56_1 = arg_56_0._pBoardCards[iter_56_0]

		if var_56_1 ~= nil and var_56_1._mask then
			table.insert(var_56_0, var_56_1._mask)
		end
	end

	return var_56_0
end

function var_0_0.updateGraveArea(arg_57_0)
	local var_57_0 = #arg_57_0._pGraveCards

	arg_57_0._pGraveLabel:setVisible(var_57_0 > 0)
	arg_57_0._pGraveLabel:setString(var_57_0)

	for iter_57_0 = 1, var_57_0 do
		arg_57_0._pGraveCards[iter_57_0]:setVisible(iter_57_0 == var_57_0)
	end
end

function var_0_0.updateRareArea(arg_58_0)
	local var_58_0 = #arg_58_0._pRareCards

	arg_58_0._pRareLabel:setVisible(var_58_0 > 0 and (arg_58_0._isController or arg_58_0._battleUi._isObserver))
	arg_58_0._pRareLabel:setString(var_58_0)

	for iter_58_0 = 1, var_58_0 do
		arg_58_0._pRareCards[iter_58_0]:setVisible(iter_58_0 == var_58_0)
	end
end

function var_0_0.createChoiceMaskLayer(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	local var_59_0 = lc.createMaskLayer(200, lc.Color3B.black, ClientView.SCR_SIZE)

	lc.addChildToPos(arg_59_0._scene, var_59_0, cc.p(0, 0), BattleScene.ZOrder.form)

	var_59_0._pCard = arg_59_1
	var_59_0._pTargetCard = arg_59_2
	var_59_0._skill = arg_59_3
	var_59_0._choiceBase = arg_59_4 or 0

	var_59_0:addTouchEventListener(function(arg_60_0, arg_60_1)
		if arg_60_1 == ccui.TouchEventType.ended then
			arg_60_0:cancelChoice(sender)
		end
	end)

	arg_59_0._battleUi._choiceMaskLayer = var_59_0

	function var_59_0.cancelChoice(arg_61_0)
		local var_61_0 = arg_61_0._pCard
		local var_61_1 = arg_61_0._pTargetCard

		if var_61_0._card._status == BattleData.CardStatus.hand then
			var_61_0:setVisible(true)
			arg_59_0:playAction(var_61_0, var_0_0.Action.replace_hand_card, 0, 1)
		end

		arg_61_0:endChoice()
	end

	function var_59_0.endChoice(arg_62_0)
		arg_59_0._battleUi._choiceMaskLayer = nil

		arg_62_0:removeFromParent()
	end

	if arg_59_1._card._status == BattleData.CardStatus.hand then
		arg_59_1:setVisible(false)
	end

	arg_59_0._choiceBtns = {}

	return var_59_0
end

function var_0_0.showChoiceSummon(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_1._card
	local var_63_1 = var_63_0._owner
	local var_63_2, var_63_3, var_63_4, var_63_5 = var_63_1:canUseMonsterSpecific(var_63_0)

	if var_63_2 then
		return arg_63_0:showChoiceSkill(arg_63_1, arg_63_2, nil, var_63_4)
	end

	local var_63_6, var_63_7, var_63_8, var_63_9 = var_63_1:canUseMonsterSpecial(var_63_0)

	if not var_63_6 and not var_63_0:hasNoGemSkill() then
		return arg_63_0:showChoiceSacrifice(arg_63_1, arg_63_2, var_63_0:hasSkillFast(3271) and 4 or 1, nil)
	end

	local var_63_10 = arg_63_0:createChoiceMaskLayer(arg_63_1, arg_63_2, var_63_9, 0)

	function var_63_10.cancelChoice(arg_64_0)
		for iter_64_0 = 1, 2 do
			local var_64_0 = arg_63_0._choiceBtns[iter_64_0]
			local var_64_1 = iter_64_0 == 1 and "effect09" or "effect05"
			local var_64_2 = var_64_0._bones
			local var_64_3 = var_64_2:getAnimationDuration(var_64_1)

			var_64_0:runAction(lc.sequence(function()
				var_64_2:gotoAndPlay(var_64_1)
			end, var_64_3, function()
				if iter_64_0 == 1 then
					local var_66_0 = arg_64_0._pCard
					local var_66_1 = arg_64_0._pTargetCard

					var_66_0:setVisible(true)
					arg_63_0:playAction(var_66_0, var_0_0.Action.replace_hand_card, 0, 1)
					arg_64_0:endChoice()
				end
			end))
		end
	end

	local var_63_11 = ClientView.createTTF(Str(STR.CHOICE_TITLE_SPECIAL_SUMMON), ClientView.FontSize.M1)

	var_63_11:runAction(lc.rep(lc.sequence(lc.scaleTo(1.5, 1.05), lc.scaleTo(1.5, 1))))
	lc.addChildToPos(var_63_10, var_63_11, cc.p(lc.w(var_63_10) / 2, 700))

	for iter_63_0 = 1, 2 do
		local var_63_12 = ClientView.createShaderButton(nil, function(arg_67_0)
			arg_63_0:onChoiceSummon(arg_67_0, var_63_10)
		end)

		var_63_12._index = iter_63_0

		var_63_12:setContentSize(200, 200)

		arg_63_0._choiceBtns[#arg_63_0._choiceBtns + 1] = var_63_12

		local var_63_13 = "effect01"
		local var_63_14 = iter_63_0 == 1 and "effect06" or "effect02"
		local var_63_15 = iter_63_0 == 1 and "effect07" or "effect03"

		if iter_63_0 == 2 and var_63_0:hasSkills({
			3572,
			3799,
			3811,
			6302,
			6705
		}) then
			var_63_14, var_63_15 = "effect10", "effect11"
		end

		local var_63_16 = arg_63_0:efcDragonBones2("zhxz", var_63_13, 1, false)

		lc.addChildToCenter(var_63_12, var_63_16)

		var_63_12._bones = var_63_16

		local var_63_17 = var_63_16:getAnimationDuration(var_63_13)
		local var_63_18 = var_63_16:getAnimationDuration(var_63_14)

		var_63_16:runAction(lc.sequence(var_63_17, function()
			var_63_16:gotoAndPlay(var_63_14)
		end, var_63_18, function()
			var_63_16:gotoAndPlay(var_63_15)
		end))
	end

	lc.addNodesToCenter(var_63_10, arg_63_0._choiceBtns, 400)
end

function var_0_0.onChoiceSummon(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = arg_70_1._index
	local var_70_1 = arg_70_2._pCard._card

	for iter_70_0 = 1, 2 do
		local var_70_2 = arg_70_0._choiceBtns[iter_70_0]
		local var_70_3 = var_70_2 == arg_70_1 and (iter_70_0 == 1 and "effect08" or "effect04") or iter_70_0 == 1 and "effect09" or "effect05"

		if iter_70_0 == 2 and var_70_1:hasSkills({
			3572,
			3799,
			3811,
			6302
		}) then
			var_70_3 = "effect12"
		end

		local var_70_4 = var_70_2._bones
		local var_70_5 = var_70_4:getAnimationDuration(var_70_3)

		var_70_2:runAction(lc.sequence(function()
			var_70_4:gotoAndPlay(var_70_3)
		end, var_70_5, function()
			if iter_70_0 == 1 then
				local var_72_0 = arg_70_2._pCard
				local var_72_1 = arg_70_2._pTargetCard

				var_72_0:setVisible(true)
				arg_70_2:endChoice()

				if var_70_0 == 1 then
					if not arg_70_0._player:canUseMonsterNormal(var_72_0._card) then
						arg_70_0:sendEvent(var_0_0.EventType.dialog_not_enough_gem)
						arg_70_0:playAction(var_72_0, var_0_0.Action.replace_hand_card, 0, 1)
					else
						if var_72_0._card:hasSkills({
							3537,
							3896
						}) then
							local var_72_2, var_72_3, var_72_4, var_72_5 = var_72_0._card._owner:isGraveSkill(var_72_0._card._skills[1], nil, false)

							if var_72_2 then
								return arg_70_0:showChoiceGrave(var_72_0, var_72_1, var_72_3, var_72_4, var_70_0)
							end
						end

						return arg_70_0:showChoiceSacrifice(var_72_0, var_72_1, var_70_0, nil)
					end
				elseif var_72_0._card:hasSkills({
					3572,
					6302
				}) then
					if not arg_70_0._player:canUseMonsterNormal(var_72_0._card, false, false, -2) then
						arg_70_0:sendEvent(var_0_0.EventType.dialog_not_enough_gem)
						arg_70_0:playAction(var_72_0, var_0_0.Action.replace_hand_card, 0, 1)
					else
						arg_70_0:sendEvent(var_0_0.EventType.send_use_card, {
							_choice = 5,
							_card = var_72_0._card,
							_target = var_72_1 ~= nil and var_72_1._card or nil
						})
					end
				elseif var_72_0._card:hasSkillFast(3799) then
					if not arg_70_0._player:canUseMonsterNormalToOppo(var_72_0._card) then
						arg_70_0:sendEvent(var_0_0.EventType.dialog_not_enough_gem)
						arg_70_0:playAction(var_72_0, var_0_0.Action.replace_hand_card, 0, 1)
					else
						return arg_70_0:showChoiceSacrifice(var_72_0, var_72_1, 4, nil)
					end
				elseif var_72_0._card:hasSkillFast(3811) then
					if not arg_70_0._player:canUseMonsterNormal(var_72_0._card, false, false, -1) then
						arg_70_0:sendEvent(var_0_0.EventType.dialog_not_enough_gem)
						arg_70_0:playAction(var_72_0, var_0_0.Action.replace_hand_card, 0, 1)
					else
						return arg_70_0:showChoiceSacrifice(var_72_0, var_72_1, 5, -1)
					end
				elseif not arg_70_0._player:canUseMonsterSpecial(var_72_0._card) then
					arg_70_0:sendEvent(var_0_0.EventType.dialog_special_summon_invalid)
					arg_70_0:playAction(var_72_0, var_0_0.Action.replace_hand_card, 0, 1)
				elseif var_72_0._card:hasSkillFast(3896) then
					return arg_70_0:sendEvent(var_0_0.EventType.send_use_card, {
						_card = var_72_0._card,
						_target = var_72_1 ~= nil and var_72_1._card or nil,
						_choice = var_70_0
					})
				else
					local var_72_6 = var_72_0._card:hasSkills({
						3492,
						3537
					}) and 2 or 1
					local var_72_7, var_72_8, var_72_9, var_72_10 = var_72_0._card._owner:isGraveSkill(var_72_0._card._skills[var_72_6], nil, false)

					if var_72_7 then
						return arg_70_0:showChoiceGrave(var_72_0, var_72_1, var_72_8, var_72_9, var_70_0)
					elseif var_72_0._card:hasSkills({
						3491,
						3651
					}) then
						return arg_70_0:sendEvent(var_0_0.EventType.send_use_card, {
							_card = var_72_0._card,
							_target = var_72_1 ~= nil and var_72_1._card or nil,
							_choice = var_70_0
						})
					else
						return arg_70_0:showChoiceSkill(var_72_0, var_72_1, nil, var_70_0)
					end
				end
			end
		end))
	end
end

function var_0_0.showChoiceMerge(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	local var_73_0 = arg_73_0:createChoiceMaskLayer(arg_73_1, arg_73_2, arg_73_1._card._skills[1], arg_73_3 or 0)
	local var_73_1 = ClientView.createTTF(Str(STR.CHOICE_TITLE_MERGE), ClientView.FontSize.M1)

	var_73_1:runAction(lc.rep(lc.sequence(lc.scaleTo(1.5, 1.05), lc.scaleTo(1.5, 1))))
	lc.addChildToPos(var_73_0, var_73_1, cc.p(lc.w(var_73_0) / 2, 700))

	local var_73_2 = require("CardInfoPanel")
	local var_73_3 = arg_73_0._player:getValidMergeResultInfoIdsByTriggerCard(arg_73_1._card, (arg_73_1._card._infoId == 30429 or arg_73_1._card._infoId == 21067) and math.floor(arg_73_3 / BattleData.ChoiceId.stage_3) or (arg_73_1._card._infoId == 20991 or arg_73_1._card._infoId == 30113 or arg_73_1._card._infoId == 30442 or arg_73_1._card._infoId == 30467 or arg_73_1._card._infoId == 30469 or arg_73_1._card._infoId == 30510 or arg_73_1._card:isSkillAtIndex(13264, math.floor((arg_73_3 or 0) / BattleData.ChoiceId.stage_3)) or arg_73_1._card:isSkillAtIndex(7732, math.floor((arg_73_3 or 0) / BattleData.ChoiceId.stage_3)) or arg_73_1._card:isSkillAtIndex(7785, math.floor((arg_73_3 or 0) / BattleData.ChoiceId.stage_3)) or arg_73_1._card:isSkillAtIndex(7831, math.floor((arg_73_3 or 0) / BattleData.ChoiceId.stage_3)) or arg_73_1._card:isSkillAtIndex(14487, math.floor((arg_73_3 or 0) / BattleData.ChoiceId.stage_3)) or arg_73_1._card:isSkillAtIndex(14541, math.floor((arg_73_3 or 0) / BattleData.ChoiceId.stage_3))) and 2 or nil)

	for iter_73_0 = 1, #var_73_3 do
		local var_73_4 = ccui.Layout:create()

		var_73_4:setAnchorPoint(0.5, 0.5)
		var_73_4:setContentSize(ClientView.CARD_SIZE.width, ClientView.CARD_SIZE.height + 100)

		local var_73_5 = ClientView.createShaderButton(nil, function(arg_74_0)
			var_73_2.create(var_73_3[iter_73_0], 1, var_73_2.OperateType.na):show()
		end)

		var_73_5:setContentSize(ClientView.CARD_SIZE)
		lc.addChildToPos(var_73_4, var_73_5, cc.p(lc.cw(var_73_4), lc.h(var_73_4) - lc.ch(var_73_5)))

		local var_73_6 = B.createCard(var_73_3[iter_73_0], 1)

		var_73_6._originOwner = arg_73_0._player

		local var_73_7 = CardSprite.create(var_73_6, arg_73_0)

		var_73_7:initNormal()
		var_73_7:setRotation3D({
			z = 0,
			x = 0,
			y = 0
		})
		var_73_7._pCardArea:setScale(1)
		var_73_7:setCameraMask(1)
		lc.addChildToCenter(var_73_5, var_73_7)

		local var_73_8 = arg_73_0:efcDragonBones2("xuanzhong", "effect1", 2, false)

		lc.addChildToCenter(var_73_7, var_73_8, -1)

		local var_73_9 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_75_0)
			arg_73_0:onChoiceMerge(arg_75_0, var_73_0)
		end, ClientView.CRECT_BUTTON, 150)

		var_73_9._index = iter_73_0

		var_73_9:addLabel(Str(STR.SELECT))
		lc.addChildToPos(var_73_4, var_73_9, cc.p(lc.cw(var_73_4), lc.ch(var_73_9)))

		arg_73_0._choiceBtns[#arg_73_0._choiceBtns + 1] = var_73_4
	end

	local var_73_10 = 40

	if (ClientView.CARD_SIZE.width + var_73_10) * #arg_73_0._choiceBtns < ClientView.SCR_W then
		lc.addNodesToCenter(var_73_0, arg_73_0._choiceBtns, var_73_10)
	else
		local var_73_11 = lc.List.createH(cc.size(ClientView.SCR_W, ClientView.CARD_SIZE.height + 200), var_73_10, var_73_10)

		var_73_11:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToCenter(var_73_0, var_73_11)
		lc.offset(var_73_11, 0, -30)

		for iter_73_1 = 1, #arg_73_0._choiceBtns do
			var_73_11:pushBackCustomItem(arg_73_0._choiceBtns[iter_73_1])
		end
	end
end

function var_0_0.onChoiceMerge(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0 = arg_76_1._index
	local var_76_1 = arg_76_2._pCard
	local var_76_2 = arg_76_2._pTargetCard
	local var_76_3 = arg_76_2._choiceBase

	var_76_1:setVisible(true)
	arg_76_2:endChoice()

	local var_76_4 = arg_76_0._player:getValidMergeResultInfoIdsByTriggerCard(var_76_1._card, (var_76_1._card._infoId == 30429 or var_76_1._card._infoId == 21067) and math.floor(var_76_3 / BattleData.ChoiceId.stage_3) or (var_76_1._card._infoId == 20991 or var_76_1._card._infoId == 30113 or var_76_1._card._infoId == 30442 or var_76_1._card._infoId == 30467 or var_76_1._card._infoId == 30469 or var_76_1._card._infoId == 30510 or var_76_1._card:isSkillAtIndex(7732, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(7785, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(7831, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(14487, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(14541, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3))) and 2 or nil)[var_76_0]
	local var_76_5 = arg_76_0._player:getBattleCardsByInfoId("R", var_76_4)[1]
	local var_76_6 = B.sortCardsByBoardPos(arg_76_0._player:getMergeCandidatesByTriggerCard(var_76_5, var_76_1._card, (var_76_1._card._infoId == 30429 or var_76_1._card._infoId == 21067) and math.floor(var_76_3 / BattleData.ChoiceId.stage_3) or (var_76_1._card._infoId == 20991 or var_76_1._card._infoId == 30113 or var_76_1._card._infoId == 30442 or var_76_1._card._infoId == 30467 or var_76_1._card._infoId == 30469 or var_76_1._card._infoId == 30510 or var_76_1._card:isSkillAtIndex(13264, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(7732, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(7785, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(7831, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(14487, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3)) or var_76_1._card:isSkillAtIndex(14541, math.floor((var_76_3 or 0) / BattleData.ChoiceId.stage_3))) and 2 or nil))

	if var_76_0 >= 10 then
		var_76_0 = var_76_0 * 10
	end

	arg_76_0:showChoiceGrave(var_76_1, var_76_2, var_76_6, #Data._rareInfo[var_76_4]._joinComponent, var_76_0 + var_76_3, var_76_5)
end

function var_0_0.showChoiceCeremony(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	if arg_77_1._card:hasSkills({
		4199,
		4388,
		4576
	}) and arg_77_3 == 0 then
		return arg_77_0:showChoiceSkill(arg_77_1, arg_77_2, nil, 0)
	end

	local var_77_0 = arg_77_0:createChoiceMaskLayer(arg_77_1, arg_77_2, arg_77_1._card._skills[1], arg_77_3)
	local var_77_1

	if arg_77_1._card._skills[1]._id ~= 4382 then
		var_77_1 = ClientView.createTTF(Str(STR.CHOICE_TITLE_CEREMONY, ClientView.FontSize.M1))
	else
		var_77_1 = ClientView.createTTF(string.format(Str(STR.CHOICE_TITLE_CHOICE), 1), ClientView.FontSize.M1)
	end

	var_77_1:runAction(lc.rep(lc.sequence(lc.scaleTo(1.5, 1.05), lc.scaleTo(1.5, 1))))
	lc.addChildToPos(var_77_0, var_77_1, cc.p(lc.w(var_77_0) / 2, 700))

	local var_77_2 = require("CardInfoPanel")
	local var_77_3 = arg_77_0._player:getValidCeremonyResultCardsByTriggerCard(arg_77_1._card)
	local var_77_4 = math.floor(arg_77_3 / BattleData.ChoiceId.stage_3)

	for iter_77_0 = 1, #var_77_3 do
		if arg_77_0._player:isValidCeremonyResultByTriggerCard(var_77_3[iter_77_0], arg_77_1._card, var_77_4) then
			local var_77_5 = ccui.Layout:create()

			var_77_5:setAnchorPoint(0.5, 0.5)
			var_77_5:setContentSize(ClientView.CARD_SIZE.width, ClientView.CARD_SIZE.height + 140)

			local var_77_6 = ClientView.createShaderButton(nil, function(arg_78_0)
				var_77_2.create(var_77_3[iter_77_0]._infoId, 1, var_77_2.OperateType.na):show()
			end)

			var_77_6:setContentSize(ClientView.CARD_SIZE)
			lc.addChildToPos(var_77_5, var_77_6, cc.p(lc.cw(var_77_5), lc.h(var_77_5) - lc.ch(var_77_6)))

			local var_77_7 = B.createCard(var_77_3[iter_77_0]._infoId, 1)

			var_77_7._originOwner = arg_77_0._player

			local var_77_8 = CardSprite.create(var_77_7, arg_77_0)

			var_77_8:initNormal()
			var_77_8:setRotation3D({
				z = 0,
				x = 0,
				y = 0
			})
			var_77_8._pCardArea:setScale(1)
			var_77_8:setCameraMask(1)
			lc.addChildToCenter(var_77_6, var_77_8)

			local var_77_9 = arg_77_0:efcDragonBones2("xuanzhong", "effect1", 2, false)

			lc.addChildToCenter(var_77_8, var_77_9, -1)

			local var_77_10 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_79_0)
				arg_77_0:onChoiceCeremony(arg_79_0, var_77_0)
			end, ClientView.CRECT_BUTTON, 150)

			var_77_10._index = iter_77_0

			var_77_10:addLabel(Str(STR.SELECT))
			lc.addChildToPos(var_77_5, var_77_10, cc.p(lc.cw(var_77_5), lc.ch(var_77_10)))

			local var_77_11 = Str(var_77_3[iter_77_0]._owner == arg_77_0._player and STR.SELF or STR.OPPONENT) or ""
			local var_77_12 = {
				[BattleData.CardStatus.board] = STR.BATTLE_BOARD,
				[BattleData.CardStatus.hand] = STR.BATTLE_HAND,
				[BattleData.CardStatus.grave] = STR.BATTLE_GRAVE,
				[BattleData.CardStatus.pile] = STR.TROOP,
				[BattleData.CardStatus.cover] = STR.BATTLE_CS,
				[BattleData.CardStatus.show] = STR.BATTLE_CS,
				[BattleData.CardStatus.field] = STR.BATTLE_FIELD,
				[BattleData.CardStatus.leave] = STR.BATTLE_LEAVE,
				[BattleData.CardStatus.rare] = STR.BATTLE_EXCARD_LIST
			}
			local var_77_13 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_77_11 .. (var_77_12[var_77_3[iter_77_0]._status] and Str(var_77_12[var_77_3[iter_77_0]._status]) or ""))

			lc.addChildToPos(var_77_5, var_77_13, cc.p(lc.cw(var_77_5), lc.ch(var_77_10) + 64))

			arg_77_0._choiceBtns[#arg_77_0._choiceBtns + 1] = var_77_5
		end
	end

	local var_77_14 = 40

	if (ClientView.CARD_SIZE.width + var_77_14) * #arg_77_0._choiceBtns < ClientView.SCR_W then
		lc.addNodesToCenter(var_77_0, arg_77_0._choiceBtns, var_77_14)
	else
		local var_77_15 = lc.List.createH(cc.size(ClientView.SCR_W, ClientView.CARD_SIZE.height + 200), var_77_14, var_77_14)

		var_77_15:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToCenter(var_77_0, var_77_15)
		lc.offset(var_77_15, 0, -30)

		for iter_77_1 = 1, #arg_77_0._choiceBtns do
			var_77_15:pushBackCustomItem(arg_77_0._choiceBtns[iter_77_1])
		end
	end
end

function var_0_0.onChoiceCeremony(arg_80_0, arg_80_1, arg_80_2)
	local var_80_0 = arg_80_1._index
	local var_80_1 = arg_80_2._pCard
	local var_80_2 = arg_80_2._pTargetCard
	local var_80_3 = arg_80_2._choiceBase
	local var_80_4 = var_80_3 and math.floor(var_80_3 / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0

	var_80_1:setVisible(true)
	arg_80_2:endChoice()

	local var_80_5 = arg_80_0._player:getValidCeremonyResultCardsByTriggerCard(var_80_1._card)[var_80_0]
	local var_80_6

	if var_80_1._card:hasSkillFast(4214) then
		var_80_6 = arg_80_0._player:getCeremonyPileCandidatesByTriggerCard(var_80_5, var_80_1._card)
	elseif var_80_1._card:hasSkillFast(4382) then
		var_80_6 = B.filterInStatusCards(arg_80_0._player:getCeremonyCandidatesByTriggerCard(var_80_5, var_80_1._card), BattleData.CardStatus.board)
	elseif var_80_1._card:hasSkillFast(4504) then
		var_80_6 = arg_80_0._player:get4504CeremonyCandidatesByTriggerCard(var_80_5, var_80_1._card)
	elseif var_80_4 == 2 and var_80_1._card._infoId ~= 21024 then
		if var_80_1._card:hasSkillFast(4199) then
			var_80_6 = arg_80_0._player:getCeremonyGraveCandidatesByTriggerCard(var_80_5, var_80_1._card)
		elseif var_80_1._card:hasSkillFast(4576) then
			var_80_6 = arg_80_0._player:get4576CeremonyCandidatesByTriggerCard(var_80_5, var_80_1._card)
		else
			var_80_6 = arg_80_0._player:get4388CeremonyCandidatesByTriggerCard(var_80_5, var_80_1._card)
		end
	elseif var_80_1._card:hasSkillFast(4585) then
		var_80_6 = arg_80_0._player:get4585CeremonyCandidatesByTriggerCard(var_80_5, var_80_1._card)
	elseif var_80_1._card:hasSkillFast(4597) then
		var_80_6 = arg_80_0._player:get4597CeremonyCandidatesByTriggerCard(var_80_5, var_80_1._card)
	elseif var_80_1._card:hasSkillFast(4648) then
		var_80_6 = arg_80_0._player:get4648CeremonyCandidatesByTriggerCard(var_80_5, var_80_1._card)
	else
		var_80_6 = arg_80_0._player:getCeremonyCandidatesByTriggerCard(var_80_5, var_80_1._card)
	end

	local var_80_7 = {}
	local var_80_8 = {}

	for iter_80_0 = 1, #var_80_6 do
		if var_80_6[iter_80_0]._owner == arg_80_0._player then
			var_80_8[#var_80_8 + 1] = var_80_6[iter_80_0]
		else
			var_80_7[#var_80_7 + 1] = var_80_6[iter_80_0]
		end
	end

	local var_80_9 = B.mergeTable({
		B.sortCardsByBoardPos(var_80_7),
		B.sortCardsByBoardPos(var_80_8)
	})

	arg_80_0:showChoiceGrave(var_80_1, var_80_2, var_80_9, 0, var_80_0 + var_80_3, var_80_5)
end

function var_0_0.showChoiceSync(arg_81_0, arg_81_1, arg_81_2, arg_81_3)
	local var_81_0 = arg_81_0:createChoiceMaskLayer(arg_81_1, arg_81_2, arg_81_1._card._skills[1], arg_81_3 or 0)
	local var_81_1 = ClientView.createTTF(Str(STR.CHOICE_TITLE_SYNC), ClientView.FontSize.M1)

	var_81_1:runAction(lc.rep(lc.sequence(lc.scaleTo(1.5, 1.05), lc.scaleTo(1.5, 1))))
	lc.addChildToPos(var_81_0, var_81_1, cc.p(lc.w(var_81_0) / 2, 700))

	local var_81_2 = require("CardInfoPanel")
	local var_81_3 = arg_81_0._player:getValidSyncResultInfoIdsByTriggerCard(arg_81_1._card)

	for iter_81_0 = 1, #var_81_3 do
		local var_81_4 = ccui.Layout:create()

		var_81_4:setAnchorPoint(0.5, 0.5)
		var_81_4:setContentSize(ClientView.CARD_SIZE.width, ClientView.CARD_SIZE.height + 100)

		local var_81_5 = ClientView.createShaderButton(nil, function(arg_82_0)
			var_81_2.create(var_81_3[iter_81_0], 1, var_81_2.OperateType.na):show()
		end)

		var_81_5:setContentSize(ClientView.CARD_SIZE)
		lc.addChildToPos(var_81_4, var_81_5, cc.p(lc.cw(var_81_4), lc.h(var_81_4) - lc.ch(var_81_5)))

		local var_81_6 = B.createCard(var_81_3[iter_81_0], 1)

		var_81_6._originOwner = arg_81_0._player

		local var_81_7 = CardSprite.create(var_81_6, arg_81_0)

		var_81_7:initNormal()
		var_81_7:setRotation3D({
			z = 0,
			x = 0,
			y = 0
		})
		var_81_7._pCardArea:setScale(1)
		var_81_7:setCameraMask(1)
		lc.addChildToCenter(var_81_5, var_81_7)

		local var_81_8 = arg_81_0:efcDragonBones2("xuanzhong", "effect1", 2, false)

		lc.addChildToCenter(var_81_7, var_81_8, -1)

		local var_81_9 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_83_0)
			arg_81_0:onChoiceSync(arg_83_0, var_81_0)
		end, ClientView.CRECT_BUTTON, 150)

		var_81_9._index = iter_81_0

		var_81_9:addLabel(Str(STR.SELECT))
		lc.addChildToPos(var_81_4, var_81_9, cc.p(lc.cw(var_81_4), lc.ch(var_81_9)))

		arg_81_0._choiceBtns[#arg_81_0._choiceBtns + 1] = var_81_4
	end

	local var_81_10 = 40

	if (ClientView.CARD_SIZE.width + var_81_10) * #arg_81_0._choiceBtns < ClientView.SCR_W then
		lc.addNodesToCenter(var_81_0, arg_81_0._choiceBtns, var_81_10)
	else
		local var_81_11 = lc.List.createH(cc.size(ClientView.SCR_W, ClientView.CARD_SIZE.height + 200), var_81_10, var_81_10)

		var_81_11:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToCenter(var_81_0, var_81_11)
		lc.offset(var_81_11, 0, -30)

		for iter_81_1 = 1, #arg_81_0._choiceBtns do
			var_81_11:pushBackCustomItem(arg_81_0._choiceBtns[iter_81_1])
		end
	end
end

function var_0_0.onChoiceSync(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = arg_84_1._index
	local var_84_1 = arg_84_2._pCard
	local var_84_2 = arg_84_2._pTargetCard
	local var_84_3 = arg_84_2._choiceBase

	if not var_84_1._card:hasSkillFast(9507) then
		var_84_1:setVisible(true)
	end

	arg_84_2:endChoice()

	local var_84_4 = arg_84_0._player:getValidSyncResultInfoIdsByTriggerCard(var_84_1._card)[var_84_0]
	local var_84_5 = arg_84_0._player:getBattleCardsByInfoId("R", var_84_4)[1]
	local var_84_6 = B.sortCardsByBoardPos(arg_84_0._player:getSyncCandidatesByTriggerCard(var_84_5, var_84_1._card))

	if var_84_0 >= 10 then
		var_84_0 = var_84_0 * 10
	end

	arg_84_0:showChoiceGrave(var_84_1, var_84_2, var_84_6, #Data._rareInfo[var_84_4]._joinComponent, var_84_0 + var_84_3, var_84_5)
end

function var_0_0.showChoiceGrave(arg_85_0, arg_85_1, arg_85_2, arg_85_3, arg_85_4, arg_85_5, arg_85_6)
	local var_85_0
	local var_85_1
	local var_85_2

	if arg_85_1._card:hasSkills({
		4048,
		4171,
		4186,
		4207,
		4290,
		4454,
		4497,
		4521,
		4735,
		4736,
		4740,
		4748,
		4836,
		7144,
		7373,
		7693
	}) or arg_85_1._card._status == BattleData.CardStatus.rare and arg_85_1._card:hasSkills({
		3874,
		3885,
		2375
	}) or arg_85_1._card._status == BattleData.CardStatus.board and arg_85_1._card:hasSkills({
		2243,
		2318
	}) or arg_85_1._card._status == BattleData.CardStatus.grave and arg_85_1._card:hasSkills({
		2985
	}) or arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
		2982,
		4305,
		4511,
		4514,
		4526,
		4530,
		4861,
		4957,
		4979,
		5244,
		5280,
		5298,
		7544,
		7579,
		7622,
		7631,
		7731,
		7753
	}) and (arg_85_5 == nil or not arg_85_1._card:isSkillAtIndex(7733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3705, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3850, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2324, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4978, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4980, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5430, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5431, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5452, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5470, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5485, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5544, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5549, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7673, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7674, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7732, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7785, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7831, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9796, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9868, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13119, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13259, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13264, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13292, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13348, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13718, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13736, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13850, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13920, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13989, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14390, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14487, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14519, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14541, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14555, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.merge
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_MERGE_COMPONENT), arg_85_4)
	elseif arg_85_1._card._status == BattleData.CardStatus.rare and arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3851, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_1._card:getStar())
	elseif arg_85_1._card:hasSkills({
		2437,
		2560,
		2781,
		3940,
		6349,
		9453,
		9462
	}) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2611, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9507, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9685, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13007, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7824, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_1._card._status == BattleData.CardStatus.rare and arg_85_1._card:isSkillAtIndex(6753, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.xyz

		local var_85_3 = arg_85_1._card._info._joinComponent[1]
		local var_85_4 = #arg_85_1._card._info._joinComponent

		if var_85_3 ~= 0 then
			var_85_1 = string.format(Str(STR.CHOICE_TITLE_XYZ_COMPONENT), var_85_4, var_85_3)
		else
			var_85_1 = string.format(Str(STR.CHOICE_TITLE_XYZ_COMPONENT_IGNORE_STAR), var_85_4)
		end
	elseif arg_85_1._card._status == BattleData.CardStatus.rare and arg_85_1._card:isSkillAtIndex(9298, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.link
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_LINK_COMPONENT), arg_85_1._card:getLink(), Str(arg_85_1._card._info._descSid))
	elseif arg_85_1._card._status == BattleData.CardStatus.hand and B.isSkillCeremony(arg_85_1._card._skills[1]._id) then
		var_85_0 = BattleListDialog.Mode.ceremony
		var_85_1 = Str(arg_85_1._card._skills[1]._id ~= 4382 and STR.CHOICE_TITLE_CEREMONY_COMPONENT or STR.CHOICE_TITLE_CHOICE_0)
	elseif arg_85_1._card:hasSkills({
		3034,
		3035,
		3127,
		3247,
		3473,
		3474,
		3484
	}) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3034_1 or STR.CHOICE_TITLE_3034_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3320, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3320_1 or STR.CHOICE_TITLE_3320_2)
	elseif arg_85_1._card:hasSkills({
		3538
	}) and arg_85_5 ~= nil and arg_85_5 % BattleData.ChoiceId.stage_size_1 == 2 then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3538_1 or STR.CHOICE_TITLE_3538_2)
	elseif arg_85_1._card:hasSkills({
		3540
	}) and arg_85_1._card._status == BattleData.CardStatus.grave then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3538_1 or STR.CHOICE_TITLE_3538_2)
	elseif arg_85_1._card:hasSkills({
		3555
	}) and arg_85_1._card._status == BattleData.CardStatus.board then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3555_1 or STR.CHOICE_TITLE_3555_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3714, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3714_1 or STR.CHOICE_TITLE_3714_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3737, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3737_1 or STR.CHOICE_TITLE_3737_2)
	elseif arg_85_1._card:hasSkills({
		3835
	}) and arg_85_1._card._status == BattleData.CardStatus.board then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3835_1 or STR.CHOICE_TITLE_3835_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3950, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3950_1 or STR.CHOICE_TITLE_3950_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3957, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3957_1 or STR.CHOICE_TITLE_3957_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3974, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3974_1 or STR.CHOICE_TITLE_3974_2)
	elseif arg_85_1._card:hasSkills({
		4411
	}) and arg_85_1._card._status == BattleData.CardStatus.field then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4411_1 or STR.CHOICE_TITLE_4411_2)
	elseif arg_85_1._card:hasSkills({
		4431
	}) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4431_1 or STR.CHOICE_TITLE_4431_2)
	elseif arg_85_1._card:hasSkills({
		4095,
		4318
	}) then
		var_85_0 = BattleListDialog.Mode.exchange
		var_85_1 = Str(STR.CHOICE_TITLE_EXCHANGE)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4465, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4465_1 or STR.CHOICE_TITLE_4465_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4798, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4465_1 or STR.CHOICE_TITLE_4465_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4486, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4486_1 or STR.CHOICE_TITLE_4486_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4529, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4529_1 or STR.CHOICE_TITLE_4529_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4572, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4572_1 or STR.CHOICE_TITLE_4572_2)
	elseif arg_85_1._card:hasSkillFast(4589) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4589_1 or STR.CHOICE_TITLE_4589_2)
	elseif arg_85_1._card:hasSkillFast(4594) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4594_1 or STR.CHOICE_TITLE_4594_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4596, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4596_1 or STR.CHOICE_TITLE_4596_2)
	elseif arg_85_1._card:hasSkillFast(4628) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4628_1 or STR.CHOICE_TITLE_4628_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4631, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4631_1 or STR.CHOICE_TITLE_4631_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4633, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4633_1 or STR.CHOICE_TITLE_4633_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4678, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4678_1 or STR.CHOICE_TITLE_4678_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4728, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice

		local var_85_5 = Data._skillInfo[4728]
		local var_85_6 = B.filterFirstCards(arg_85_0._player._pileCards, 3)
		local var_85_7 = arg_85_0._player:filterCanChangeToHandCards(B.mergeTable({
			B.filterEqualInfoIdCards(var_85_6, var_85_5._refCards[2]),
			B.filterInKeywordCards(B.filterInTypeGroupCards(var_85_6, {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_85_5._refCards[1])
		}))

		var_85_1 = Str(arg_85_6 == nil and (#var_85_7 > 0 and STR.CHOICE_TITLE_4728_1_1 or STR.CHOICE_TITLE_4728_1_2) or STR.CHOICE_TITLE_4728_2)
	elseif arg_85_1._card:hasSkillFast(4753) then
		var_85_0 = BattleListDialog.Mode.choice

		local var_85_8 = Data._skillInfo[4753]

		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4753_1 or arg_85_0._player:getCardById(arg_85_6)._info._category == var_85_8._refCards[1] and STR.CHOICE_TITLE_4753_2_1 or STR.CHOICE_TITLE_4753_2_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4804, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4804_1 or STR.CHOICE_TITLE_4804_2)
	elseif arg_85_1._card:hasSkillFast(4816) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4816_1 or STR.CHOICE_TITLE_4816_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4821, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4827, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4827_1 or STR.CHOICE_TITLE_4827_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4840, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4840_1 or STR.CHOICE_TITLE_4840_2)
	elseif arg_85_1._card:hasSkillFast(4872) then
		var_85_0 = BattleListDialog.Mode.choice

		if arg_85_6 == nil then
			var_85_1 = Str(STR.CHOICE_TITLE_4872_1)
		else
			var_85_1 = string.format(Str(STR.CHOICE_TITLE_4872_2), arg_85_0._player:getCardById(arg_85_6):getStar())
		end
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4941, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4941_1 or STR.CHOICE_TITLE_4941_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4942, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4942_1 or STR.CHOICE_TITLE_4942_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4944, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4944_1 or STR.CHOICE_TITLE_4944_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4983, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4983_1 or STR.CHOICE_TITLE_4983_2)
	elseif arg_85_1._card:hasSkillFast(4984) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_2 == nil and STR.CHOICE_TITLE_4984_1 or STR.CHOICE_TITLE_4984_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4991, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4991_1 or STR.CHOICE_TITLE_4991_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4993, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4993_1 or STR.CHOICE_TITLE_4993_2)
	elseif arg_85_1._card:hasSkills({
		5118
	}) and arg_85_5 ~= nil and arg_85_5 % BattleData.ChoiceId.stage_size_1 == 1 then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5118_1 or STR.CHOICE_TITLE_5118_2)
	elseif arg_85_1._card:hasSkillFast(5232) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5232_1 or STR.CHOICE_TITLE_5232_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5285, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5285_1 or STR.CHOICE_TITLE_5285_2)
	elseif arg_85_1._card:hasSkillFast(5332) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5332_1 or STR.CHOICE_TITLE_5332_2)
	elseif arg_85_1._card:hasSkillFast(5343) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5343_1 or STR.CHOICE_TITLE_5343_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5440, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5440_1 or STR.CHOICE_TITLE_5440_2)
	elseif arg_85_1._card:hasSkillFast(5445) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5445_1 or STR.CHOICE_TITLE_5445_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5450, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and (arg_85_2 == nil and STR.CHOICE_TITLE_5450_1 or STR.CHOICE_TITLE_5450_2) or STR.CHOICE_TITLE_5450_3)
	elseif arg_85_1._card:hasSkillFast(5461) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5461_1 or STR.CHOICE_TITLE_5461_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5463, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5463_1 or STR.CHOICE_TITLE_5463_2)
	elseif arg_85_1._card:hasSkillFast(5472) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5472_1 or STR.CHOICE_TITLE_5472_2)
	elseif arg_85_1._card:hasSkillFast(5476) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5476_1 or STR.CHOICE_TITLE_5476_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5502, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5502_1 or STR.CHOICE_TITLE_5502_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5505, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_1._card:hasSkillFast(5508) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5508_1 or STR.CHOICE_TITLE_5508_2)
	elseif arg_85_1._card:hasSkillFast(5517) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5517_1 or STR.CHOICE_TITLE_5517_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5539, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5539_1 or STR.CHOICE_TITLE_5539_2)
	elseif arg_85_1._card:hasSkillFast(5543) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5543_1 or STR.CHOICE_TITLE_5543_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5561, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5561_1 or STR.CHOICE_TITLE_5561_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5566, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5566_1 or STR.CHOICE_TITLE_5566_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5571, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5571_1 or STR.CHOICE_TITLE_5571_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5572, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5572_1 or STR.CHOICE_TITLE_5572_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5597, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5597_1 or STR.CHOICE_TITLE_5597_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5603, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5603_1 or STR.CHOICE_TITLE_5603_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5605, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5605_1 or STR.CHOICE_TITLE_5605_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5614, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5614_1 or STR.CHOICE_TITLE_5614_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5617, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5617_1 or STR.CHOICE_TITLE_5617_2)
	elseif arg_85_1._card:hasSkillFast(5622) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5622_1 or STR.CHOICE_TITLE_5622_2)
	elseif arg_85_1._card:hasSkillFast(5624) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = arg_85_2 == nil and Str(STR.CHOICE_TITLE_5624_1) or string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5646, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5646_1 or STR.CHOICE_TITLE_5646_2)
	elseif arg_85_1._card:hasSkills({
		6265
	}) and arg_85_5 ~= nil and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6265_1 or STR.CHOICE_TITLE_6265_2)
	elseif arg_85_1._card:hasSkills({
		6286
	}) and arg_85_1._card._status == BattleData.CardStatus.board then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6286_1 or STR.CHOICE_TITLE_6286_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6365, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6365_1 or STR.CHOICE_TITLE_6365_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6396, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6396_1 or STR.CHOICE_TITLE_6396_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6507, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6507_1 or STR.CHOICE_TITLE_6507_2)
	elseif arg_85_1._card:hasSkills({
		6616
	}) and arg_85_1._card._status == BattleData.CardStatus.grave then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6616_1 or STR.CHOICE_TITLE_6616_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6618, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6618_1 or STR.CHOICE_TITLE_6618_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6619, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6619_1 or STR.CHOICE_TITLE_6619_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6679, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6679_1 or STR.CHOICE_TITLE_6679_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6732, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6732_1 or STR.CHOICE_TITLE_6732_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6733_1 or STR.CHOICE_TITLE_6733_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6735, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6735_1 or STR.CHOICE_TITLE_6735_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6746, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6746_1 or STR.CHOICE_TITLE_6746_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6772, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6772_1 or STR.CHOICE_TITLE_6772_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6795, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6795_1 or STR.CHOICE_TITLE_6795_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6841, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6841_1 or STR.CHOICE_TITLE_6841_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6848, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6848_1 or STR.CHOICE_TITLE_6848_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6921, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6921_1 or STR.CHOICE_TITLE_6921_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6964, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6964_1 or STR.CHOICE_TITLE_6964_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6978, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6978_1 or STR.CHOICE_TITLE_6978_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6982, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6982_1 or STR.CHOICE_TITLE_6982_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2111, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2111_1 or STR.CHOICE_TITLE_2111_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2112, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2112_1 or STR.CHOICE_TITLE_2112_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2117, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2117_1 or STR.CHOICE_TITLE_2117_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2135, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2135_1 or STR.CHOICE_TITLE_2135_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2155, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2155_1 or STR.CHOICE_TITLE_2155_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2196, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2196_1 or STR.CHOICE_TITLE_2196_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2203, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2203_1 or STR.CHOICE_TITLE_2203_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2209, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2209_1 or STR.CHOICE_TITLE_2209_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2212, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2212_1 or STR.CHOICE_TITLE_2212_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2279, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2279_1 or STR.CHOICE_TITLE_2279_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2320, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2320_1 or STR.CHOICE_TITLE_2320_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2341, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2341_1 or STR.CHOICE_TITLE_2341_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2359, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2359_1 or STR.CHOICE_TITLE_2359_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2389, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2389_1 or STR.CHOICE_TITLE_2389_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2392, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2392_1 or STR.CHOICE_TITLE_2392_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2400, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2400_1 or STR.CHOICE_TITLE_2400_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2409, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2409_1 or STR.CHOICE_TITLE_2409_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2429, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2429_1 or STR.CHOICE_TITLE_2429_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2430, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2430_1 or STR.CHOICE_TITLE_2430_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2434, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2434_1 or STR.CHOICE_TITLE_2434_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2441, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2441_1 or STR.CHOICE_TITLE_2441_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2449, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2449_1 or STR.CHOICE_TITLE_2449_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2450, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2450_1 or STR.CHOICE_TITLE_2450_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2486, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2486_1 or STR.CHOICE_TITLE_2486_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2487, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2487_1 or STR.CHOICE_TITLE_2487_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2534, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2534_1 or STR.CHOICE_TITLE_2534_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2562, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2562_1 or STR.CHOICE_TITLE_2562_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2578, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2578_1 or STR.CHOICE_TITLE_2578_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2585, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2585_1 or STR.CHOICE_TITLE_2585_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2586, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2586_1 or STR.CHOICE_TITLE_2586_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2587, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2585_1 or STR.CHOICE_TITLE_2585_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2588, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2588_1 or STR.CHOICE_TITLE_2588_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2598, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2598_1 or STR.CHOICE_TITLE_2598_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2599, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2599_1 or STR.CHOICE_TITLE_2599_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2602, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2598_1 or STR.CHOICE_TITLE_2598_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2615, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2615_1 or STR.CHOICE_TITLE_2615_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2739, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2739_1 or STR.CHOICE_TITLE_2739_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2750, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2750_1 or STR.CHOICE_TITLE_2750_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2772, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2772_1 or STR.CHOICE_TITLE_2772_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2774, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2774_1 or STR.CHOICE_TITLE_2774_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2776, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2776_1 or STR.CHOICE_TITLE_2776_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2785, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2785_1 or STR.CHOICE_TITLE_2785_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2787, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2787_1 or STR.CHOICE_TITLE_2787_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2789, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2789_1 or STR.CHOICE_TITLE_2789_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2806, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2806_1 or STR.CHOICE_TITLE_2806_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2811, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2811_1 or STR.CHOICE_TITLE_2811_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2813, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2813_1 or STR.CHOICE_TITLE_2813_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2838, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2838_1 or STR.CHOICE_TITLE_2838_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2867, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2867_1 or STR.CHOICE_TITLE_2867_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2886, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2886_1 or STR.CHOICE_TITLE_2886_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2915, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2915_1 or STR.CHOICE_TITLE_2915_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2928, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2928_1 or STR.CHOICE_TITLE_2928_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2930, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2930_1 or STR.CHOICE_TITLE_2930_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2942, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2942_1 or STR.CHOICE_TITLE_2942_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2951, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2951_1 or STR.CHOICE_TITLE_2951_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2959, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2959_1 or STR.CHOICE_TITLE_2959_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2963, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2963_1 or STR.CHOICE_TITLE_2963_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2969, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2969_1 or STR.CHOICE_TITLE_2969_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2986, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2986_1 or STR.CHOICE_TITLE_2986_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9009, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9009_1 or STR.CHOICE_TITLE_9009_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9034, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9034_1 or STR.CHOICE_TITLE_9034_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9051, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9051_1 or STR.CHOICE_TITLE_9051_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9052, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9051_1 or STR.CHOICE_TITLE_9051_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9072, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9072_1 or STR.CHOICE_TITLE_9072_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9092, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9092_1 or STR.CHOICE_TITLE_9092_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9124, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9124_1 or STR.CHOICE_TITLE_9124_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9168, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9168_1 or STR.CHOICE_TITLE_9168_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9189, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9189_1 or STR.CHOICE_TITLE_9189_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9198, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9198_1 or STR.CHOICE_TITLE_9198_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9204, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9204_1 or STR.CHOICE_TITLE_9204_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9213, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9213_1 or STR.CHOICE_TITLE_9213_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9214, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9214_1 or STR.CHOICE_TITLE_9214_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9218, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9218_1 or STR.CHOICE_TITLE_9218_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9220, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9220_1 or STR.CHOICE_TITLE_9220_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9230, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9230_1 or STR.CHOICE_TITLE_9230_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9258, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9258_1 or STR.CHOICE_TITLE_9258_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9260, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9260_1 or STR.CHOICE_TITLE_9260_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9269, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9269_1 or STR.CHOICE_TITLE_9269_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9282, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9282_1 or STR.CHOICE_TITLE_9282_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9305, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9305_1 or STR.CHOICE_TITLE_9305_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9306, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9306_1 or STR.CHOICE_TITLE_9306_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9314, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9314_1 or STR.CHOICE_TITLE_9314_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9320, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9320_1 or STR.CHOICE_TITLE_9320_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9373, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9373_1 or STR.CHOICE_TITLE_9373_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9375, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9375_1 or STR.CHOICE_TITLE_9375_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9378, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9378_1 or STR.CHOICE_TITLE_9378_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9392, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9378_1 or STR.CHOICE_TITLE_9378_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9382, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9382_1 or STR.CHOICE_TITLE_9382_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9396, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9396_1 or STR.CHOICE_TITLE_9396_2)
	elseif arg_85_5 ~= nil and (arg_85_1._card:isSkillAtIndex(9480, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_1._card:isSkillAtIndex(9481, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9480_1 or STR.CHOICE_TITLE_9480_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9485, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9485_1 or STR.CHOICE_TITLE_9485_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9489, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.check
		var_85_1 = Str(STR.CHOICE_TITLE_9489)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9497, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9497_1 or STR.CHOICE_TITLE_9497_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9518, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9518_1 or STR.CHOICE_TITLE_9518_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9523, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9523_1 or STR.CHOICE_TITLE_9523_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9552, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.check_ignore_cancel
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_9552), #B.filterAdjustCards(arg_85_3, true))
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9556, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9556_1 or STR.CHOICE_TITLE_9556_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9563, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9563_1 or STR.CHOICE_TITLE_9563_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9593, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9593_1 or STR.CHOICE_TITLE_9593_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9600, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9600_1 or STR.CHOICE_TITLE_9600_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9614, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9614_1 or STR.CHOICE_TITLE_9614_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9615, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9615_1 or STR.CHOICE_TITLE_9615_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9638, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9638_1 or STR.CHOICE_TITLE_9638_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9712, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9712_1 or STR.CHOICE_TITLE_9712_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9721, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9721_1 or STR.CHOICE_TITLE_9721_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9733_1 or STR.CHOICE_TITLE_9733_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9739, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9739_1 or STR.CHOICE_TITLE_9739_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9763, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_2 == nil and STR.CHOICE_TITLE_9763_1 or STR.CHOICE_TITLE_9763_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9768, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_9768), Data._skillInfo[9768]._val[1])
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9785, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9785_1 or STR.CHOICE_TITLE_9785_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9786, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9786_1 or STR.CHOICE_TITLE_9786_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9815, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9815_1 or STR.CHOICE_TITLE_9815_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9841, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9841_1 or STR.CHOICE_TITLE_9841_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9851, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9851_1 or STR.CHOICE_TITLE_9851_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9867, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9867_1 or STR.CHOICE_TITLE_9867_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9916, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9916_1 or STR.CHOICE_TITLE_9916_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9917, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9917_1 or STR.CHOICE_TITLE_9917_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9918, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9918_1 or STR.CHOICE_TITLE_9918_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9934, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9934_1 or STR.CHOICE_TITLE_9934_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9944, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		local var_85_9 = Data._skillInfo[9944]

		var_85_0 = BattleListDialog.Mode.choice

		if #B.filterInNatureCards(arg_85_3, var_85_9._refCards[1]) > 0 or #B.filterInNatureCards(arg_85_3, var_85_9._refCards[2]) > 0 then
			var_85_1 = Str(STR.CHOICE_TITLE_9944_1)
		else
			var_85_1 = Str(STR.CHOICE_TITLE_9944_2)
			var_85_2 = true
		end
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9956, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9956_1 or STR.CHOICE_TITLE_9956_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9965, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9965_1 or STR.CHOICE_TITLE_9965_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9960, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9960_1 or STR.CHOICE_TITLE_9960_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9983, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9983_1 or STR.CHOICE_TITLE_9983_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9984, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9984_1 or STR.CHOICE_TITLE_9984_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13002, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13002_1 or STR.CHOICE_TITLE_13002_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13039, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5539_1 or STR.CHOICE_TITLE_5539_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13044, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13045, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13054, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13054_1 or STR.CHOICE_TITLE_13054_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13068, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13068_1 or STR.CHOICE_TITLE_13068_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13072, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13072_1 or STR.CHOICE_TITLE_13072_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13155, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13155_1 or STR.CHOICE_TITLE_13155_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13156, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13156_1 or STR.CHOICE_TITLE_13156_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13157, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13157_1 or STR.CHOICE_TITLE_13157_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13165, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13165_1 or STR.CHOICE_TITLE_13165_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13168, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13168_1 or STR.CHOICE_TITLE_13168_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13185, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13185_1 or STR.CHOICE_TITLE_13185_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13218, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13218_1 or STR.CHOICE_TITLE_13218_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13220, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13220_1 or STR.CHOICE_TITLE_13220_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13221, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13220_1 or STR.CHOICE_TITLE_13220_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13275, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13276, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.exchange
		var_85_1 = Str(STR.CHOICE_TITLE_EXCHANGE)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13296, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13296_1 or STR.CHOICE_TITLE_13296_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13318, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13318_1 or STR.CHOICE_TITLE_13318_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13321, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13321_1 or STR.CHOICE_TITLE_13321_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13330, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13330_1 or STR.CHOICE_TITLE_13330_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13332, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13332_1 or STR.CHOICE_TITLE_13332_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13365, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13365_1 or STR.CHOICE_TITLE_13365_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13367, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13367_1 or STR.CHOICE_TITLE_13367_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13373, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13373_1 or STR.CHOICE_TITLE_13373_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13380, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13380_1 or STR.CHOICE_TITLE_13380_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13398, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13398_1 or STR.CHOICE_TITLE_13398_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13401, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13401_1 or STR.CHOICE_TITLE_13401_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13405, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13405_1 or STR.CHOICE_TITLE_13405_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13408, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13408_1 or STR.CHOICE_TITLE_13408_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13411, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13411_1 or STR.CHOICE_TITLE_13411_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13430, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13430_1 or STR.CHOICE_TITLE_13430_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13432, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13432_1 or STR.CHOICE_TITLE_13432_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13452, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13452_1 or STR.CHOICE_TITLE_13452_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13468, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13468_1 or STR.CHOICE_TITLE_13468_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13538, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13538_1 or STR.CHOICE_TITLE_13538_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13552, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13552_1 or STR.CHOICE_TITLE_13552_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13553, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13553_1 or STR.CHOICE_TITLE_13553_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13572, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13572_1 or STR.CHOICE_TITLE_13572_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13602, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13602_1 or STR.CHOICE_TITLE_13602_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13607, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13607_1 or STR.CHOICE_TITLE_13607_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13576, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice

		local var_85_10 = Data._skillInfo[13576]
		local var_85_11 = B.filterFirstCards(arg_85_0._player._pileCards, 3)
		local var_85_12 = arg_85_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(var_85_11, var_85_10._refCards[2]))

		var_85_1 = Str(arg_85_6 == nil and (#var_85_12 > 0 and STR.CHOICE_TITLE_4728_1_1 or STR.CHOICE_TITLE_4728_1_2) or STR.CHOICE_TITLE_4728_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13618, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13618_1 or STR.CHOICE_TITLE_13618_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13626, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13626_1 or STR.CHOICE_TITLE_13626_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13697, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13703, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13703_1 or STR.CHOICE_TITLE_13703_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13710, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13710_1 or STR.CHOICE_TITLE_13710_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13719, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.exchange
		var_85_1 = Str(STR.CHOICE_TITLE_EXCHANGE)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13764, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13764_1 or STR.CHOICE_TITLE_13764_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13766, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13766_1 or STR.CHOICE_TITLE_13766_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13767, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13767_1 or STR.CHOICE_TITLE_13767_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13792, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13792_1 or STR.CHOICE_TITLE_13792_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13793, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13793_1 or STR.CHOICE_TITLE_13793_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13847, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13847_1 or STR.CHOICE_TITLE_13847_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13959, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13959_1 or STR.CHOICE_TITLE_13959_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13995, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13995_1 or STR.CHOICE_TITLE_13995_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14020, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14020_1 or STR.CHOICE_TITLE_14020_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14047, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14047_1 or STR.CHOICE_TITLE_14047_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14163, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14163_1 or STR.CHOICE_TITLE_14163_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14176, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14176_1 or STR.CHOICE_TITLE_14176_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14185, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14185_1 or STR.CHOICE_TITLE_14185_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14337, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14337_1 or STR.CHOICE_TITLE_14337_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14411, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14411_1 or STR.CHOICE_TITLE_14411_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14441, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14441_1 or STR.CHOICE_TITLE_14441_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14474, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14474_1 or STR.CHOICE_TITLE_14474_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14534, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14534_1 or STR.CHOICE_TITLE_14534_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14561, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14561_1 or STR.CHOICE_TITLE_14561_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14570, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14570_1 or STR.CHOICE_TITLE_14570_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14579, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14579_1 or STR.CHOICE_TITLE_14579_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14588, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14588_1 or STR.CHOICE_TITLE_14588_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14598, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14598_1 or STR.CHOICE_TITLE_14598_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14604, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14604_1 or STR.CHOICE_TITLE_14604_2)
	elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
		4100
	}) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4100_1 or STR.CHOICE_TITLE_4100_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9694, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_9694)
	elseif arg_85_1._card._status == BattleData.CardStatus.grave and arg_85_1._card:hasSkills({
		4157
	}) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4157_1 or STR.CHOICE_TITLE_4157_2)
	elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
		5104
	}) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5104_1 or STR.CHOICE_TITLE_5104_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7234, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7234_1 or STR.CHOICE_TITLE_7234_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7244, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7244_1 or STR.CHOICE_TITLE_7244_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7309, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7309_1 or STR.CHOICE_TITLE_7309_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7310, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7310_1 or STR.CHOICE_TITLE_7310_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7328, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7328_1 or STR.CHOICE_TITLE_7328_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7336, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7336_1 or STR.CHOICE_TITLE_7336_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7337, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7337_1 or STR.CHOICE_TITLE_7337_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7338, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7338_1 or STR.CHOICE_TITLE_7338_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7365, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7365_1 or STR.CHOICE_TITLE_7365_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7374, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7374_1 or STR.CHOICE_TITLE_7374_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7380, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7380_1 or STR.CHOICE_TITLE_7380_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7404, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7404_1 or STR.CHOICE_TITLE_7404_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7408, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7408_1 or STR.CHOICE_TITLE_7408_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7429, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7429_1 or STR.CHOICE_TITLE_7429_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7433, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7433_1 or STR.CHOICE_TITLE_7433_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7454, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7454_1 or STR.CHOICE_TITLE_7454_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7534, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7534_1 or STR.CHOICE_TITLE_7534_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7551, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7551_1 or STR.CHOICE_TITLE_7551_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7566, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7566_1 or STR.CHOICE_TITLE_7566_2)
	elseif arg_85_1._card:hasSkillFast(7574) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7574_1 or STR.CHOICE_TITLE_7574_2)
	elseif arg_85_1._card:hasSkillFast(7578) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7578_1 or STR.CHOICE_TITLE_7578_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7582, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7582_1 or STR.CHOICE_TITLE_7582_2)
	elseif arg_85_1._card:hasSkillFast(7628) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_2 == nil and STR.CHOICE_TITLE_7628_1 or STR.CHOICE_TITLE_7628_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7635, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7635_1 or STR.CHOICE_TITLE_7635_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7640, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7640_1 or STR.CHOICE_TITLE_7640_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7646, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7646_1 or STR.CHOICE_TITLE_7646_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7669, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7669_1 or STR.CHOICE_TITLE_7669_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7686, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7686_1 or STR.CHOICE_TITLE_7686_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7687, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7687_1 or STR.CHOICE_TITLE_7687_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7705, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7705_1 or STR.CHOICE_TITLE_7705_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7706, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7706_1 or STR.CHOICE_TITLE_7706_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7722, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7722_1 or STR.CHOICE_TITLE_7722_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7733_1 or STR.CHOICE_TITLE_7733_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7742, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7742_1 or STR.CHOICE_TITLE_7742_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7772, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7772_1 or STR.CHOICE_TITLE_7772_2)
	elseif arg_85_1._card:hasSkillFast(7774) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_2 == nil and STR.CHOICE_TITLE_7774_1 or STR.CHOICE_TITLE_7774_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7792, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7792_1 or STR.CHOICE_TITLE_7792_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7794, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7794_1 or STR.CHOICE_TITLE_7794_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7818, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7818_1 or STR.CHOICE_TITLE_7818_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7819, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7819_1 or STR.CHOICE_TITLE_7819_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7828, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7828_1 or STR.CHOICE_TITLE_7828_2)
	elseif arg_85_1._card:hasSkills({
		8056
	}) and arg_85_1._card._status == BattleData.CardStatus.show then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8056_1 or STR.CHOICE_TITLE_8056_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8077, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8077_1 or STR.CHOICE_TITLE_8077_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8082, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8082_1 or STR.CHOICE_TITLE_8082_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8083, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8083_1 or STR.CHOICE_TITLE_8083_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8084, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8084_1 or STR.CHOICE_TITLE_8084_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8094, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8094_1 or STR.CHOICE_TITLE_8094_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8145, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8094_1 or STR.CHOICE_TITLE_8094_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8111, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8111_1 or STR.CHOICE_TITLE_8111_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8123, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8123_1 or STR.CHOICE_TITLE_8123_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8124, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8124_1 or STR.CHOICE_TITLE_8124_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8126, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8126_1 or STR.CHOICE_TITLE_8126_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8131, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8131_1 or STR.CHOICE_TITLE_8131_2)
	else
		local var_85_13, var_85_14 = arg_85_1._card:hasSkills({
			3073,
			3248,
			3331,
			3344,
			3365,
			3406,
			3428,
			3480,
			3573,
			3594,
			3707,
			3726,
			3735,
			3741,
			3768,
			3774,
			3775,
			3901,
			3912,
			3935,
			3937,
			3943,
			4117,
			4169,
			4170,
			4174,
			4205,
			4213,
			4238,
			4262,
			4263,
			4288,
			4302,
			4367,
			4413,
			4416,
			4430,
			4436,
			4443,
			4445,
			4463,
			4464,
			4490,
			4495,
			4507,
			4519,
			4532,
			4534,
			4559,
			4644,
			4645,
			4653,
			4655,
			4665,
			4674,
			4684,
			4723,
			4747,
			4750,
			4771,
			4783,
			4816,
			5049,
			5067,
			5107,
			5127,
			5156,
			5191,
			5193,
			5237,
			5363,
			5382,
			5403,
			5410,
			5443,
			6274,
			6338,
			6436,
			6437,
			6440,
			6451,
			6452,
			6454,
			6465,
			6476,
			6509,
			6510,
			6511,
			6549,
			6579,
			6598,
			6631,
			6673,
			6675,
			6707,
			6810,
			6894,
			6923,
			6934,
			6946,
			7192,
			7235,
			8018,
			8019,
			8046
		})

		if var_85_13 then
			var_85_0 = BattleListDialog.Mode.choice
			var_85_1 = Str(STR["CHOICE_TITLE_" .. var_85_14[1]._id .. (arg_85_6 == nil and "_1" or "_2")])
		else
			var_85_0 = BattleListDialog.Mode.choice

			if arg_85_4 == 0 then
				var_85_1 = Str(STR.CHOICE_TITLE_CHOICE_0)
			elseif arg_85_1._card:hasSkillFast(4722) then
				var_85_1 = string.format(Str(arg_85_4 == 2 and STR.CHOICE_TITLE_4722_1 or STR.CHOICE_TITLE_4722_2))
			elseif arg_85_1._card:hasSkills({
				3866,
				4350,
				4384,
				4390,
				4408,
				4424,
				4425,
				4510,
				4558,
				4689,
				4701,
				4730,
				4853,
				4870,
				4939,
				4943,
				5204,
				5267,
				5309,
				5400,
				6528,
				6684,
				2352,
				2354,
				2384,
				2404,
				2431,
				2878,
				9067,
				9142,
				7199,
				7305,
				8071
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4458, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4797, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5283, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
				5284,
				6833
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5285, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) and arg_85_4 == 2 then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
				5324
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
				var_85_2 = true
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5393, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5447, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5517) and arg_85_4 == 2 then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5570, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5595) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5641, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5642) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5650, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5651, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5652) and arg_85_4 == 2 then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5653, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5656) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6468, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.board and arg_85_1._card:hasSkills({
				6497,
				6605
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6860, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_4 == 2 and arg_85_1._card:hasSkills({
				6558
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6984, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7555, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7556, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(7644) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7681, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7682, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7735, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7736, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(7737) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7744, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX_7744), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7767, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7776, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7822, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2113, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2142, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2310, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2807, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2879, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2929, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2966, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9287, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9288, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9289, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9330, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9343, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9287, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9288, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9289, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9419, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9578, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9580, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9581, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9701, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9757, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9758, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9865, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9886, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13009, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13094, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13103, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13106, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13138, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13147, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13149, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13178, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13182, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13301, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13311, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13370, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13371, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13444, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13465, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13596, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13599, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13614, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13619, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13635, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13661, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13662, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13701, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13702, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13815, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13838, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13868, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13870, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13886, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13917, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13925, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13926, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13933, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13962, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13994, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14001, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14010, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14015, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14018, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14097, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14098, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14125, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14143, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14154, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14158, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14174, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14201, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14202, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14224, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14251, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14260, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14261, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14302, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14308, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14412, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14418, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14452, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14489, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14528, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14591, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			else
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE), arg_85_4)
			end
		end
	end

	if arg_85_1._card:hasSkills({
		6401
	}) and arg_85_1._card._status == BattleData.CardStatus.board then
		arg_85_3 = arg_85_0:uiRandomTable(arg_85_3, #arg_85_3)
	end

	local var_85_15 = BattleListDialog.create(arg_85_0._battleUi, arg_85_3, var_85_0, var_85_1, arg_85_0, arg_85_1._card)

	var_85_15._choiceBase = arg_85_5 or arg_85_1._card:hasSkills({
		3202,
		3361,
		3363,
		3368,
		3391,
		3456,
		3468,
		3470,
		3481,
		3670,
		3809,
		3822,
		3834,
		3914,
		3919,
		6321,
		6333,
		6484,
		6559,
		6598,
		6650,
		6691,
		6692,
		6754,
		6882,
		6883,
		6897,
		2406
	}) and 3 or arg_85_1._card:hasSkills({
		3492,
		3606,
		3892
	}) and 2 or 1
	var_85_15._choiceParam = arg_85_6
	var_85_15._alreadySatisfied = var_85_2

	var_85_15:setChoiceFunction(function(arg_86_0)
		return arg_85_0:checkChoiceGrave(arg_86_0, arg_85_1, arg_85_2, arg_85_4)
	end, function(arg_87_0)
		return arg_85_0:onChoiceGrave(arg_87_0, arg_85_1, arg_85_2)
	end, function(arg_88_0)
		return arg_85_0:cancelChoiceGrave(arg_88_0, arg_85_1, arg_85_2)
	end)
	var_85_15:show()

	arg_85_0._battleUi._choiceGraveDialog = var_85_15
end

function var_0_0.onChoiceGrave(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	local var_89_0 = arg_89_1:getSelectedCards()

	arg_89_0._battleUi._choiceGraveDialog = nil

	if arg_89_2._card._status ~= BattleData.CardStatus.leave then
		arg_89_2:setVisible(true)
	end

	local var_89_1 = 0

	if arg_89_2._card:hasSkills({
		4048,
		4171,
		4186,
		4207,
		4290,
		4454,
		4497,
		4521,
		4735,
		4736,
		4740,
		4748,
		4836,
		7144,
		7373,
		7693
	}) or arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:hasSkills({
		3874,
		3885,
		2375
	}) or arg_89_2._card._status == BattleData.CardStatus.board and arg_89_2._card:hasSkills({
		2243,
		2318
	}) or arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_2._card:hasSkills({
		2985
	}) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
		2982,
		4305,
		4511,
		4514,
		4526,
		4530,
		4861,
		4957,
		4979,
		5244,
		5280,
		5298,
		7544,
		7579,
		7622,
		7631,
		7731,
		7753
	}) and not arg_89_2._card:isSkillAtIndex(7733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(3705, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(3850, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(2324, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(4978, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(4980, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5430, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5431, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5452, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5470, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5485, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5544, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5549, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7673, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7674, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7732, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7785, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7831, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9796, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9868, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13119, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13259, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13264, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13292, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13348, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13718, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13736, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13850, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13920, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13989, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14390, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14487, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14519, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14541, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14555, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_2 = arg_89_1._choiceParam

		if var_89_2 then
			local var_89_3 = arg_89_0._player:getMergeCandidatesByTriggerCard(var_89_2, arg_89_2._card, (arg_89_2._card._infoId == 30429 or arg_89_2._card._infoId == 21067) and math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or (arg_89_2._card._infoId == 20991 or arg_89_2._card._infoId == 30113 or arg_89_2._card._infoId == 30442 or arg_89_2._card._infoId == 30467 or arg_89_2._card._infoId == 30469 or arg_89_2._card._infoId == 30510 or arg_89_2._card:isSkillAtIndex(13264, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7732, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7785, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7831, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14487, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14541, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3))) and 2 or nil)

			var_89_1 = B.getChoiceByCandidatePos(var_89_3, var_89_0)

			if arg_89_1._choiceBase % 10 == 0 then
				var_89_1 = var_89_1 * 100
			end

			if not arg_89_2._card:hasSkills({
				3705,
				3850,
				2243,
				2318,
				2324,
				2375,
				2982,
				2985,
				3874,
				3885,
				7144,
				7373,
				7693
			}) and var_89_2._infoId ~= 40534 then
				local var_89_4, var_89_5 = var_89_2:hasChoiceSkill()

				if var_89_4 and B.isSkillChoiceSkill(var_89_5) then
					return arg_89_0:showChoiceSkill(arg_89_2, arg_89_3, var_89_5, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
				end
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(3851, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:hasSkills({
		2437,
		2560,
		2781,
		3940,
		6349,
		9453,
		9462
	}) or arg_89_2._card:isSkillAtIndex(2611, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9507, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9685, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13007, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7824, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_6 = arg_89_1._choiceParam

		if var_89_6 then
			local var_89_7 = arg_89_0._player:getSyncCandidatesByTriggerCard(var_89_6, arg_89_2._card)

			var_89_1 = B.getChoiceByCandidatePos(var_89_7, var_89_0)

			if arg_89_1._choiceBase % 10 == 0 then
				var_89_1 = var_89_1 * 100
			end
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(6753, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_8 = arg_89_1._choiceParam

		if var_89_8 then
			local var_89_9 = arg_89_0._player:getXYZCandidatesByTriggerCard(var_89_8, arg_89_2._card)

			var_89_1 = B.getChoiceByCandidatePos(var_89_9, var_89_0)

			if arg_89_1._choiceBase % 10 == 0 then
				var_89_1 = var_89_1 * 100
			end
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(9298, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_10 = arg_89_1._choiceParam

		if var_89_10 then
			local var_89_11 = arg_89_0._player:getLinkCandidatesByTriggerCard(var_89_10, arg_89_2._card)

			var_89_1 = B.getChoiceByCandidatePos(var_89_11, var_89_0)

			if arg_89_1._choiceBase % 10 == 0 then
				var_89_1 = var_89_1 * 100
			end
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and B.isSkillCeremony(arg_89_2._card._skills[1]._id) or arg_89_1._choiceBase ~= nil and arg_89_2._card:isSkillAtIndex(7576, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_12 = arg_89_1._choiceParam

		if var_89_12 then
			local var_89_13 = arg_89_1._choiceBase and math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0
			local var_89_14

			if arg_89_2._card:hasSkillFast(4214) then
				var_89_14 = arg_89_0._player:getCeremonyPileCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			elseif arg_89_2._card:hasSkillFast(4504) then
				var_89_14 = arg_89_0._player:get4504CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			elseif var_89_13 == 2 and arg_89_2._card._infoId ~= 21024 then
				if arg_89_2._card:hasSkillFast(4199) then
					var_89_14 = arg_89_0._player:getCeremonyGraveCandidatesByTriggerCard(var_89_12, arg_89_2._card)
				elseif arg_89_2._card:hasSkillFast(4576) then
					var_89_14 = arg_89_0._player:get4576CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
				else
					var_89_14 = arg_89_0._player:get4388CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
				end
			elseif arg_89_2._card:hasSkillFast(4585) then
				var_89_14 = arg_89_0._player:get4585CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			elseif arg_89_2._card:hasSkillFast(4597) then
				var_89_14 = arg_89_0._player:get4597CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			elseif arg_89_2._card:hasSkillFast(4648) then
				var_89_14 = arg_89_0._player:get4648CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			else
				var_89_14 = arg_89_0._player:getCeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			end

			var_89_1 = B.getChoiceByCandidatePos(var_89_14, var_89_0)

			if not var_89_12:hasSkills({
				3825
			}) then
				local var_89_15, var_89_16 = var_89_12:hasChoiceSkill()

				if var_89_13 ~= 2 and var_89_15 and B.isSkillChoiceSkill(var_89_16) then
					return arg_89_0:showChoiceSkill(arg_89_2, arg_89_3, var_89_16, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
				end
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(3320, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_17 = Data._skillInfo[3320]
		local var_89_18 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_17._refCards[2]))

		if #var_89_18 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_18), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkills({
		3456,
		6691,
		6692
	}) and arg_89_1._choiceBase == 3 then
		for iter_89_0 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_0]._pos - 1)
		end
	elseif arg_89_2._card:hasSkills({
		3476
	}) and arg_89_1._choiceParam == nil and arg_89_1._choiceBase == 2 * BattleData.ChoiceId.stage_3 then
		var_89_1 = var_89_0[1]._id

		local var_89_19 = Data._skillInfo[3476]
		local var_89_20 = B.mergeTable({
			arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_89_2._card),
			arg_89_0._player._opponent:getBattleCards("BCSD")
		})
		local var_89_21 = arg_89_0._player._opponent:getBattleCards("G")

		if #var_89_20 > 0 and #var_89_21 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_21, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkills({
		3538
	}) and arg_89_1._choiceParam == nil and arg_89_1._choiceBase == 2 then
		var_89_1 = var_89_0[1]._id

		local var_89_22 = Data._skillInfo[3538]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_22._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3540
	}) and arg_89_1._choiceParam == nil and arg_89_2._card._status == BattleData.CardStatus.grave then
		var_89_1 = var_89_0[1]._id

		local var_89_23 = Data._skillInfo[3540]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_23._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3555
	}) and arg_89_1._choiceParam == nil and arg_89_2._card._status == BattleData.CardStatus.board then
		var_89_1 = var_89_0[1]._id

		local var_89_24 = Data._skillInfo[3555]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("H", Data.CardType.monster), var_89_24._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(3714, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_25 = Data._skillInfo[3714]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(3737, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_26 = Data._skillInfo[3737]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_26._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3835
	}) and arg_89_1._choiceParam == nil and arg_89_2._card._status == BattleData.CardStatus.board then
		var_89_1 = var_89_0[1]._id

		local var_89_27 = Data._skillInfo[3835]
		local var_89_28 = var_89_0[1]:getStar()
		local var_89_29 = B.mergeTable({
			B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_28), var_89_27._refCards[1]),
			B.filterInCategoryCards(arg_89_0._player._opponent:getBattleCardsByMaxStar("G", var_89_28), var_89_27._refCards[1])
		})

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_29, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(3866, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(3950, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3809,
		4124
	}) then
		for iter_89_1 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_1]._pos + (var_89_0[iter_89_1]._owner == arg_89_2._card._owner and 0 or Data.MAX_CARD_COUNT_ON_BOARD) - 1)
		end
	elseif arg_89_2._card:hasSkills({
		3919
	}) and arg_89_2._card._status == BattleData.CardStatus.hand then
		for iter_89_2 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_2]._pos + (var_89_0[iter_89_2]._owner == arg_89_2._card._owner and 0 or Data.MAX_CARD_COUNT_ON_BOARD) - 1)
		end
	elseif arg_89_2._card:isSkillAtIndex(3957, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_30 = Data._skillInfo[3957]
		local var_89_31 = B.sortCardsByBoardPos(B.filterCanBindAlterMagicCards(B.filterInCategoryCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_30._val[1]), var_89_30._refCards[2]), var_89_30._refCards[3]), var_89_0[1]))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_31, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(3974, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_32 = Data._skillInfo[3974]

		var_89_1 = var_89_0[1]._id

		local var_89_33 = arg_89_0._player:getBattleCardsByCategoryGroup("H", var_89_32._refCards)

		var_89_33[#var_89_33 + 1] = var_89_0[1]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_33, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3994
	}) then
		local var_89_34 = arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCards("BSD", Data.CARD_MAX_LEVLE, arg_89_2._card))

		for iter_89_3 = 1, #var_89_34 do
			var_89_34[iter_89_3]._tempPos = iter_89_3
		end

		for iter_89_4 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_4]._tempPos - 1)
		end

		for iter_89_5 = 1, #var_89_34 do
			var_89_34[iter_89_5]._tempPos = nil
		end
	elseif arg_89_2._card:hasSkills({
		4095,
		4318
	}) then
		local var_89_35 = arg_89_0._player:filterCanChangeToHandCards(B.filterNoSkillCards(arg_89_0._player:getBattleCards("H"), arg_89_2._card._skills[1]._id))

		for iter_89_6 = 1, #var_89_35 do
			var_89_35[iter_89_6]._tempPos = iter_89_6
		end

		for iter_89_7 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_7]._tempPos - 1)
		end

		for iter_89_8 = 1, #var_89_35 do
			var_89_35[iter_89_8]._tempPos = nil
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
		4100
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_36 = Data._skillInfo[4100]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_36._refCards[1]), true, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		4140
	}) then
		for iter_89_9 = 1, #arg_89_1._cardInfos do
			arg_89_1._cardInfos[iter_89_9]._tempIndex = iter_89_9
		end

		for iter_89_10 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_10]._tempIndex - 1)
		end

		for iter_89_11 = 1, #arg_89_1._cardInfos do
			arg_89_1._cardInfos[iter_89_11]._tempIndex = nil
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_2._card:hasSkills({
		4157
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_37 = Data._skillInfo[4157]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			arg_89_0._player:getBattleCards("C"),
			arg_89_0._player._opponent:getBattleCards("C")
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.field and arg_89_2._card:hasSkills({
		4411
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_38 = Data._skillInfo[4411]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
		4431
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_39 = Data._skillInfo[4431]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filter4431Cards(arg_89_0._player:getBattleCardsByMinStar("H", var_89_39._val[1]), arg_89_0._player), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		4445
	}) and arg_89_1._choiceParam ~= nil then
		var_89_1 = arg_89_1._choiceParam * 4000

		for iter_89_12 = 1, #var_89_0 do
			if var_89_0[iter_89_12] == arg_89_2._card._owner._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_COVER * 2)
			elseif var_89_0[iter_89_12] == arg_89_2._card._owner._opponent._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_COVER * 2 + 1)
			else
				var_89_1 = var_89_1 + 2^(var_89_0[iter_89_12]._pos + (var_89_0[iter_89_12]._owner == arg_89_2._card._owner and 0 or Data.MAX_CARD_COUNT_ON_COVER) - 1)
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(4465, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil or arg_89_2._card:isSkillAtIndex(4798, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_40 = Data._skillInfo[4465]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterEquipMagicCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_40._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4486, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_41 = Data._skillInfo[4486]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_41._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4529, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_42 = Data._skillInfo[4529]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInTypeCards(arg_89_0._player:getBattleCardsByKeywordGroup("P", var_89_42._refCards), Data.CardType.magic))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4572, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_43 = Data._skillInfo[4572]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), var_89_43._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4589) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_44 = B.mergeTable({
			arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]),
			arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster)
		})

		if #var_89_44 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_44, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkillFast(4594) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_45 = Data._skillInfo[4594]
		local var_89_46 = B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("GP", var_89_45._refCards[2])))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_46, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4596, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_47 = Data._skillInfo[4596]
		local var_89_48 = B.sortCardsByBoardPos(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByHp("P", 0), var_89_47._refCards[1]))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_48, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4628) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_49 = Data._skillInfo[4628]
		local var_89_50 = arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryGroupCards(arg_89_0._player:getBattleCardsByMaxStar("L", var_89_49._val[1]), var_89_49._refCards))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_50, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4631, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_51 = Data._skillInfo[4631]
		local var_89_52 = arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_51._refCards[2]), arg_89_2._card))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_52, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4633, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_53 = Data._skillInfo[4633]
		local var_89_54 = arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_53._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), true))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_54, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4666) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(4678, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_55 = Data._skillInfo[4678]
		local var_89_56 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("L", var_89_55._refCards[2]), nil, nil, nil, true)

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_56, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4689) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:hasSkillFast(4701) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(4728, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_57 = Data._skillInfo[4728]
		local var_89_58 = B.filterFirstCards(arg_89_0._player:getBattleCards("P", Data.CARD_MAX_LEVEL, var_89_0[1]), 2)

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_58, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4804, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4821, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(4827, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_59 = Data._skillInfo[4827]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_59._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4840, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_60 = Data._skillInfo[4840]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4872) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_61 = Data._skillInfo[4872]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByMinStar("G", 0)), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4872) and arg_89_1._choiceParam ~= nil then
		arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_89_2._card,
			_target = arg_89_0._player:getCardById(arg_89_1._choiceParam),
			_choice = (var_89_0[1]._id * BattleData.UseCardId.id_group + var_89_0[2]._id) * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase
		})

		return
	elseif arg_89_2._card:isSkillAtIndex(4941, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_62 = Data._skillInfo[4941]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_62._refCards[1]), arg_89_2._card))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4942, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_63 = arg_89_0._player._opponent:getBattleCards("BCSD")

		if #var_89_63 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_63), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(4944, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_64 = Data._skillInfo[4944]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotInStarCards(arg_89_0._player:getBattleCardsByKeywordGroup("P", var_89_64._refCards), var_89_0[1]:getStar()), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4983, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_65 = Data._skillInfo[4983]
		local var_89_66 = arg_89_0._player._opponent:getBattleCards("BCSD")

		if #var_89_66 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_66), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkillFast(4984) and arg_89_3 == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_67 = Data._skillInfo[4984]
		local var_89_68 = arg_89_0._player:filterCanChangeToHandCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByInfoId("P", var_89_67._refCards[1]),
			arg_89_0._player:getBattleCardsByKeywordGroup("P", {
				var_89_67._refCards[2],
				var_89_67._refCards[3]
			})
		}))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), B.sortCardsByBoardPos(var_89_68), 2, arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(4991, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("CSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4993, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_69 = Data._skillInfo[4993]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_69._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
		5104
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_70 = Data._skillInfo[5104]
		local var_89_71 = B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInNatureCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_70._val[1]), var_89_70._refCards[2]), var_89_70._refCards[3])))

		if #var_89_71 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_71, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkills({
		5118
	}) and arg_89_1._choiceBase % BattleData.ChoiceId.stage_size_1 == 1 and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_72 = Data._skillInfo[5118]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterNotBindedCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_72._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_0[1]:getAlterMagicInfoId()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5232) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_73 = Data._skillInfo[5232]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_73._refCards[1]), var_89_0[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5283, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(5285, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5285, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam ~= nil then
		local var_89_74 = {
			arg_89_0._player:getCardById(arg_89_1._choiceParam)
		}

		for iter_89_13 = 1, #var_89_0 do
			var_89_74[#var_89_74 + 1] = var_89_0[iter_89_13]
		end

		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_74)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5332) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_75 = Data._skillInfo[5332]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5343) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_76 = Data._skillInfo[5343]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5440, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_77 = Data._skillInfo[5440]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByNature("R", var_89_77._refCards[1]), true), var_89_0[1]._info._star + 1), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5445) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_78 = Data._skillInfo[5445]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_78._refCards[1]), var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5450, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		if arg_89_3 == nil then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), arg_89_0._player:getBattleCards2By5450(var_89_0[1]), 1, arg_89_1._choiceBase)
		else
			var_89_1 = var_89_0[1]._id

			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterSyncCards(arg_89_0._player:getBattleCardsByStar("R", arg_89_3._card:getStar() + var_89_0[1]:getStar()), true), true, true, nil, true), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5461) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_79 = Data._skillInfo[5461]

		if #arg_89_0._player:getBattleCardsByInfoId("B", var_89_79._refCards[3]) > 0 and #arg_89_0._player._opponent:getBattleCards("BCSD") > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(5463, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_80 = Data._skillInfo[5463]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_80._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5472) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_81 = Data._skillInfo[5472]
		local var_89_82 = arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1])

		if #var_89_82 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_82, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5476) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_83 = Data._skillInfo[5476]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("BG", Data.CardType.monster), var_89_83._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5502, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_84 = Data._skillInfo[5502]
		local var_89_85 = B.filterXYZCards(arg_89_0._player:getBattleCardsByCategory("B", var_89_84._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), true)

		if #var_89_85 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_85), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5503) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(5505, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5508) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5517) then
		if arg_89_1._choiceParam == nil then
			var_89_1 = var_89_0[1]._id

			local var_89_86 = Data._skillInfo[5517]
			local var_89_87 = B.filterInCategoryCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_86._refCards[3])

			return arg_89_0:showChoiceGrave(arg_89_2, nil, B.sortCardsByBoardPos(var_89_87), 2, arg_89_1._choiceBase, var_89_1)
		else
			for iter_89_14 = #var_89_0, 1, -1 do
				var_89_1 = var_89_1 * BattleData.UseCardId.id_group + var_89_0[iter_89_14]._id
			end

			return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = arg_89_2._card,
				_target = arg_89_0._player:getCardById(arg_89_1._choiceParam),
				_choice = var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase
			})
		end
	elseif arg_89_2._card:isSkillAtIndex(5539, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("G"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5543) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_88 = Data._skillInfo[5543]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_88._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5561, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_89 = Data._skillInfo[5561]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_89._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5566, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_90 = Data._skillInfo[5566]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_90._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5571, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_91 = Data._skillInfo[5571]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("G", var_89_91._refCards)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5572, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_92 = Data._skillInfo[5572]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByInfoIdGroup("G", var_89_92._refCards), true, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5595) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(5597, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_93 = Data._skillInfo[5597]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterHasOppoShieldCards(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5603, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_94 = Data._skillInfo[5603]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByNature("B", var_89_94._refCards[2], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5605, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_95 = Data._skillInfo[5605]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldTrap, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5608) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(5614, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_96 = Data._skillInfo[5614]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5617, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_97 = Data._skillInfo[5617]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5622) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_98 = Data._skillInfo[5622]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5624) and arg_89_3 == nil then
		local var_89_99 = Data._skillInfo[5624]
		local var_89_100 = B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1]))
		})

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), var_89_100, math.min(2, #var_89_100), arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(5646, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_101 = Data._skillInfo[5646]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_101._refCards[2]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		6265
	}) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_102 = Data._skillInfo[6265]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByKeyword("G", var_89_102._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		6286
	}) and arg_89_2._card._status == BattleData.CardStatus.board and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_103 = Data._skillInfo[6286]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByNature("P", var_89_103._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6365, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_104 = Data._skillInfo[6365]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterCanBindAlterMagicCards(B.filterAdjustCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_104._refCards[1]), true), arg_89_2._card), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6396, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_105 = Data._skillInfo[6396]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6507, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_106 = Data._skillInfo[6507]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		6616
	}) and arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_107 = Data._skillInfo[6616]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByAtkDef("G", 2400, 1000),
			arg_89_0._player:getBattleCardsByAtkDef("G", 2800, 1000)
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6618, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_108 = Data._skillInfo[6618]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_108._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6619, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_109 = Data._skillInfo[6619]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInStarCards(B.filterAdjustCards(arg_89_0._player:getBattleCards("P"), true), var_89_0[1]:getStar())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6679, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_110 = Data._skillInfo[6679]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6732, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_111 = Data._skillInfo[6732]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster))), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam ~= nil then
		local var_89_112 = {
			arg_89_0._player:getCardById(arg_89_1._choiceParam)
		}

		for iter_89_15 = 1, #var_89_0 do
			var_89_112[#var_89_112 + 1] = var_89_0[iter_89_15]
		end

		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_112)
	elseif arg_89_2._card:isSkillAtIndex(6735, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_113 = Data._skillInfo[6735]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("G")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6746, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_114 = Data._skillInfo[6746]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStarGroup("G", {
			var_89_114._refCards[2],
			var_89_114._refCards[3]
		}), var_89_114._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6772, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_115 = Data._skillInfo[6772]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), var_89_115._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6792, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		for iter_89_16 = 1, #var_89_0 do
			if var_89_0[iter_89_16] == arg_89_2._card._owner._opponent._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_BOARD + Data.MAX_CARD_COUNT_ON_COVER)
			elseif var_89_0[iter_89_16]._status ~= BattleData.CardStatus.board then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_BOARD + var_89_0[iter_89_16]._pos - 1)
			else
				var_89_1 = var_89_1 + 2^(var_89_0[iter_89_16]._pos - 1)
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(6795, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_116 = Data._skillInfo[6795]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_116._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6861, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		for iter_89_17 = 1, #var_89_0 do
			if var_89_0[iter_89_17] == arg_89_2._card._owner._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_COVER * 2)
			elseif var_89_0[iter_89_17] == arg_89_2._card._owner._opponent._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_COVER * 2 + 1)
			else
				var_89_1 = var_89_1 + 2^(var_89_0[iter_89_17]._pos + (var_89_0[iter_89_17]._owner == arg_89_2._card._owner and 0 or Data.MAX_CARD_COUNT_ON_COVER) - 1)
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(6841, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_117 = Data._skillInfo[6841]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_2._card:getBindedEquipsByKeyword(var_89_117._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6848, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_118 = Data._skillInfo[6848]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_118._refCards[2])))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6921, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_119 = Data._skillInfo[6921]
		local var_89_120 = B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_119._refCards[1])))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_120, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6964, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6978, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSDG")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6982, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_121 = Data._skillInfo[6982]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByInfoIdGroup("B", {
			var_89_121._refCards[2],
			var_89_121._refCards[3]
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2111, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2112, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_122 = Data._skillInfo[2112]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", var_89_122._refCards))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2116, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2117, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_123 = arg_89_0._player._opponent:getBoardCards()

		if #var_89_123 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_123), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(2135, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_124 = Data._skillInfo[2135]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStarGroup("G", {
			7,
			8
		}), var_89_124._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2142, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2155, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		if var_89_0[1]:isMerge() then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterMergeCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
		elseif var_89_0[1]:isSync() then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterSyncCards(arg_89_0._player._opponent:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
		elseif var_89_0[1]:isXYZ() then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player._opponent:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(2160, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2196, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2203, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2209, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNormalCards(arg_89_0._player:getBattleCards("G")))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2212, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2279, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_125 = Data._skillInfo[2279]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_125._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2320, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_126 = Data._skillInfo[2320]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterMoreThanStarCards(arg_89_0._player:getBattleCardsByMaxQuality("G", 4), var_89_126._val[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2341, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_127 = Data._skillInfo[2341]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_89_2._card))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2359, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2384, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2389, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2392, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_128 = Data._skillInfo[2392]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_128._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2400, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2409, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_129 = Data._skillInfo[2409]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("H", var_89_129._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2429, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_130 = Data._skillInfo[2429]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStar("R", var_89_0[1]:getStar() + arg_89_2._card:getStar()), var_89_130._refCards[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2430, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_131 = Data._skillInfo[2430]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterAdjustCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByHp("P", 0), var_89_131._refCards[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2434, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_132 = Data._skillInfo[2434]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]))),
			B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBoardCards()))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2441, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_133 = Data._skillInfo[2441]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2449, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_134 = Data._skillInfo[2449]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByMinStar("B", 0)),
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByMinStar("B", 0))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2450, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_135 = Data._skillInfo[2450]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByMinStar("B", 0)),
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByMinStar("B", 0))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2486, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2487, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_136 = Data._skillInfo[2487]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("G", 7), var_89_136._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2534, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_137 = Data._skillInfo[2534]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_137._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2562, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_138 = Data._skillInfo[2562]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoId("P", var_89_138._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2578, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_139 = Data._skillInfo[2578]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotEqualInfoIdExCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_139._refCards[1]), var_89_139._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2585, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_140 = Data._skillInfo[2585]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByNature("B", var_89_140._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2586, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2587, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_141 = Data._skillInfo[2587]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByNature("B", var_89_141._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2588, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
			B.sortCardsByBoardPos(arg_89_0._player:getBoardCards())
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2598, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2599, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBoardCards())),
			B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBoardCards()))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2602, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2615, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_142 = Data._skillInfo[2615]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMinStar("B", var_89_0[1]:getStar() + 1), var_89_142._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2739, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2745, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2750, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_143 = Data._skillInfo[2750]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("G", var_89_143._val[1], Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_143._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2772, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_144 = Data._skillInfo[2772]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_144._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2774, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_145 = Data._skillInfo[2774]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_145._refCards[1]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2776, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_0)

		local var_89_146 = Data._skillInfo[2776]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2785, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_147 = Data._skillInfo[2785]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]), false)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2787, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_148 = Data._skillInfo[2787]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_148._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2789, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_149 = Data._skillInfo[2789]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_149._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2806, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_150 = Data._skillInfo[2806]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_150._val[1]), var_89_150._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2811, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2813, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_151 = Data._skillInfo[2813]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeywordGroup("P", var_89_151._refCards))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2838, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_152 = Data._skillInfo[2838]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_152._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]._binds[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2867, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_153 = Data._skillInfo[2867]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_153._val[1]), var_89_153._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2879, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2886, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_154 = Data._skillInfo[2886]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByStar("P", var_89_154._val[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2915, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_155 = Data._skillInfo[2915]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_155._refCards[1]), arg_89_2._card))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2928, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_156 = Data._skillInfo[2928]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByInfoIdGroup("G", {
			var_89_156._refCards[2],
			var_89_156._refCards[3]
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2930, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_0)

		local var_89_157 = Data._skillInfo[2930]
		local var_89_158 = arg_89_0._player._opponent:getBattleCards("BCSD")

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_158), math.min(#var_89_158, 2), arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2930, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam ~= nil then
		var_89_1 = arg_89_1._choiceParam + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2942, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_159 = Data._skillInfo[2942]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2951, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_160 = Data._skillInfo[2951]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2959, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_161 = Data._skillInfo[2959]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByMaxStar("G", var_89_161._val[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2963, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_162 = Data._skillInfo[2963]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterSyncCards(arg_89_0._player:getBattleCardsByCategoryAndNature("G", var_89_162._refCards[2], var_89_162._refCards[3]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2969, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_163 = Data._skillInfo[2969]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2964, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 8, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(2976, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 8, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(2986, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldMonster)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9009, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9034, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByBuff("B", true, BattleData.PositiveType.defendPosture)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9051, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_164 = Data._skillInfo[9051]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategory("BHG", var_89_164._refCards[2], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9052, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_165 = Data._skillInfo[9051]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategory("BHG", var_89_165._refCards[2], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9071, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9072, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_166 = Data._skillInfo[9072]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1])),
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9092, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9124, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_167 = Data._skillInfo[9124]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_167._refCards[1]), var_89_167._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9142, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9165, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9168, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9189, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9198, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_168 = Data._skillInfo[9198]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_168._refCards[1]), arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9204, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9213, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_169 = Data._skillInfo[9213]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_169._refCards[1]), arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9214, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_170 = Data._skillInfo[9214]

		var_89_1 = var_89_0[1]._id

		local var_89_171 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMinStar("P", var_89_170._val[1]), var_89_170._refCards[1]))

		if #var_89_171 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_171), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(9218, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_172 = Data._skillInfo[9218]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_172._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9220, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSDG")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9227, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9230, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9258, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterDualCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1])))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9260, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9269, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9282, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9289, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9305, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_173 = Data._skillInfo[9305]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInNatureCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_173._val[1]), var_89_173._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9306, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_174 = Data._skillInfo[9306]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInNatureCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_174._val[1]), var_89_174._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9314, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_175 = Data._skillInfo[9314]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByStar("P", var_89_175._val[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9320, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9323, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9330, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_176 = Data._skillInfo[9330]
		local var_89_177 = B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("H", Data.CardType.monster), var_89_176._refCards[1])

		for iter_89_18 = 1, #var_89_177 do
			var_89_177[iter_89_18]._tempPos = iter_89_18
		end

		for iter_89_19 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_19]._tempPos - 1)
		end

		for iter_89_20 = 1, #var_89_177 do
			var_89_177[iter_89_20]._tempPos = nil
		end
	elseif arg_89_2._card:hasSkillFast(9343) then
		for iter_89_21 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_21]._pos - 1)
		end
	elseif arg_89_2._card:isSkillAtIndex(9373, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterSustainableMagicCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic)))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9375, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByType("G", Data.CardType.rare, Data.CARD_MAX_LEVEL, var_89_0[1]),
			arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.rare, Data.CARD_MAX_LEVEL, var_89_0[1])
		}), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9378, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_178 = Data._skillInfo[9378]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("HG", var_89_0[1]:getStar()), var_89_178._refCards[2]), var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9392, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_179 = Data._skillInfo[9378]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_0[1]:getStar()), var_89_179._refCards[2]), var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9382, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBattleCards("CSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9396, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_180 = Data._skillInfo[9396]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotBindedAllInfoIdGroupCards(arg_89_0._player:getBattleCardsByInfoId("B", var_89_180._refCards[2]), {
			var_89_180._refCards[3],
			var_89_180._refCards[4],
			var_89_180._refCards[5],
			var_89_180._refCards[6],
			var_89_180._refCards[7]
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif (arg_89_2._card:isSkillAtIndex(9480, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9481, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3))) and arg_89_1._choiceParam == nil then
		local var_89_181 = Data._skillInfo[9480]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_181._refCards[2]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9485, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_182 = Data._skillInfo[9485]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByType("G", Data.CardType.trap),
			arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.trap)
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9497, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_183 = Data._skillInfo[9497]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", var_89_183._refCards))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9513, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9515, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9518, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9523, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9556, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("C"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9563, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_184 = Data._skillInfo[9563]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_184._refCards[1]), arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9593, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_185 = Data._skillInfo[9593]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("P", var_89_185._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9600, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_186 = Data._skillInfo[9600]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterNotInStarCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_186._refCards[1]), var_89_0[1]:getStar()), arg_89_2._card))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9614, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_187 = Data._skillInfo[9614]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_187._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9615, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_188 = Data._skillInfo[9615]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_188._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9638, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_189 = Data._skillInfo[9638]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByCategory("P", var_89_189._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9694, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if #var_89_0 > 0 then
			var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

			if #arg_89_1._cardInfos > 1 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
			end
		else
			var_89_1 = arg_89_1._choiceParam or 0
		end
	elseif arg_89_2._card:isSkillAtIndex(9712, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("R"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9721, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_190 = Data._skillInfo[9733]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterUniqueInfoIdCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_190._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9739, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9763, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if arg_89_3 == nil then
			var_89_1 = var_89_0[1]._id

			local var_89_191 = Data._skillInfo[9763]
			local var_89_192 = B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("BH", 0), var_89_191._refCards[1])

			return arg_89_0:showChoiceGrave(arg_89_2, {
				_card = var_89_0[1]
			}, B.sortCardsByBoardPos(var_89_192), #var_89_192, arg_89_1._choiceBase)
		else
			var_89_1 = 0

			for iter_89_22 = 1, #var_89_0 do
				local var_89_193 = var_89_0[iter_89_22]._pos

				if var_89_0[iter_89_22]._status == BattleData.CardStatus.hand then
					var_89_193 = var_89_193 + Data.MAX_CARD_COUNT_ON_BOARD + 1
				end

				var_89_1 = var_89_1 + 2^var_89_193
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(9766, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9768, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9785, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_194 = Data._skillInfo[9785]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_194._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9786, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_195 = Data._skillInfo[9786]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9815, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9841, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_196 = arg_89_0._player:getBattleCardsByType("G", Data.CardType.magic)
		local var_89_197 = B.filterSustainableMagicCards(var_89_196)

		B.appendTable(var_89_197, B.filterFieldMagicCards(var_89_196))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(var_89_197), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9851, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_198 = Data._skillInfo[9851]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_198._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9867, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_199 = Data._skillInfo[9867]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByMaxStar("H", var_89_0[1]:getStar())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9916, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_200 = Data._skillInfo[9916]
		local var_89_201 = #arg_89_0._player:getBattleCardsByInfoId("SD", var_89_200._refCards[2]) > 0
		local var_89_202 = arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_200._refCards[1]))

		if var_89_201 then
			B.appendTable(var_89_202, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByCategory("P", var_89_200._refCards[3])))

			var_89_202 = B.filterUniqueInfoIdCards(var_89_202)
		end

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_202), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9917, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_203 = Data._skillInfo[9917]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("H", var_89_0[1]:getStar()), var_89_203._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9918, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_204 = Data._skillInfo[9918]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategory("B", var_89_204._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card), var_89_204._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9934, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterFieldMagicCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic)))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9944, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._alreadySatisfied then
		arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_89_2._card,
			_target = arg_89_3 ~= nil and arg_89_3._card or nil,
			_choice = arg_89_1._choiceBase
		})
	elseif arg_89_2._card:isSkillAtIndex(9956, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBattleCardsByNoBuff("B", true, BattleData.PositiveType.xyzMark), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9960, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_205 = Data._skillInfo[9960]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_205._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9965, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_206 = Data._skillInfo[9965]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoId("PG", var_89_206._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9983, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_207 = Data._skillInfo[9983]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_207._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9984, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_208 = Data._skillInfo[9984]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("HP", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_208._refCards[2]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13002, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_209 = Data._skillInfo[13002]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", {
			var_89_209._refCards[2],
			var_89_209._refCards[3]
		}))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13009, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13039, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("G"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13044, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13045, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13054, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_210 = Data._skillInfo[13054]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("P", var_89_210._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13068, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_211 = Data._skillInfo[13068]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterNormalTrapCards(arg_89_0._player:getBattleCardsByType("GL", Data.CardType.trap))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13072, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_212 = Data._skillInfo[13072]
		local var_89_213 = B.filterNotBindedCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_212._refCards[2]), var_89_0[1]:getAlterMagicInfoId())

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_213), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13106, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13138, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13141, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 8, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(13147, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = 0

		for iter_89_23 = 1, #var_89_0 do
			local var_89_214 = var_89_0[iter_89_23]._pos

			if var_89_0[iter_89_23]._status == BattleData.CardStatus.hand then
				var_89_214 = var_89_214 + Data.MAX_CARD_COUNT_ON_BOARD + 1
			end

			var_89_1 = var_89_1 + 2^var_89_214
		end
	elseif arg_89_2._card:isSkillAtIndex(13149, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13155, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = 0

		for iter_89_24 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_24]._pos - 1)
		end

		local var_89_215 = Data._skillInfo[13155]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13156, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = 0

		for iter_89_25 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_25]._pos - 1)
		end

		local var_89_216 = Data._skillInfo[13156]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_216._refCards[1]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13157, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = 0

		for iter_89_26 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_26]._pos - 1)
		end

		local var_89_217 = Data._skillInfo[13157]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterHasOppoShieldCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13165, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_218 = Data._skillInfo[13165]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByStar("P", var_89_218._val[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13168, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_219 = Data._skillInfo[13168]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_219._refCards[1]), var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13185, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_220 = Data._skillInfo[13185]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("H", var_89_220._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13218, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13220, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13221, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13223, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13231, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13275, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13276, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_221 = arg_89_0._player:filterCanChangeToHandCards(B.filterNoSkillCards(arg_89_0._player:getBattleCards("H"), arg_89_2._card._skills[1]._id))

		for iter_89_27 = 1, #var_89_221 do
			var_89_221[iter_89_27]._tempPos = iter_89_27
		end

		for iter_89_28 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_28]._tempPos - 1)
		end

		for iter_89_29 = 1, #var_89_221 do
			var_89_221[iter_89_29]._tempPos = nil
		end
	elseif arg_89_2._card:isSkillAtIndex(13296, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_222 = Data._skillInfo[13296]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterLinkCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_222._refCards[1]), false)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13318, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_223 = Data._skillInfo[13318]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_223._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13321, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_224 = Data._skillInfo[13321]
		local var_89_225 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_224._refCards[1]))

		if #var_89_225 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_225, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13330, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_226 = Data._skillInfo[13330]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterDieByAttackOrEffectCards(B.mergeTable({
			B.filterOnGraveRoundCards(arg_89_0._player._graveCards, arg_89_0._player._round),
			B.filterOnGraveEndRoundCards(arg_89_0._player._opponent._graveCards, arg_89_0._player._opponent._endRound)
		}))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13332, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_227 = Data._skillInfo[13332]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_89_0._player:getBattleCardsByMaxQuality("B", var_89_227._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13365, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_228 = Data._skillInfo[13365]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("PG", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_228._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13367, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_229 = Data._skillInfo[13367]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13370, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		for iter_89_30 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_30]._pos - 1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13371, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13373, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_230 = Data._skillInfo[13373]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13380, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_231 = Data._skillInfo[13380]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player._opponent:getBattleCardsByMaxQuality("G", var_89_231._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13398, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_232 = Data._skillInfo[13398]
		local var_89_233 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_232._refCards[1]))

		if #var_89_233 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_233), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13401, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_234 = Data._skillInfo[13401]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13405, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_235 = Data._skillInfo[13405]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_235._refCards[2]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13408, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_236 = Data._skillInfo[13408]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByInfoIdGroup("BSD", var_89_236._refCards), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13411, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_237 = Data._skillInfo[13411]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_237._refCards[1]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13430, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_238 = Data._skillInfo[13430]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13432, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_239 = Data._skillInfo[13432]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13452, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_240 = Data._skillInfo[13452]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13468, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_241 = Data._skillInfo[13468]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBattleCards("BCSD"))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13538, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_242 = Data._skillInfo[13538]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_242._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13552, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_243 = Data._skillInfo[13552]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_243._refCards[1]), var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13553, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_244 = Data._skillInfo[13553]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_244._refCards[1]), var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13572, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_245 = Data._skillInfo[13572]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_245._refCards[1]), var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13602, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_246 = Data._skillInfo[13602]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInTypeCards(arg_89_0._player:getBattleCardsByKeyword("GL", var_89_246._refCards[2]), Data.CardType.monster)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13607, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_247 = Data._skillInfo[13607]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_247._refCards[1]), arg_89_2._card), nil, nil, nil, var_89_0[1]._status == BattleData.CardStatus.board), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13576, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_248 = Data._skillInfo[13576]
		local var_89_249 = B.filterFirstCards(arg_89_0._player:getBattleCards("P", Data.CARD_MAX_LEVEL, var_89_0[1]), 2)

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_249, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13618, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_250 = Data._skillInfo[13618]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_250._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13626, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_251 = Data._skillInfo[13626]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13697, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13703, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_252 = Data._skillInfo[13703]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotSameNamesCards(B.mergeTable({
			B.filterSustainableMagicCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), var_89_252._refCards[1])),
			B.filterSustainableTrapCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.trap), var_89_252._refCards[1]))
		}), arg_89_0._player:getBattleCards("CSD"))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13710, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_253 = Data._skillInfo[13710]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.mergeTable({
			B.filterNormalCards(arg_89_0._player:getBattleCardsByType("HP", Data.CardType.monster)),
			B.filterDualCards(arg_89_0._player:getBattleCardsByType("HP", Data.CardType.monster))
		}), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13719, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_254 = arg_89_0._player:filterCanChangeToHandCards(B.filterNoSkillCards(arg_89_0._player:getBattleCards("H"), arg_89_2._card._skills[1]._id))

		for iter_89_31 = 1, #var_89_254 do
			var_89_254[iter_89_31]._tempPos = iter_89_31
		end

		for iter_89_32 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_32]._tempPos - 1)
		end

		for iter_89_33 = 1, #var_89_254 do
			var_89_254[iter_89_33]._tempPos = nil
		end
	elseif arg_89_2._card:isSkillAtIndex(13733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_255 = Data._skillInfo[13733]
		local var_89_256 = arg_89_0._player:getBattleCardsByKeyword("H", var_89_255._refCards[1])

		for iter_89_34 = 1, #var_89_256 do
			var_89_256[iter_89_34]._tempPos = iter_89_34
		end

		for iter_89_35 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_35]._tempPos - 1)
		end

		for iter_89_36 = 1, #var_89_256 do
			var_89_256[iter_89_36]._tempPos = nil
		end
	elseif arg_89_2._card:isSkillAtIndex(13747, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 8, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(13764, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_257 = Data._skillInfo[13764]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_257._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13766, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_258 = Data._skillInfo[13766]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_258._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13767, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_259 = Data._skillInfo[13767]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_259._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13792, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_260 = Data._skillInfo[13792]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13793, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13847, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13851, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 5, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(13959, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13995, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByNature("B", var_89_0[1]._info._nature)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14010, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14020, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_261 = Data._skillInfo[14020]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_261._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14047, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_262 = Data._skillInfo[14047]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByKeyword("G", var_89_262._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14154, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14163, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14176, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_263 = Data._skillInfo[14176]
		local var_89_264 = arg_89_0._player:filterCanChangeToHandCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_263._val[1]), var_89_263._refCards[1]))

		if var_89_0[1]:getStar() == var_89_263._val[1] then
			B.appendTable(var_89_264, {
				var_89_0[1]
			})
		end

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_264), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14185, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14201, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player._opponent:getSingleBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14308, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player._opponent:getSingleBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14325, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 4, 5, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(14337, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_265 = Data._skillInfo[14337]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_265._refCards[1]), arg_89_2._card), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14411, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_266 = Data._skillInfo[14411]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByNature("G", var_89_266._refCards[1]), arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14441, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_267 = Data._skillInfo[14441]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14474, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14534, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14528, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player._opponent:getSingleBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14561, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_268 = Data._skillInfo[14561]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotInKeywordCards(arg_89_0._player:getBattleCardsByNature("P", var_89_268._refCards[1]), var_89_268._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14570, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_269 = Data._skillInfo[14570]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_269._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14579, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_270 = Data._skillInfo[14579]
		local var_89_271 = arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoId("P", var_89_270._refCards[4]))

		if #var_89_271 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_271), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(14588, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14598, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_272 = Data._skillInfo[14598]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCardsByMaxQuality("BCSD", var_89_272._refCards[2]), BattleData.PositiveType.shieldMonster, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14604, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_273 = Data._skillInfo[14604]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterInTypeCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_273._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card), Data.CardType.monster), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		7113
	}) then
		return arg_89_0:showChoiceSacrifice(arg_89_0:getCardSprite(var_89_0[1]), arg_89_2, arg_89_1._choiceBase + var_89_0[1]._id * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + 7, nil)
	elseif arg_89_2._card:isSkillAtIndex(7234, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_274 = Data._skillInfo[7234]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.mergeTable({
			B.filterCeremonyMonsterCards(arg_89_0._player:getBattleCardsByNature("P", var_89_274._refCards[1])),
			B.filterCeremonyMagicCards(arg_89_0._player:getBattleCards("P"))
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7244, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_275 = Data._skillInfo[7244]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_275._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7309, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_276 = Data._skillInfo[7309]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByHp("G", 0), var_89_276._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7310, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_277 = Data._skillInfo[7310]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterInCategoryCards(arg_89_0._player:getBattleCardsByHp("L", 0), var_89_277._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7328, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_278 = Data._skillInfo[7328]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInNatureCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMinStar("R", var_89_0[1]:getStar()), var_89_278._refCards[1]), var_89_0[1]._info._nature), true, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7336, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7337, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_279 = Data._skillInfo[7337]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_279._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7338, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_280 = Data._skillInfo[7338]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_280._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7365, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_281 = Data._skillInfo[7365]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategory("B", var_89_281._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7374, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7380, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_282 = Data._skillInfo[7380]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_282._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7404, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_283 = Data._skillInfo[7404]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInCategoryGroupCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_283._val[1]), {
			var_89_283._refCards[2],
			var_89_283._refCards[3],
			var_89_283._refCards[4]
		}))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7408, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_284 = Data._skillInfo[7408]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_284._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])), false, true, nil, var_89_0[1]._status == BattleData.CardStatus.board), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7429, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_285 = Data._skillInfo[7429]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_285._val[1]), var_89_285._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7433, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_286 = Data._skillInfo[7433]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByAtkDef("G", 0, 0), var_89_286._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7454, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_287 = Data._skillInfo[7454]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_287._refCards[1]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7534, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_288 = Data._skillInfo[7534]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_288._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7551, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_289 = Data._skillInfo[7551]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_289._refCards)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7566, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_290 = Data._skillInfo[7566]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BSD"), BattleData.PositiveType.shieldMagic)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(7574) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_291 = Data._skillInfo[7574]
		local var_89_292 = arg_89_0._player:getBattleCardsByCategory("PH", var_89_291._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])

		if #var_89_292 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_292), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkillFast(7578) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_293 = Data._skillInfo[7578]
		local var_89_294 = B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_293._refCards[1]), true)

		if #var_89_294 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_294), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(7582, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_295 = Data._skillInfo[7582]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterMergeCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_295._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(7628) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_3 == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_296 = Data._skillInfo[7628]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), B.sortCardsByBoardPos(B.filterUniqueInfoIdCards(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_296._refCards[2])))), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7635, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_297 = Data._skillInfo[7635]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_297._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7640, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_298 = arg_89_0._player._opponent:getBattleCards("BCSD")

		if #var_89_298 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_298), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkillFast(7646) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_3 == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_299 = Data._skillInfo[7646]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster, Data.MAX_CARD_LEVEL, var_89_0[1]), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7669, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CAR_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7686, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_300 = Data._skillInfo[7686]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7687, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_301 = Data._skillInfo[7687]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("HG", var_89_301._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7705, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_302 = Data._skillInfo[7705]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByStar("HG", var_89_0[1]:getStar())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7706, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_303 = Data._skillInfo[7706]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInStarCards(arg_89_0._player:getBattleCardsByMaxQuality("G", var_89_303._refCards[1]), var_89_0[1]._info._star)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7722, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_304 = Data._skillInfo[7722]
		local var_89_305 = arg_89_0._player:filterCanChangeToBoardCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByInfoId("H", var_89_304._refCards[1]),
			B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("H", Data.CardType.monster), var_89_304._refCards[2])
		}))

		if #var_89_305 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_305, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(7733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_306 = Data._skillInfo[7733]
		local var_89_307 = arg_89_0._player:filterCanChangeToHandCards(B.filterMoreThanStarCards(arg_89_0._player:getBattleCardsByCategoryAndNature("P", var_89_306._refCards[1], var_89_0[1]._info._nature), var_89_306._val[1]))

		if #var_89_307 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_307, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(7742, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_308 = Data._skillInfo[7742]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("HG", var_89_308._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7772, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_309 = Data._skillInfo[7772]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("L", Data.CardType.monster), var_89_309._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(7774) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_3 == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_310 = Data._skillInfo[7774]
		local var_89_311 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), {
			var_89_310._refCards[1],
			var_89_310._refCards[2]
		}))
		local var_89_312 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), {
			var_89_310._refCards[1],
			var_89_310._refCards[3]
		}))
		local var_89_313 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), {
			var_89_310._refCards[4],
			var_89_310._refCards[5]
		}))

		B.appendTable(var_89_311, var_89_312)
		B.appendTable(var_89_311, var_89_313)

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), B.sortCardsByBoardPos(var_89_311), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7792, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_314 = Data._skillInfo[7792]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7794, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_315 = Data._skillInfo[7794]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_315._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7818, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7819, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_316 = Data._skillInfo[7819]
		local var_89_317 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_316._refCards[1]))
		local var_89_318 = {}

		for iter_89_37 = 1, #var_89_317 do
			if var_89_317[iter_89_37] ~= arg_89_2._card and var_89_317[iter_89_37] ~= var_89_0[1] then
				var_89_318[#var_89_318 + 1] = var_89_317[iter_89_37]
			end
		end

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_318, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7828, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_319 = Data._skillInfo[7828]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldMagic, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		8056
	}) and arg_89_2._card._status == BattleData.CardStatus.show and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_320 = Data._skillInfo[8056]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8077, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8082, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_321 = Data._skillInfo[8082]
		local var_89_322 = B.filterNotBindedCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_321._refCards[1]), var_89_0[1]:getAlterMagicInfoId())

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_322), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8083, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_323 = Data._skillInfo[8083]
		local var_89_324 = arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_323._refCards[1]), var_89_0[1]))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_324), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8084, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_325 = Data._skillInfo[8084]
		local var_89_326 = arg_89_0._player:filterCanChangeToHandCards(B.filterNotEqualInfoIdCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_325._refCards[1]), var_89_325._refCards[3]))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_326), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8094, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil or arg_89_2._card:isSkillAtIndex(8145, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8111, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8123, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_327 = Data._skillInfo[8123]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_327._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8124, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8126, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_328 = Data._skillInfo[8126]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByInfoId("B", var_89_328._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8131, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_329 = Data._skillInfo[8131]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_329._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_1._choiceParam == nil then
		local var_89_330, var_89_331 = arg_89_2._card:hasSkills({
			3034,
			3035,
			3073,
			3127,
			3247,
			3248,
			3331,
			3344,
			3365,
			3406,
			3428,
			3473,
			3474,
			3480,
			3484,
			3573,
			3594,
			3707,
			3726,
			3735,
			3741,
			3768,
			3774,
			3775,
			3901,
			3912,
			3935,
			3937,
			3943,
			4117,
			4169,
			4170,
			4174,
			4205,
			4213,
			4238,
			4262,
			4263,
			4288,
			4302,
			4367,
			4413,
			4416,
			4430,
			4436,
			4443,
			4445,
			4463,
			4464,
			4490,
			4495,
			4507,
			4519,
			4532,
			4534,
			4559,
			4644,
			4645,
			4653,
			4655,
			4665,
			4674,
			4684,
			4723,
			4747,
			4750,
			4753,
			4771,
			4783,
			4816,
			5049,
			5067,
			5107,
			5127,
			5156,
			5191,
			5193,
			5237,
			5363,
			5382,
			5403,
			5410,
			5443,
			6274,
			6338,
			6436,
			6437,
			6440,
			6451,
			6452,
			6454,
			6465,
			6476,
			6509,
			6510,
			6511,
			6549,
			6579,
			6598,
			6631,
			6673,
			6675,
			6707,
			6810,
			6894,
			6923,
			6934,
			6946,
			7192,
			7235,
			8018,
			8019,
			8046
		})

		if var_89_330 then
			var_89_1 = var_89_0[1]._id

			local var_89_332 = Data._skillInfo[var_89_331[1]._id]

			if var_89_332._id == 3034 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("SD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3035 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					arg_89_0._player._opponent:getBattleCards("CSD")
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3073 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3127 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					arg_89_0._player._opponent:getBattleCards("CSD"),
					arg_89_0._player:getBattleCards("CSD")
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3247 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByMaxOriginAtk("B", arg_89_2._card._atk)),
					B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByMaxOriginAtk("B", arg_89_2._card._atk))
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3248 then
				local var_89_333 = arg_89_0._player._opponent:filterCanChangeToBoardCards(arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster))

				if #var_89_333 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_333, 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 3331 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3344 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("BSD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3365 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_332._val[1]), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3406 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("H", var_89_0[1]:getStar()), var_89_332._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3428 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByNature("G", var_89_332._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3473 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("C"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3474 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterDefPostureCards(arg_89_0._player._opponent:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3480 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterSpiritCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3484 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterDefPostureCards(arg_89_0._player._opponent:getBoardCards(), false)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3538 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3573 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					arg_89_0._player._opponent:getBattleCards("CSD"),
					B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()),
					arg_89_0._player:getBattleCards("CSD")
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3594 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByCategory("P", var_89_332._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3707 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3726 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3735 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStar("P", var_89_0[1]:getStar()), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3741 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					arg_89_0._player._opponent:getBattleCards("CSD")
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3768 or var_89_332._id == 3775 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_332._refCards[2]), arg_89_2._card:getAlterMagicInfoId())), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3774 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_0[1]:getStar()), var_89_332._refCards[2]), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3901 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3912 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3935 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3937 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_89_0._player:getBattleCardsByType("GP", Data.CardType.magic)))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3943 then
				local var_89_334 = arg_89_0._player._opponent:getBattleCardsByMaxAtk("B", var_89_0[1]._atk)

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_334, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4117 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterAtkEqualCards(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_0[1]._atk), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4169 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
					B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1]))
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4170 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(B.mergeTable({
					B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), arg_89_2._card),
					arg_89_0._player:getBattleCardsByType("P", Data.CardType.trap)
				}), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4174 then
				local var_89_335 = arg_89_0._player._opponent:getBoardCards()

				if #var_89_335 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_335), 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 4205 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4213 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_332._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4238 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByStar("GPH", var_89_0[1]:getStar()), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4262 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4263 then
				local var_89_336 = arg_89_0._player:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_89_0._player:getBattleCards("G")))

				if #var_89_336 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_336), 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 4288 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4302 then
				local var_89_337 = B.filterCanBindAlterMagicCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_332._refCards[1]), var_89_332._refCards[2]), var_89_0[1])

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_337, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4367 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterSyncCards(arg_89_0._player:getBoardCards(), false)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4413 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByNature("G", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4416 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4430 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterFirstCards(arg_89_0._player._opponent:getBattleCards("P", Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_332._val[1] - 1), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4436 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4443 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					B.sortCardsByBoardPos(arg_89_0._player:getBoardCards())
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4445 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					arg_89_0._player._opponent:getBattleCards("CSD"),
					arg_89_0._player:getBattleCards("CSD")
				}), 2, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4463 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("R", var_89_332._refCards[1]), true), var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4464 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterCanBindMagicCards(B.filterEquipMagicCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[2])), var_89_0[1]), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4490 then
				local var_89_338 = arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", {
					var_89_332._refCards[3],
					var_89_332._refCards[4],
					var_89_332._refCards[5],
					var_89_332._refCards[6]
				}))

				if #var_89_338 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_338, 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 4495 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4507 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4519 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByCategoryAndNature("G", var_89_332._refCards[3], var_89_332._refCards[2]), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4532 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4534 then
				local var_89_339

				if math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) == 1 then
					var_89_339 = B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1])
				else
					var_89_339 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[1]))
				end

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_339, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4559 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsBy4559Cards(var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4644 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByStar("PH", var_89_332._val[1], Data.CARD_MAX_LEVEL, var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4645 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_89_0._player:getBattleCards("R"), true), var_89_0[1]._info._star + 2)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4653 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInTypeCards(arg_89_0._player:getBattleCardsByMaxQuality("G", Data.CardQuality.UR), Data.CardType.monster)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4655 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategoryAndNature("B", var_89_332._refCards[3], var_89_332._refCards[2], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4665 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4674 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInStarCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[2]), var_89_0[1]:getStar()))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4684 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInNatureCards(arg_89_0._player:getBattleCardsByStarGroup("P", {
					7,
					8
				}), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4723 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBoardCards(), false)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4747 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByStar("B", var_89_0[1]:getStar())), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4750 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCardsByMinAtk("B", 2000), BattleData.PositiveType.shieldMagic)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4753 then
				if var_89_0[1]._info._category == var_89_332._refCards[1] then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.mergeTable({
						arg_89_0._player:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_89_2._card),
						B.filterFirstCards(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player._pileCards), 2)
					})), 1, arg_89_1._choiceBase, var_89_1)
				else
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_332._val[1]), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 4771 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4783 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterUniqueInfoIdCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4816 then
				local var_89_340 = arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster)

				if #var_89_340 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_340), 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 5049 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldExCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5067 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5107 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5127 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterNoShieldCards(B.filterEffectCards(B.mergeTable({
					arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]),
					arg_89_0._player._opponent:getBoardCards()
				})), BattleData.PositiveType.shieldTrap), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5191 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5156 or var_89_332._id == 5193 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5237 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5363 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInNatureCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStar("P", var_89_0[1]:getStar()), var_89_332._refCards[3]), var_89_332._refCards[var_89_0[1]._info._nature == var_89_332._refCards[1] and 2 or 1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5382 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5403 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), true), true, true), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5410 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5443 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCardsByType("SD", Data.CardType.magic), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6274 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.mergeTable({
					B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_332._val[1]), var_89_332._refCards[1]),
					B.filterInCategoryCards(arg_89_0._player._opponent:getBattleCardsByMaxStar("G", var_89_332._val[1]), var_89_332._refCards[1])
				})), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6338 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_332._val[1]), var_89_332._refCards[3])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6436 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6437 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldMonster)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6440 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6451 or var_89_332._id == 6452 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByNature("H", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6454 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_332._val[1]), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6465 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(B.filterNotEqualInfoIdCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_332._refCards[1]), var_89_332._refCards[2]), var_89_332._refCards[3])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6476 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByStar("R", arg_89_2._card:getStar() + var_89_0[1]:getStar()), var_89_332._refCards[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6509 or var_89_332._id == 6510 or var_89_332._id == 6511 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByNature("H", var_89_332._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6549 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterDefPostureCards(arg_89_0._player._opponent:getBoardCards(), false)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6579 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
					B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1]))
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6598 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByCategory("H", var_89_332._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6631 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInNatureCards(arg_89_0._player._opponent:getBattleCardsByMaxStar("B", var_89_332._val[1]), var_89_332._refCards[3])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6673 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", var_89_332._refCards)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6675 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCardsByType("SD", Data.CardType.magic), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6707 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6810 then
				local var_89_341

				if arg_89_1._choiceBase % BattleData.ChoiceId.stage_size_1 == 1 then
					var_89_341 = arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1]), true, true)
				else
					var_89_341 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
						Data.CardType.magic,
						Data.CardType.trap
					}), var_89_332._refCards[1]))
				end

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_341), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6894 then
				local var_89_342 = arg_89_0._player:getBattleCards("H")

				var_89_342[#var_89_342 + 1] = var_89_0[1]

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_342, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6923 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					B.sortCardsByBoardPos(arg_89_0._player:getBoardCards())
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6934 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6946 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 7192 then
				local var_89_343 = arg_89_1._choiceBase and math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0
				local var_89_344 = arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster)
				local var_89_345

				if var_89_343 == 1 then
					var_89_345 = B.sortCardsByBoardPos(B.filterInCategoryCards(var_89_344, var_89_332._refCards[1]))
				else
					var_89_345 = B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterLessThanStarCards(B.filterInKeywordCards(var_89_344, Data._skillInfo[7198]._refCards[1]), Data._skillInfo[7198]._val[1])))
				end

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_345, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 7235 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBoardCards(), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 8018 then
				local var_89_346 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1]))

				var_89_346[#var_89_346 + 1] = var_89_0[1]

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_346, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 8019 then
				local var_89_347 = arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster)

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_347, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 8046 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("G", var_89_332._val[1]), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			end
		else
			for iter_89_38 = #var_89_0, 1, -1 do
				var_89_1 = var_89_1 * BattleData.UseCardId.id_group + var_89_0[iter_89_38]._id
			end
		end
	else
		if arg_89_2._card:hasSkills({
			3034,
			3035,
			3073,
			3127,
			3247,
			3248,
			3331,
			3344,
			3365,
			3406,
			3428,
			3473,
			3474,
			3476,
			3480,
			3484,
			3540,
			3573,
			3594,
			3707,
			3726,
			3735,
			3741,
			3768,
			3774,
			3775,
			3901,
			3912,
			3935,
			3937,
			3943,
			4117,
			4169,
			4170,
			4174,
			4205,
			4213,
			4238,
			4262,
			4263,
			4288,
			4302,
			4367,
			4413,
			4416,
			4430,
			4436,
			4443,
			4463,
			4464,
			4490,
			4495,
			4507,
			4519,
			4532,
			4534,
			4559,
			4644,
			4645,
			4653,
			4655,
			4665,
			4674,
			4684,
			4723,
			4747,
			4750,
			4753,
			4771,
			4783,
			4816,
			5049,
			5067,
			5104,
			5107,
			5127,
			5156,
			5191,
			5193,
			5237,
			5363,
			5382,
			5403,
			5410,
			5443,
			6274,
			6338,
			6436,
			6437,
			6440,
			6451,
			6452,
			6454,
			6465,
			6476,
			6509,
			6510,
			6511,
			6549,
			6579,
			6598,
			6631,
			6673,
			6675,
			6707,
			6810,
			6894,
			6923,
			6934,
			6946,
			7192,
			7235,
			8018,
			8019,
			8046
		}) or arg_89_2._card:isSkillAtIndex(3320, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_1._choiceBase == 2 and arg_89_2._card:hasSkills({
			3538
		}) or arg_89_2._card._status == BattleData.CardStatus.board and arg_89_2._card:hasSkills({
			3555
		}) or arg_89_2._card._status == BattleData.CardStatus.board and arg_89_2._card:hasSkills({
			3835
		}) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
			4100
		}) or arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_2._card:hasSkills({
			4157
		}) or arg_89_2._card._status == BattleData.CardStatus.field and arg_89_2._card:hasSkills({
			4411
		}) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
			4431
		}) or arg_89_2._card:isSkillAtIndex(4465, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4798, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4486, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4529, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4572, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:hasSkills({
			4589,
			4594,
			4628
		}) or arg_89_2._card:isSkillAtIndex(4596, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4631, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4633, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4678, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4728, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13576, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4804, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4827, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4840, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4941, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4942, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4944, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4983, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:hasSkillFast(4984) or arg_89_2._card:isSkillAtIndex(4991, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4993, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5566, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5571, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5572, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5597, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5603, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5605, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5614, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5617, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_1._choiceBase % BattleData.ChoiceId.stage_size_1 == 1 and arg_89_2._card:hasSkills({
			5118
		}) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5232) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5332) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5343) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5445) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5461) or arg_89_2._card:isSkillAtIndex(5440, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5450, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5463, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5472) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5476) or arg_89_2._card:isSkillAtIndex(5502, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5508) or arg_89_2._card:isSkillAtIndex(5539, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5543) or arg_89_2._card:isSkillAtIndex(5561, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5622) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5624) or arg_89_2._card:isSkillAtIndex(5646, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3714, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3737, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3950, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3957, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3974, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
			6265
		}) or arg_89_2._card._status == BattleData.CardStatus.board and arg_89_2._card:hasSkills({
			6286
		}) or arg_89_2._card:isSkillAtIndex(6365, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6396, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6507, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_2._card:hasSkills({
			6616
		}) or arg_89_2._card:isSkillAtIndex(6618, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6619, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6679, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6732, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6735, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6746, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6772, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6795, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6843, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6841, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6848, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6921, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6964, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6978, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6982, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2111, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2112, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2117, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2135, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2155, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2196, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2203, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2209, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2212, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2279, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2320, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2341, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2359, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2389, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2392, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2400, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2409, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2429, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2430, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2434, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2441, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2449, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2450, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2486, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2487, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2534, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2562, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2578, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2585, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2586, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2587, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2588, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2598, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2599, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2602, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2615, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2739, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2750, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2772, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2774, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2776, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2785, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2787, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2789, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2806, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2811, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2813, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2838, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2867, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2886, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2915, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2928, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2942, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2951, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2959, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2963, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2969, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2986, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9009, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9034, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9051, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9052, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9072, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9092, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9124, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9168, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9189, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9198, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9204, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9213, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9214, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9218, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9220, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9230, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9258, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9260, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9269, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9282, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9305, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9306, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9314, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9320, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9373, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9375, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9378, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9392, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9382, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9396, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9480, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9481, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9485, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9497, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9518, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9523, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9556, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9563, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9593, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9600, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9614, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9615, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9638, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9712, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9721, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9733, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9739, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9785, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9786, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9815, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9841, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9851, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9867, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9916, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9917, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9918, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9934, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9956, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9965, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9983, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9984, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9960, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7234, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7244, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7309, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7310, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7328, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7336, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7337, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7338, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7365, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7374, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7380, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7404, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7408, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7429, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7433, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7454, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7534, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7551, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7566, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(7574) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(7578) or arg_89_2._card:isSkillAtIndex(7582, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7635, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7640, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7669, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7686, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7687, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7705, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7706, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7722, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7733, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7742, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7772, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(7774) or arg_89_2._card:isSkillAtIndex(7792, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7794, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7818, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7819, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7828, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.show and arg_89_2._card:hasSkillFast(8056) or arg_89_2._card:isSkillAtIndex(8077, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8082, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8083, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8084, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8094, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8145, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8111, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8123, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8124, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8126, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8131, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13002, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13039, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13054, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13068, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13072, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13155, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13156, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13157, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13165, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13168, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13185, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13218, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13220, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13221, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13296, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13318, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13321, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13330, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13332, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13365, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13367, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13373, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13380, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13398, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13401, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13405, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13408, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13411, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13430, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13432, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13452, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13468, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13538, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13552, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13553, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13572, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13602, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13607, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13618, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13626, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13703, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13710, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13764, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13766, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13767, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13792, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13793, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13847, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13959, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13995, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14020, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14047, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14163, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14176, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14185, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14337, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14411, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14441, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14474, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14534, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14561, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14570, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14579, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14588, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14598, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14604, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) then
			var_89_1 = arg_89_1._choiceParam
		end

		for iter_89_39 = #var_89_0, 1, -1 do
			var_89_1 = var_89_1 * BattleData.UseCardId.id_group + var_89_0[iter_89_39]._id
		end
	end

	if arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(3851, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoicePos(arg_89_2, arg_89_3, nil, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase, {
			arg_89_2._card
		}, B.filterBoardCards(arg_89_0._player._boardCards, var_89_0), BattlePosDialog.Mode.sync)
	elseif arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(6753, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoicePos(arg_89_2, arg_89_3, nil, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase, {
			arg_89_2._card
		}, B.filterBoardCards(arg_89_0._player._boardCards, var_89_0), BattlePosDialog.Mode.xyz)
	elseif arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(9298, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoicePos(arg_89_2, arg_89_3, nil, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase, {
			arg_89_2._card
		}, B.filterBoardCards(arg_89_0._player._boardCards, var_89_0), BattlePosDialog.Mode.link)
	elseif arg_89_2._card:isSkillAtIndex(9280, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoicePos(arg_89_2, arg_89_3, nil, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase, {
			arg_89_0._player:getCardById(var_89_1)
		}, B.filterBoardCards(arg_89_0._player._boardCards, var_89_0), 9280)
	end

	if #var_89_0 == 1 and arg_89_2._card:hasSkills({
		3084,
		4022,
		4053,
		4088,
		4094,
		4111,
		5037
	}) then
		local var_89_348 = var_89_0[1]
		local var_89_349, var_89_350 = var_89_348:hasChoiceSkill()

		if var_89_349 and B.isSkillChoiceSkill(var_89_350) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_bcs) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_grave) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_hand) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_rare) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_leave) then
			if var_89_348:hasSkills({
				3098,
				3119,
				3491,
				3592,
				3651,
				3825,
				3865,
				2383
			}) then
				return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
					_card = arg_89_2._card,
					_target = arg_89_3 ~= nil and arg_89_3._card or nil,
					_choice = var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase
				})
			else
				return arg_89_0:showChoiceSkill(arg_89_2, arg_89_3, var_89_350, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
			end
		end
	end

	if arg_89_2._card:isSkillAtIndex(7655, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoiceSkill(arg_89_2, arg_89_3, skill, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	end

	arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
		_card = arg_89_2._card,
		_target = arg_89_3 ~= nil and arg_89_3._card or nil,
		_choice = var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase
	})
end

function var_0_0.cancelChoiceGrave(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	arg_90_0._battleUi._choiceGraveDialog = nil

	if arg_90_2._card._status == BattleData.CardStatus.hand then
		arg_90_0:playAction(arg_90_2, var_0_0.Action.replace_hand_card, 0, 1)
	end
end

function var_0_0.checkChoiceGrave(arg_91_0, arg_91_1, arg_91_2, arg_91_3, arg_91_4)
	local var_91_0 = arg_91_1:getSelectedCount()

	if arg_91_2._card:isSkillAtIndex(9489, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return false
	end

	if arg_91_2._card:isSkillAtIndex(9552, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return true
	end

	if arg_91_2._card:isSkillAtIndex(9944, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._alreadySatisfied then
		return true
	end

	if arg_91_2._card:isSkillAtIndex(3994, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(13275, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(13276, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(13719, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 > 0
	elseif arg_91_2._card:hasSkills({
		4095,
		4318
	}) then
		return var_91_0 > 0
	elseif arg_91_2._card:hasSkills({
		3866,
		4350,
		4384,
		4390,
		4408,
		4424,
		4510,
		4558,
		4689,
		4701,
		4730,
		4853,
		4870,
		4939,
		4943,
		5204,
		5309,
		5400,
		6528,
		6684,
		2352,
		2354,
		2384,
		2404,
		2431,
		2878,
		9067,
		9142,
		7199,
		7305,
		8071
	}) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card:hasSkillFast(4425) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0 and #B.filterNormalCards(arg_91_1:getSelectedCards(), true) > 0
	elseif arg_91_2._card:isSkillAtIndex(4458, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if var_91_0 == 1 then
			return true
		elseif var_91_0 == 2 then
			local var_91_1 = arg_91_1:getSelectedCards()

			return var_91_1[1]:isNotSameKeywordWith(var_91_1[2], Data._skillInfo[4458]._refCards)
		end

		return false
	elseif arg_91_2._card:hasSkillFast(4483) then
		if var_91_0 == 2 then
			local var_91_2 = arg_91_1:getSelectedCards()

			return var_91_2[1]._status ~= var_91_2[2]._status
		end

		return false
	elseif arg_91_2._card:hasSkillFast(5267) then
		if var_91_0 == 1 then
			return true
		elseif var_91_0 == 2 then
			local var_91_3 = arg_91_1:getSelectedCards()

			if var_91_3[1]:isSync() and var_91_3[2]:isAdjust() then
				return true
			elseif var_91_3[2]:isSync() and var_91_3[1]:isAdjust() then
				return true
			end
		end

		return false
	elseif arg_91_2._card:isSkillAtIndex(4797, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(5283, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(5285, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_4 == 2 then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkills({
		5324
	}) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5517) and arg_91_3 ~= nil then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_2._card:isSkillAtIndex(6468, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.board and arg_91_2._card:hasSkills({
		6497,
		6605
	}) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkills({
		5284,
		6833
	}) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5393, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5447, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5517) and arg_91_4 == 2 then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5570, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5595) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5624) and arg_91_3 ~= nil then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5641, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5642) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5650, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5651, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5652) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5653, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5656) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(6860, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(6984, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7555, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_4 = arg_91_1:getSelectedCards()

		return #var_91_4 == 1 or #var_91_4 == 2 and not var_91_4[1]:isSameNameWith(var_91_4[2])
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7556, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_5 = arg_91_1:getSelectedCards()

		return #var_91_5 == 1 or #var_91_5 == 2 and not var_91_5[1]:isSameNameWith(var_91_5[2])
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(7644) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7681, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7682, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7735, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7736, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(7737) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7767, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7776, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7822, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2113, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2142, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2310, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2807, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2879, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2929, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2966, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9287, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9288, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9289, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9330, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9343, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9419, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9578, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9580, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9581, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9701, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9757, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9758, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9865, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9886, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13009, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13094, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13103, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13106, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13138, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13149, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13178, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13182, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13301, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13311, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13370, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13371, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13444, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13596, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13599, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13614, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13619, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13635, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13661, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_6 = arg_91_1:getSelectedCards()

		return var_91_0 <= arg_91_4 and var_91_0 > 0 and var_91_6[1]:getStar() + (var_91_6[2] and var_91_6[2]:getStar() or 0) <= arg_91_2._card:getStar()
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13662, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_7 = arg_91_1:getSelectedCards()

		return var_91_0 <= arg_91_4 and var_91_0 > 0 and var_91_7[1]:getStar() + (var_91_7[2] and var_91_7[2]:getStar() or 0) <= arg_91_2._card:getStar()
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13701, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13702, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13733, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13815, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13838, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13868, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13870, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13886, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13917, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13925, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13926, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13933, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13962, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13994, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14001, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14010, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14015, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14018, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14097, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14098, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14125, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14143, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14154, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14158, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14174, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14201, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14202, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14224, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14251, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14260, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14261, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14302, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14308, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14412, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14418, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14452, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14489, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14528, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14591, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_1._choiceParam ~= nil and arg_91_2._card:isSkillAtIndex(2930, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_4 == 2 and arg_91_2._card:hasSkillFast(4445) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card:hasSkillFast(4722) then
		local var_91_8 = arg_91_1:getSelectedCards()

		return var_91_0 <= arg_91_4 and var_91_0 > 0 and #B.filterEffectCards(var_91_8) == 1
	elseif arg_91_4 == 2 and arg_91_2._card:hasSkillFast(6558) then
		if var_91_0 <= arg_91_4 and var_91_0 > 0 then
			local var_91_9 = arg_91_1:getSelectedCards()
			local var_91_10 = 0

			for iter_91_0 = 1, #var_91_9 do
				var_91_10 = var_91_10 + var_91_9[iter_91_0]:getStar()
			end

			return var_91_10 >= arg_91_2._card:getStar()
		end
	elseif arg_91_4 == 2 and arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkills({
		6853
	}) then
		local var_91_11 = arg_91_1:getSelectedCards()

		return #var_91_11 == 2 and not var_91_11[1]:isNature(var_91_11[2]._info._nature)
	elseif arg_91_4 == 2 and arg_91_2._card._status == BattleData.CardStatus.grave and arg_91_2._card:hasSkills({
		6871
	}) then
		local var_91_12 = arg_91_1:getSelectedCards()

		return #var_91_12 == 2 and not var_91_12[1]:isNature(var_91_12[2]._info._nature)
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13465, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_13 = arg_91_1:getSelectedCards()

		if #var_91_13 == 2 and var_91_13[1]:isSameNameWith(var_91_13[2]) then
			return false
		end

		return var_91_0 <= arg_91_4 and var_91_0 > 0
	end

	if arg_91_2._card._status == BattleData.CardStatus.hand and B.isSkillCeremony(arg_91_2._card._skills[1]._id) or arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7576, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if selectCount == 0 then
			return false
		end

		local var_91_14 = arg_91_1:getSelectedCards()

		if arg_91_2._card:hasSkillFast(4741) and #B.filterInInfoIdGroupCards(var_91_14, Data._skillInfo[4741]._refCards) == 0 then
			return false
		end

		local var_91_15 = B.filterInStatusCards(var_91_14, BattleData.CardStatus.board)
		local var_91_16 = B.filterInStatusCards(var_91_14, BattleData.CardStatus.hand)
		local var_91_17 = B.filterInStatusCards(var_91_14, BattleData.CardStatus.grave)
		local var_91_18 = B.filterInStatusCards(var_91_14, BattleData.CardStatus.pile)

		if arg_91_2._card:hasSkillFast(4648) and (#var_91_14 ~= 2 or var_91_14[1]._status == var_91_14[2]._status or var_91_14[1]:isNature(var_91_14[2]._info._nature)) then
			return false
		end

		return arg_91_2._card._owner:isValidCeremonyComponents(arg_91_1._choiceParam, B.mergeTable({
			var_91_15,
			var_91_16,
			var_91_17,
			var_91_18
		}))
	elseif arg_91_2._card:isSkillAtIndex(3851, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card:hasSkills({
		2437,
		2560,
		2781,
		3940,
		6349,
		9453,
		9462
	}) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, arg_91_2._card)
	elseif arg_91_2._card:isSkillAtIndex(2611, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_19 = arg_91_1:getSelectedCards()

		if #var_91_19 ~= 2 or var_91_19[1] ~= arg_91_2._card and var_91_19[2] ~= arg_91_2._card then
			return false
		end

		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, arg_91_2._card)
	elseif arg_91_2._card._status == BattleData.CardStatus.rare and arg_91_2._card:isSkillAtIndex(6753, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidXYZComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.rare and arg_91_2._card:isSkillAtIndex(9298, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidLinkComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.leave and arg_91_2._card:isSkillAtIndex(9507, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.board and arg_91_2._card:isSkillAtIndex(9685, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.leave and arg_91_2._card:isSkillAtIndex(13007, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.grave and arg_91_2._card:isSkillAtIndex(7824, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card:isSkillAtIndex(9768, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_20 = arg_91_1:getSelectedCards()
		local var_91_21 = 0

		for iter_91_1 = 1, #var_91_20 do
			var_91_21 = var_91_21 + var_91_20[iter_91_1]:getStar()
		end

		return var_91_21 >= Data._skillInfo[9768]._val[1]
	elseif arg_91_2._card:isSkillAtIndex(9763, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_3 ~= nil then
		local var_91_22 = arg_91_1:getSelectedCards()
		local var_91_23 = 0

		for iter_91_2 = 1, #var_91_22 do
			var_91_23 = var_91_23 + var_91_22[iter_91_2]:getStar()
		end

		return var_91_23 >= arg_91_3._card:getStar()
	elseif arg_91_2._card:isSkillAtIndex(13147, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_24 = arg_91_1:getSelectedCards()
		local var_91_25 = 0

		for iter_91_3 = 1, #var_91_24 do
			var_91_25 = var_91_25 + var_91_24[iter_91_3]:getStar()
		end

		if var_91_25 < arg_91_2._card:getStar() then
			return false
		end

		if arg_91_2._card._owner:getEmptyBoardPos() == nil and #B.filterInStatusCards(var_91_24, BattleData.CardStatus.board) == 0 then
			return false
		end

		return true
	end

	if var_91_0 ~= arg_91_4 then
		return false
	end

	if arg_91_2._card:hasSkillFast(3493) and arg_91_2._card._status == BattleData.CardStatus.grave then
		local var_91_26 = arg_91_1:getSelectedCards()
		local var_91_27 = Data._skillInfo[3493]._refCards

		return var_91_26[1]:isNature(var_91_27[1]) and var_91_26[2]:isNature(var_91_27[2]) or var_91_26[1]:isNature(var_91_27[2]) and var_91_26[2]:isNature(var_91_27[1])
	elseif arg_91_2._card:hasSkills({
		2243
	}) then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card, false)
	elseif arg_91_2._card:hasSkillFast(2318) and arg_91_2._card._status == BattleData.CardStatus.board then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), nil, false)
	elseif arg_91_2._card:hasSkillFast(2982) and arg_91_2._card._status == BattleData.CardStatus.hand then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card, false)
	elseif arg_91_2._card:hasSkillFast(2985) and arg_91_2._card._status == BattleData.CardStatus.grave then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card, false)
	elseif arg_91_2._card:isSkillAtIndex(4978, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_28 = arg_91_1:getSelectedCards()

		if var_91_28[1]._owner ~= arg_91_2._card._owner and var_91_28[2]._owner ~= arg_91_2._card._owner then
			return false
		end

		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, var_91_28, nil, false)
	elseif arg_91_2._card:isSkillAtIndex(4980, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card._binds[1], false)
	elseif arg_91_2._card:isSkillAtIndex(13736, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card, false)
	elseif arg_91_2._card:hasSkills({
		4048,
		4171,
		4186,
		4207,
		4290,
		4454,
		4497,
		4521,
		4735,
		4736,
		4740,
		4748,
		4836,
		7144,
		7373,
		7693
	}) or arg_91_2._card._status == BattleData.CardStatus.rare and arg_91_2._card:hasSkills({
		3874,
		3885,
		2375
	}) or arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkills({
		4305,
		4511,
		4514,
		4526,
		4530,
		4861,
		4957,
		4979,
		5244,
		5280,
		5298,
		7544,
		7579,
		7622,
		7631,
		7731,
		7753
	}) and not arg_91_2._card:isSkillAtIndex(7733, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(3705, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(3850, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(2324, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5430, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5431, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5452, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5470, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5485, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5544, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5549, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7673, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7674, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7732, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7785, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7831, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(9796, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(9868, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13119, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13259, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13264, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13292, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13348, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13718, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13850, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13920, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13989, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14390, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14487, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14519, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14541, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14555, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_29 = (arg_91_2._card:isSkillAtIndex(3705, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(3850, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(2324, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3))) and arg_91_2._card or nil

		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), var_91_29, false)
	elseif arg_91_2._card:hasSkillFast(4112) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_30 = arg_91_1:getSelectedCards()

		return var_91_30[1]._owner ~= var_91_30[2]._owner
	elseif arg_91_2._card:hasSkillFast(4124) then
		local var_91_31 = arg_91_1:getSelectedCards()
		local var_91_32 = 0

		for iter_91_4 = 1, #var_91_31 do
			if var_91_31[iter_91_4]:isInfoId(Data._skillInfo[4124]._refCards[1]) then
				var_91_32 = var_91_32 + 1
			end
		end

		return var_91_32 == 2
	elseif arg_91_2._card:hasSkillFast(4666) then
		return #B.filterSameOwnerCards(arg_91_1:getSelectedCards(), arg_91_2._card) == 1
	elseif arg_91_2._card:hasSkillFast(4872) and arg_91_1._choiceParam ~= nil then
		local var_91_33 = arg_91_1:getSelectedCards()

		return var_91_33[1]:isAdjust() ~= var_91_33[2]:isAdjust() and var_91_33[1]:getStar() + var_91_33[2]:getStar() == arg_91_0._player:getCardById(arg_91_1._choiceParam):getStar()
	elseif arg_91_2._card:hasSkillFast(4912) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_34 = arg_91_1:getSelectedCards()

		return var_91_34[1]:getStar() ~= var_91_34[2]:getStar()
	elseif arg_91_2._card:hasSkillFast(7615) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_35 = arg_91_1:getSelectedCards()

		return var_91_35[1]._owner ~= var_91_35[2]._owner
	elseif arg_91_2._card:hasSkillFast(7628) and arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_4 == 2 then
		local var_91_36 = arg_91_1:getSelectedCards()

		return not var_91_36[1]:isSameNameWith(var_91_36[2])
	elseif arg_91_2._card:hasSkillFast(7646) and arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_4 == 2 then
		local var_91_37 = arg_91_1:getSelectedCards()

		return var_91_37[1]:isAdjust() ~= var_91_37[2]:isAdjust()
	elseif arg_91_2._card:hasSkills({
		5227,
		5353
	}) then
		local var_91_38 = arg_91_1:getSelectedCards()

		return var_91_38[1]:getStar() == var_91_38[2]:getStar()
	elseif arg_91_2._card:hasSkillFast(5288) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_39 = arg_91_1:getSelectedCards()

		return var_91_39[1]._status ~= var_91_39[2]._status and not var_91_39[1]:isSameNameWith(var_91_39[2])
	elseif arg_91_2._card:hasSkillFast(5545) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_40 = arg_91_1:getSelectedCards()
		local var_91_41 = Data._skillInfo[5545]

		return var_91_40[1]._type == Data.CardType.monster and var_91_40[1]:isKeyword(var_91_41._refCards[2]) and var_91_40[2]:isKeyword(var_91_41._refCards[1]) and not var_91_40[2]:isSameNameWith(arg_91_2._card) or var_91_40[2]._type == Data.CardType.monster and var_91_40[2]:isKeyword(var_91_41._refCards[2]) and var_91_40[1]:isKeyword(var_91_41._refCards[1]) and not var_91_40[1]:isSameNameWith(arg_91_2._card)
	elseif arg_91_2._card:hasSkills({
		6691,
		6692
	}) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_42 = arg_91_1:getSelectedCards()

		return #B.filterInKeywordCards(var_91_42, Data._skillInfo[6691]._refCards[1]) > 0
	elseif arg_91_2._card:isSkillAtIndex(2116, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_43 = arg_91_1:getSelectedCards()

		return #B.filterInStatusCards(var_91_43, BattleData.CardStatus.field) == 1
	elseif arg_91_2._card:isSkillAtIndex(2141, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_44 = arg_91_1:getSelectedCards()

		return var_91_44[1]:isInfoId(Data._skillInfo[2141]._refCards[1]) and var_91_44[1]._owner == arg_91_2._card._owner or var_91_44[2]:isInfoId(Data._skillInfo[2141]._refCards[1]) and var_91_44[2]._owner == arg_91_2._card._owner
	elseif arg_91_2._card:isSkillAtIndex(2215, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_45 = arg_91_1:getSelectedCards()

		return var_91_45[1]._info._nature == var_91_45[2]._info._nature and var_91_45[1]._info._category == var_91_45[2]._info._category and var_91_45[1]:isAdjust() and not var_91_45[2]:isAdjust() or var_91_45[2]:isAdjust() and not var_91_45[1]:isAdjust()
	elseif arg_91_2._card:isSkillAtIndex(2244, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_46 = arg_91_1:getSelectedCards()

		return var_91_46[1]._infoId ~= var_91_46[2]._infoId
	elseif arg_91_2._card:isSkillAtIndex(2711, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_47 = arg_91_1:getSelectedCards()

		return var_91_47[1]._owner ~= var_91_47[2]._owner
	elseif arg_91_2._card:isSkillAtIndex(2745, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_48 = arg_91_1:getSelectedCards()

		return #B.filterUniqueInfoIdCards(var_91_48) == #var_91_48
	elseif arg_91_2._card:isSkillAtIndex(9071, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_49 = arg_91_1:getSelectedCards()

		return #B.filterUniqueInfoIdCards(var_91_49) == #var_91_49
	elseif arg_91_2._card:isSkillAtIndex(9187, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_50 = arg_91_1:getSelectedCards()

		return var_91_50[1]._owner ~= var_91_50[2]._owner
	elseif arg_91_2._card:isSkillAtIndex(9193, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if arg_91_2._card._owner:getEmptyBoardPos() == nil then
			local var_91_51 = arg_91_1:getSelectedCards()

			return var_91_51[1]._status == BattleData.CardStatus.board or var_91_51[2]._status == BattleData.CardStatus.board
		else
			return true
		end
	elseif arg_91_2._card:isSkillAtIndex(9219, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_52 = arg_91_1:getSelectedCards()

		return var_91_52[1]:isMonsterRare() ~= var_91_52[2]:isMonsterRare()
	elseif arg_91_2._card:isSkillAtIndex(9409, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_53 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_53[1]._status == BattleData.CardStatus.board or var_91_53[2]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9454, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_54 = arg_91_1:getSelectedCards()

		return var_91_54[1]:isMonsterRare() ~= var_91_54[2]:isMonsterRare()
	elseif arg_91_2._card:isSkillAtIndex(9480, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._choiceParam == nil then
		local var_91_55 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_55[1]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9481, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._choiceParam == nil then
		local var_91_56 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_56[1]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9501, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_57 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_57[1]._status == BattleData.CardStatus.board or var_91_57[2]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9513, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return #B.filterUniqueInfoIdCards(arg_91_1:getSelectedCards()) == 3
	elseif arg_91_2._card:isSkillAtIndex(9515, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return #B.filterUniqueInfoIdCards(arg_91_1:getSelectedCards()) == 3
	elseif arg_91_2._card:isSkillAtIndex(9520, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_58 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_58[1]._status == BattleData.CardStatus.board or var_91_58[2]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9699, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_59 = arg_91_1:getSelectedCards()

		return var_91_59[1]:isSameNameWith(var_91_59[2])
	elseif arg_91_2._card:isSkillAtIndex(9716, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_60 = arg_91_1:getSelectedCards()

		return var_91_60[1]._owner ~= var_91_60[2]._owner
	elseif arg_91_2._card:isSkillAtIndex(9851, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._choiceParam == nil then
		local var_91_61 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_61[1]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9852, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_62 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_62[1]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9870, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_63 = arg_91_1:getSelectedCards()

		return var_91_63[1]._infoId ~= var_91_63[2]._infoId and (var_91_63[1]:isInfoId(Data._skillInfo[9870]._refCards[1]) or var_91_63[2]:isInfoId(Data._skillInfo[9870]._refCards[1]))
	elseif arg_91_2._card:isSkillAtIndex(9896, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._choiceParam == nil then
		local var_91_64 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_64[1]._status == BattleData.CardStatus.board or var_91_64[2]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9944, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if not arg_91_1._alreadySatisfied then
			local var_91_65 = arg_91_1:getSelectedCards()

			return var_91_65[1]:isNature(Data._skillInfo[9944]._refCards[1]) or var_91_65[1]:isNature(Data._skillInfo[9944]._refCards[2])
		end
	elseif arg_91_2._card:isSkillAtIndex(9945, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_66 = arg_91_1:getSelectedCards()

		return not var_91_66[1]:isSameNatureWith(var_91_66[2])
	elseif arg_91_2._card:isSkillAtIndex(9948, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_67 = arg_91_1:getSelectedCards()

		return not var_91_67[1]:isSameNatureWith(var_91_67[2])
	elseif arg_91_2._card:isSkillAtIndex(13283, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_68 = arg_91_1:getSelectedCards()

		return var_91_68[1]:isSameNameWith(var_91_68[2])
	elseif arg_91_2._card:isSkillAtIndex(13293, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_69 = arg_91_1:getSelectedCards()

		return var_91_69[1]._status ~= var_91_69[2]._status
	elseif arg_91_2._card:isSkillAtIndex(13338, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_70 = arg_91_1:getSelectedCards()

		return var_91_70[1]._info._category ~= var_91_70[2]._info._category
	elseif arg_91_2._card:isSkillAtIndex(13474, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_71 = arg_91_1:getSelectedCards()

		return var_91_71[1]._status == BattleData.CardStatus.grave and var_91_71[2]._status ~= BattleData.CardStatus.grave or var_91_71[1]._status ~= BattleData.CardStatus.grave and var_91_71[2]._status == BattleData.CardStatus.grave
	elseif arg_91_2._card:isSkillAtIndex(13503, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_72 = arg_91_1:getSelectedCards()

		return not var_91_72[1]:isNature(var_91_72[2]._info._nature)
	elseif arg_91_2._card:isSkillAtIndex(13545, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_73 = arg_91_1:getSelectedCards()

		return var_91_73[1]._status ~= var_91_73[2]._status
	elseif arg_91_2._card:isSkillAtIndex(13678, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_74 = arg_91_1:getSelectedCards()

		return var_91_74[1]:isKeyword(Data._skillInfo[13678]._refCards[1]) or var_91_74[2]._type == Data.CardType.rare or var_91_74[2]:isKeyword(Data._skillInfo[13678]._refCards[1]) or var_91_74[1]._type == Data.CardType.rare
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13817, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_75 = arg_91_1:getSelectedCards()

		return var_91_75[1]._info._category ~= var_91_75[2]._info._category
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14021, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_76 = arg_91_1:getSelectedCards()

		if (not var_91_76[1]:isAdjust() or not var_91_76[1]:isSync() or not var_91_76[2]:isKeyword(Data._skillInfo[14021]._refCards[1])) and (not var_91_76[2]:isAdjust() or not var_91_76[2]:isSync() or not var_91_76[1]:isKeyword(Data._skillInfo[14021]._refCards[1])) then
			return false
		end

		if arg_91_2._card._owner:getEmptyBoardPos() == nil and var_91_76[1]._status ~= BattleData.CardStatus.board and var_91_76[2]._status ~= BattleData.CardStatus.board then
			return false
		end

		return true
	elseif arg_91_2._card:hasSkillFast(5608) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_77 = arg_91_1:getSelectedCards()

		return not var_91_77[1]:isInfoId(var_91_77[2]._infoId) and not var_91_77[1]:isInfoId(var_91_77[3]._infoId) and not var_91_77[2]:isInfoId(var_91_77[3]._infoId)
	elseif arg_91_2._card:hasSkillFast(5634) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_78 = arg_91_1:getSelectedCards()

		return not var_91_78[1]:isSameNameWith(var_91_78[2])
	elseif arg_91_2._card:isSkillAtIndex(7667, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_79 = arg_91_1:getSelectedCards()

		return var_91_79[1]:isSameNameWith(var_91_79[2])
	elseif arg_91_2._card:isSkillAtIndex(7708, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_80 = arg_91_1:getSelectedCards()

		return var_91_80[1]._type ~= var_91_80[2]._type and (var_91_80[1]:isMonsterRare() or var_91_80[2]:isMonsterRare())
	elseif arg_91_2._card:isSkillAtIndex(14134, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_81 = arg_91_1:getSelectedCards()

		return var_91_81[1]._type ~= var_91_81[2]._type
	elseif arg_91_2._card:isSkillAtIndex(14400, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_82 = arg_91_1:getSelectedCards()

		return var_91_82[1]:getStar() + var_91_82[2]:getStar() == arg_91_2._card:getStar()
	else
		return true
	end
end

function var_0_0.showChoiceSacrifice(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4)
	local var_92_0 = arg_92_1._card
	local var_92_1 = math.max(0, var_92_0:getSacrificeCount() + (arg_92_4 or 0))

	if var_92_1 == 0 then
		if arg_92_1._card:hasSkills({
			3592,
			3651,
			3865,
			6724,
			2383
		}) or not arg_92_1._card:hasChoiceSkill() then
			return arg_92_0:showChoicePos(arg_92_1, arg_92_2, nil, arg_92_3, {
				arg_92_1._card
			}, arg_92_0._player._boardCards, BattlePosDialog.Mode.summon)
		else
			return arg_92_0:showChoiceSkill(arg_92_1, arg_92_2, nil, arg_92_3)
		end
	end

	local var_92_2 = arg_92_0:createChoiceMaskLayer(arg_92_1, arg_92_2, nil, arg_92_3)
	local var_92_3 = arg_92_3 == 4 and arg_92_0._player._opponent or arg_92_0._player
	local var_92_4

	if arg_92_3 == 4 then
		var_92_4 = B.sortCardsByBoardPos(B.filterCanSacrificeCards(var_92_3:getBoardCards(), var_92_0))
	elseif arg_92_3 % BattleData.ChoiceId.stage_size_1 == 7 then
		var_92_4 = B.sortCardsByBoardPos(B.filterCanSacrificeCards(var_92_3:getBoardCards(), var_92_0, true))
	elseif arg_92_0._player._mark14429 and (var_92_0._maxAtk == 2800 or var_92_0._maxAtk == 2400) and var_92_0._maxHp == 1000 then
		var_92_4 = B.filterCanSacrificeCards(B.mergeTable({
			B.sortCardsByBoardPos(var_92_3._opponent:getBoardCards()),
			B.sortCardsByBoardPos(B.filterCanActionCards(var_92_3:getBoardCards()))
		}), var_92_0)
	else
		var_92_4 = B.filterCanSacrificeCards(B.mergeTable({
			B.sortCardsByBoardPos(var_92_3._opponent:getBattleCardsByBuff("B", false, BattleData.NegativeType.canBeSacriByOppo)),
			B.sortCardsByBoardPos(B.filterCanActionCards(var_92_3:getBoardCards()))
		}), var_92_0)
	end

	local var_92_5 = ClientView.createTTF(string.format(Str(STR.SACRIFICE_TITLE), var_92_1), ClientView.FontSize.M1)

	var_92_5:runAction(lc.rep(lc.sequence(lc.scaleTo(1.5, 1.05), lc.scaleTo(1.5, 1))))
	lc.addChildToPos(var_92_2, var_92_5, cc.p(lc.w(var_92_2) / 2, 660))

	local var_92_6 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_93_0)
		arg_92_0:onChoiceSacrifice(var_92_2)
	end, ClientView.CRECT_BUTTON, 150)

	var_92_6:setDisabledShader(ClientView.SHADER_DISABLE)
	var_92_6:addLabel(Str(STR.OK))
	var_92_6:setEnabled(var_92_1 == var_92_3:getCanSacrificeCount(var_92_4, var_92_0, nil, arg_92_4))
	lc.addChildToPos(var_92_2, var_92_6, cc.p(lc.cw(var_92_2), 100))

	arg_92_0._choiceBtns = {}

	local var_92_7 = false

	for iter_92_0 = 1, #var_92_4 do
		if var_92_4[iter_92_0]._owner ~= arg_92_0._player then
			local var_92_8 = true
		end
	end

	local var_92_9 = 40
	local var_92_10 = #var_92_4 * (ClientView.CARD_SIZE.width + var_92_9)
	local var_92_11 = math.min(1, ClientView.SCR_W / var_92_10)

	for iter_92_1 = 1, #var_92_4 do
		local var_92_12 = ClientView.createShaderButton(nil, function(arg_94_0)
			arg_94_0._cardSprite._bones:setVisible(not arg_94_0._cardSprite._bones:isVisible())

			local var_94_0 = {}

			for iter_94_0 = 1, #arg_92_0._choiceBtns do
				if arg_92_0._choiceBtns[iter_94_0]._cardSprite._bones:isVisible() then
					var_94_0[#var_94_0 + 1] = var_92_4[iter_94_0]
				end
			end

			var_92_6:setEnabled(var_92_3:getCanSacrificeCount(var_94_0, var_92_0, nil, arg_92_4) == var_92_1 and (not var_92_0:hasSkills({
				6018
			}) or #B.filterInInfoIdCards(var_92_4, var_92_0._infoId) == 0 or #B.filterInInfoIdCards(var_94_0, var_92_0._infoId) > 0))
		end)

		var_92_12:setContentSize(ClientView.CARD_SIZE.width * var_92_11, ClientView.CARD_SIZE.height * var_92_11)
		lc.addChildToPos(var_92_2, var_92_12, cc.p(lc.cw(var_92_2) + (lc.w(var_92_12) + var_92_9) * (iter_92_1 - (#var_92_4 + 1) / 2), lc.ch(var_92_2)))

		local var_92_13 = CardSprite.create(var_92_4[iter_92_1], arg_92_0)

		var_92_13:initNormal()
		var_92_13:setRotation3D({
			z = 0,
			x = 0,
			y = 0
		})
		var_92_13._pCardArea:setScale(var_92_11)
		var_92_13:setCameraMask(1)
		lc.addChildToCenter(var_92_12, var_92_13)

		var_92_12._cardSprite = var_92_13

		var_92_13:removeInitiativeSkills()

		local var_92_14 = arg_92_0:efcDragonBones2("xuanzhong", "effect1", 2 * var_92_11, false)

		lc.addChildToCenter(var_92_13, var_92_14, -1)
		var_92_14:setVisible(var_92_6:isEnabled())

		var_92_13._bones = var_92_14

		local var_92_15 = var_92_3:getCanSacrificeCount({
			var_92_4[iter_92_1]
		}, var_92_0, nil, arg_92_4)

		if var_92_15 > 1 then
			local var_92_16 = ClientView.createBMFont(ClientView.BMFont.huali_32, "x" .. var_92_15)

			lc.addChildToPos(var_92_13, var_92_16, cc.p(lc.cw(var_92_13), -206 * var_92_11))
		end

		local var_92_17 = Str(var_92_4[iter_92_1]._owner == arg_92_0._player and STR.SELF or STR.OPPONENT) .. Str(STR.BATTLE_BOARD)
		local var_92_18 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_92_17)

		lc.addChildToPos(var_92_13, var_92_18, cc.p(lc.cw(var_92_13), 240 * var_92_11))

		if var_92_4[iter_92_1]._extraSid and var_92_4[iter_92_1]._extraSid > 0 then
			local var_92_19 = ClientView.createTTF(Str(Data._skillInfo[var_92_4[iter_92_1]._extraSid]._nameSid))

			lc.addChildToPos(var_92_13, var_92_19, cc.p(lc.cw(var_92_13), 210 * var_92_11))
		end

		arg_92_0._choiceBtns[#arg_92_0._choiceBtns + 1] = var_92_12
	end
end

function var_0_0.onChoiceSacrifice(arg_95_0, arg_95_1)
	local var_95_0 = arg_95_1._pCard
	local var_95_1 = arg_95_1._pTargetCard
	local var_95_2 = arg_95_1._choiceBase
	local var_95_3 = var_95_2 == 4 and arg_95_0._player._opponent or arg_95_0._player
	local var_95_4 = 0
	local var_95_5 = {
		1,
		2,
		4,
		8,
		16,
		1024,
		32,
		64,
		128,
		256,
		512,
		2048
	}
	local var_95_6 = 0
	local var_95_7 = {}

	for iter_95_0 = 1, #arg_95_0._choiceBtns do
		local var_95_8 = arg_95_0._choiceBtns[iter_95_0]._cardSprite
		local var_95_9 = var_95_8._card
		local var_95_10 = var_95_9._owner == var_95_3 and var_95_9._pos or var_95_9._pos + Data.MAX_CARD_COUNT_ON_BOARD + 1

		if var_95_8._bones:isVisible() then
			var_95_4 = var_95_4 + var_95_5[var_95_10]
			var_95_7[#var_95_7 + 1] = var_95_9

			if var_95_9:isKeyword(Data._skillInfo[3778]._refCards[1]) then
				var_95_6 = var_95_6 + (var_95_9:hasPowerSacrificeSkill(var_95_0._card) and 2 or 1)
			end
		end
	end

	var_95_0:setVisible(true)
	arg_95_1:endChoice()

	if var_95_2 % BattleData.ChoiceId.stage_size_1 == 7 then
		return arg_95_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_95_1._card,
			_choice = var_95_4 * BattleData.ChoiceId.stage_2 + var_95_2
		})
	elseif var_95_2 % BattleData.ChoiceId.stage_size_1 == 4 then
		return arg_95_0:showChoiceSkill(var_95_0, var_95_1, nil, var_95_4 * BattleData.ChoiceId.stage_2 + var_95_2)
	elseif var_95_0._card:hasSkills({
		3491,
		6724,
		6810,
		2191,
		2193
	}) or var_95_0._card:hasSkills({
		3778
	}) and var_95_6 < Data._skillInfo[3778]._val[1] or not var_95_0._card:hasChoiceSkill() then
		return arg_95_0:showChoicePos(var_95_0, var_95_1, nil, var_95_4 * BattleData.ChoiceId.stage_2 + var_95_2, {
			var_95_0._card
		}, B.filterBoardCards(arg_95_0._player._boardCards, var_95_7), BattlePosDialog.Mode.summon)
	else
		return arg_95_0:showChoiceSkill(var_95_0, var_95_1, nil, var_95_4 * BattleData.ChoiceId.stage_2 + var_95_2)
	end
end

function var_0_0.showChoiceSkill(arg_96_0, arg_96_1, arg_96_2, arg_96_3, arg_96_4)
	local var_96_0 = arg_96_1._card

	if arg_96_3 == nil then
		local var_96_1, var_96_2 = var_96_0:hasChoiceSkill()

		if not var_96_1 or not B.isSkillChoiceSkill(var_96_2) then
			return arg_96_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = arg_96_1._card,
				_target = arg_96_2 ~= nil and arg_96_2._card or nil,
				_choice = arg_96_4
			})
		end

		arg_96_3 = var_96_2
	end

	local var_96_3 = arg_96_0:createChoiceMaskLayer(arg_96_1, arg_96_2, arg_96_3, arg_96_4)
	local var_96_4 = ClientView.createTTF(Str(STR.CHOICE_TITLE_SKILL), ClientView.FontSize.M1)

	var_96_4:runAction(lc.rep(lc.sequence(lc.scaleTo(1.5, 1.05), lc.scaleTo(1.5, 1))))
	lc.addChildToPos(var_96_3, var_96_4, cc.p(lc.w(var_96_3) / 2, 600))

	local var_96_5 = var_96_0:hasSkillFast(4399) and 3 or 2

	for iter_96_0 = 1, var_96_5 do
		local var_96_6 = ClientView.createShaderButton(nil, function(arg_97_0)
			arg_96_0:onChoiceSkill(arg_97_0, var_96_3)
		end)

		var_96_6._index = iter_96_0

		var_96_6:setContentSize(346, 178)

		arg_96_0._choiceBtns[#arg_96_0._choiceBtns + 1] = var_96_6

		local var_96_7 = Data._skillInfo[var_96_3._skill._id]
		local var_96_8 = B.createSkill(var_96_7._refSkills[iter_96_0], var_96_3._skill._level)
		local var_96_9 = ClientView.createBattleSkillItem(arg_96_0._player, var_96_8, cc.p(0, 0))

		var_96_9:setTouchEnabled(false)
		var_96_9:setCameraMask(1)
		lc.addChildToCenter(var_96_6, var_96_9)

		local var_96_10 = arg_96_0:efcDragonBones2("xuanzhong", "effect5", 2, false)

		lc.addChildToCenter(var_96_9, var_96_10, -1)
	end

	lc.addNodesToCenter(var_96_3, arg_96_0._choiceBtns, var_96_5 == 3 and 100 or 200)
end

function var_0_0.onChoiceSkill(arg_98_0, arg_98_1, arg_98_2)
	local var_98_0 = arg_98_1._index
	local var_98_1 = arg_98_2._pCard
	local var_98_2 = arg_98_2._pTargetCard
	local var_98_3 = arg_98_2._choiceBase
	local var_98_4 = arg_98_2._skill

	var_98_1:setVisible(true)
	arg_98_2:endChoice()

	local var_98_5 = var_98_1._card

	if var_98_5._skills[1] ~= nil and var_98_5._skills[1]._id == 3108 and var_98_0 == 2 then
		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_5._owner:getBoardCards(), 2, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5._skills[2] ~= nil and var_98_5._skills[2]._id == 3208 and var_98_0 == 2 then
		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, B.sortCardsByBoardPos(var_98_5._owner._opponent:getBoardCards()), 1, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5._skills[3] ~= nil and var_98_5._skills[3]._id == 3635 and var_98_0 == 1 then
		local var_98_6 = B.mergeTable({
			B.sortCardsByBoardPos(var_98_5._owner._opponent:getBoardCards()),
			B.sortCardsByBoardPos(var_98_5._owner:getBattleCards("B", Data.CARD_MAX_LEVEL, var_98_5))
		})

		if #var_98_6 > 0 then
			return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_6, 1, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
		else
			arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = var_98_1._card,
				_target = var_98_2 ~= nil and var_98_2._card or nil,
				_choice = var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3
			})
		end
	elseif var_98_5:hasSkills({
		3491,
		3592,
		3825,
		2191,
		2193
	}) then
		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 * BattleData.ChoiceId.stage_2 + var_98_3
		})
	elseif var_98_5:hasSkillFast(3651) then
		local var_98_7 = B.filterNotSameNameCards(B.filterInKeywordCards(arg_98_0._player:getBattleCardsByType("G", Data.CardType.monster), Data._skillInfo[3651]._refCards[1]), var_98_5)

		if var_98_0 == 1 then
			var_98_7 = arg_98_0._player:filterCanChangeToHandCards(var_98_7)
		end

		if #var_98_7 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_7, 1, var_98_0 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + var_98_3)
	elseif var_98_5:hasSkills({
		3865,
		2383
	}) then
		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 * BattleData.ChoiceId.stage_2 + var_98_3
		})

		return true
	elseif var_98_5:hasSkillFast(4199) then
		local var_98_8 = arg_98_0._player:getBattleCardsByInfoIdGroup("H", Data._skillInfo[4199]._refCards)[1]
		local var_98_9

		if var_98_0 == 1 then
			local var_98_10 = arg_98_0._player:getCeremonyCandidates(var_98_8)

			var_98_9 = arg_98_0._player:isValidCeremonyComponents(var_98_8, var_98_10)
		else
			local var_98_11 = arg_98_0._player:getCeremonyGraveCandidates(var_98_8)

			var_98_9 = arg_98_0._player:isValidCeremonyComponents(var_98_8, var_98_11)
		end

		if not var_98_9 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceCeremony(var_98_1, var_98_2, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(4271) then
		local var_98_12 = Data._skillInfo[4271]
		local var_98_13 = B.filterNotEqualInfoIdCards(arg_98_0._player:getBattleCardsByKeyword("P", var_98_12._refCards[2]), var_98_12._refCards[1])

		if var_98_0 == 1 then
			var_98_13 = arg_98_0._player:filterCanChangeToHandCards(var_98_13)
		end

		if #var_98_13 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_13, 1, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(4388) then
		local var_98_14 = arg_98_0._player:getValidCeremonyResultCardsByTriggerCard(var_98_5)
		local var_98_15 = false

		for iter_98_0 = 1, #var_98_14 do
			if var_98_0 == 1 then
				local var_98_16 = arg_98_0._player:getCeremonyCandidates(var_98_14[iter_98_0])

				if arg_98_0._player:isValidCeremonyComponents(var_98_14[iter_98_0], var_98_16) then
					var_98_15 = true

					break
				end
			else
				local var_98_17 = arg_98_0._player:get4388CeremonyCandidates(var_98_14[iter_98_0])

				if arg_98_0._player:isValidCeremonyComponents(var_98_14[iter_98_0], var_98_17) then
					var_98_15 = true

					break
				end
			end
		end

		if not var_98_15 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceCeremony(var_98_1, var_98_2, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(4534) then
		local var_98_18 = Data._skillInfo[4534]
		local var_98_19

		if var_98_0 == 1 then
			var_98_19 = B.filterInKeywordCards(arg_98_0._player:getBattleCardsByType("P", Data.CardType.monster), var_98_18._refCards[1])
		else
			var_98_19 = arg_98_0._player:filterCanChangeToBoardCards(arg_98_0._player:getBattleCardsByKeyword("G", var_98_18._refCards[1]))
		end

		if #var_98_19 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_5._owner:getBoardCards(), 1, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(4576) then
		local var_98_20 = arg_98_0._player:getValidCeremonyResultCardsByTriggerCard(var_98_5)
		local var_98_21 = false

		for iter_98_1 = 1, #var_98_20 do
			if var_98_0 == 1 then
				local var_98_22 = arg_98_0._player:getCeremonyCandidates(var_98_20[iter_98_1])

				if arg_98_0._player:isValidCeremonyComponents(var_98_20[iter_98_1], var_98_22) then
					var_98_21 = true

					break
				end
			else
				local var_98_23 = arg_98_0._player:get4576CeremonyCandidates(var_98_20[iter_98_1])

				if arg_98_0._player:isValidCeremonyComponents(var_98_20[iter_98_1], var_98_23) then
					var_98_21 = true

					break
				end
			end
		end

		if not var_98_21 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceCeremony(var_98_1, var_98_2, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(4602) then
		local var_98_24 = Data._skillInfo[4602]
		local var_98_25 = B.mergeTable({
			B.sortCardsByBoardPos(arg_98_0._player:getBattleCardsByCategory("B", var_98_24._refCards[1])),
			B.sortCardsByBoardPos(arg_98_0._player._opponent:getBattleCardsByCategory("B", var_98_24._refCards[1]))
		})

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_25, 1, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(4762) then
		local var_98_26 = false

		if var_98_0 == 1 then
			var_98_26 = #arg_98_0._player._opponent:getBoardCards() > 0
		else
			var_98_26 = #arg_98_0._player._opponent:getBattleCards("CSD") > 0
		end

		if not var_98_26 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3
		})
	elseif var_98_5:hasSkillFast(4953) then
		local var_98_27 = false

		if var_98_0 == 1 then
			var_98_27 = #B.filterDefPostureCards(arg_98_0._player._opponent:getBoardCards(), false) > 0
		else
			var_98_27 = #arg_98_0._player._opponent:getBattleCards("CSD") > 0
		end

		if not var_98_27 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3
		})
	elseif var_98_5:hasSkillFast(5069) then
		local var_98_28 = Data._skillInfo[5069]
		local var_98_29 = {}

		if var_98_0 == 1 then
			var_98_29 = B.sortCardsByBoardPos(arg_98_0._player._opponent:getBoardCards())
		else
			var_98_29 = B.sortCardsByBoardPos(arg_98_0._player._opponent:getBattleCards("BCSD"))
		end

		if #var_98_29 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_29, 1, var_98_0 + var_98_3)
	elseif var_98_5:hasSkillFast(5118) then
		local var_98_30 = Data._skillInfo[5118]
		local var_98_31 = {}

		if var_98_0 == 1 then
			if arg_98_0._player:getEmptyGroundPos() ~= nil then
				cards = B.sortCardsByBoardPos(arg_98_0._player:getBattleCardsByKeyword("B", var_98_30._refCards[1]))

				for iter_98_2 = 1, #cards do
					if #B.filterNotBindedCards(arg_98_0._player:getBattleCardsByKeyword("B", var_98_30._refCards[1], Data.CARD_MAX_LEVEL, cards[iter_98_2]), cards[iter_98_2]:getAlterMagicInfoId()) > 0 then
						var_98_31[#var_98_31 + 1] = cards[iter_98_2]
					end
				end
			end
		elseif arg_98_0._player:getEmptyBoardPos() ~= nil then
			cards = arg_98_0._player:getBattleCardsByKeyword("S", var_98_30._refCards[1])

			for iter_98_3 = 1, #cards do
				local var_98_32 = cards[iter_98_3]:getAlterMonsterInfoId()
				local var_98_33 = arg_98_0._player:getTempLeaveCardByInfoId(var_98_32, false)

				if var_98_33 ~= nil and arg_98_0._player:canSpecialSummon(var_98_33) then
					var_98_31[#var_98_31 + 1] = cards[iter_98_3]
				end
			end
		end

		if #var_98_31 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_31, 1, var_98_0 + var_98_3)
	elseif var_98_5:hasSkillFast(5302) then
		local var_98_34 = Data._skillInfo[5302]
		local var_98_35

		if var_98_0 == 1 then
			var_98_35 = arg_98_0._player:filterCanChangeToHandCards(B.filterXYZCards(B.filterInKeywordCards(arg_98_0._player:getBattleCardsByType("G", Data.CardType.monster), var_98_34._refCards[1]), false))
		else
			var_98_35 = B.sortCardsByBoardPos(arg_98_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_98_0._player:getBattleCardsByTypeGroup("P", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_98_34._refCards[2])))
		end

		if #var_98_35 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_special_summon_invalid)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_35, 1, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(5378) then
		local var_98_36 = Data._skillInfo[5378]
		local var_98_37

		if var_98_0 == 1 then
			var_98_37 = B.sortCardsByBoardPos(arg_98_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_98_0._player:getBattleCardsByTypeGroup("P", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_98_36._refCards[1])))
		else
			var_98_37 = arg_98_0._player:filterCanChangeToHandCards(B.filterNormalTrapCards(arg_98_0._player._opponent:getBattleCardsByType("G", Data.CardType.trap)))
		end

		if #var_98_37 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_special_summon_invalid)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_37, 1, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(5396) then
		local var_98_38 = Data._skillInfo[5396]
		local var_98_39 = #B.filterFieldMagicCards(arg_98_0._player:getBattleCards("DG")) + #B.filterFieldMagicCards(arg_98_0._player._opponent:getBattleCards("DG"))
		local var_98_40 = arg_98_0._player:getEmptyBoardPosCount()
		local var_98_41 = arg_98_0._player._opponent:getEmptyBoardPosCount()
		local var_98_42 = false

		if var_98_0 == 1 then
			if var_98_40 > 0 then
				var_98_42 = true
			end
		elseif var_98_41 > 0 then
			var_98_42 = true
		end

		if not var_98_42 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_special_summon_invalid)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceNumber(var_98_1, var_98_2, 1, math.min(var_98_39, var_98_0 == 1 and var_98_40 or var_98_41), var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_5:hasSkillFast(6724) then
		local var_98_43 = Data._skillInfo[6724]
		local var_98_44 = B.filterInKeywordCards(arg_98_0._player:getBattleCardsByMaxStar("G", var_98_43._val[1]), var_98_43._refCards[1])

		if var_98_0 == 1 then
			var_98_44 = B.sortCardsByBoardPos(arg_98_0._player:filterCanChangeToBoardCards(var_98_44))
		else
			var_98_44 = B.sortCardsByBoardPos(arg_98_0._player._opponent:filterCanChangeToBoardCards(var_98_44))
		end

		if #var_98_44 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_44, 1, var_98_0 + var_98_3)
	elseif var_98_5:hasSkillFast(6810) then
		local var_98_45 = Data._skillInfo[6810]
		local var_98_46

		if var_98_0 == 1 then
			var_98_46 = arg_98_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_98_0._player:getBattleCardsByType("P", Data.CardType.monster), var_98_45._refCards[1]), true, true)
		else
			var_98_46 = arg_98_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_98_0._player:getBattleCardsByTypeGroup("P", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_98_45._refCards[1]))
		end

		if #var_98_46 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)

			return
		end

		local var_98_47 = arg_98_0._player:getBattleCardsByKeyword("H", var_98_45._refCards[1])

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_47, 1, var_98_0 + var_98_3)
	elseif var_98_5:hasSkillFast(6812) then
		local var_98_48 = Data._skillInfo[6812]
		local var_98_49

		if var_98_0 == 1 then
			var_98_49 = arg_98_0._player._opponent:getBoardCards()
		else
			var_98_49 = arg_98_0._player:filterCanChangeToBoardCards(arg_98_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster))
		end

		if #var_98_49 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, B.sortCardsByBoardPos(var_98_49), 1, var_98_0 + var_98_3)
	elseif var_98_5:hasSkillFast(6911) then
		local var_98_50 = Data._skillInfo[6911]
		local var_98_51 = B.filterInKeywordCards(arg_98_0._player:getBattleCardsByType("P", Data.CardType.monster), var_98_50._refCards[1])

		if var_98_0 == 1 then
			var_98_51 = arg_98_0._player:filterCanChangeToHandCards(var_98_51)
		end

		if #var_98_51 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, B.sortCardsByBoardPos(var_98_51), 1, var_98_0 + var_98_3)
	elseif var_98_5:hasSkillFast(2499) then
		local var_98_52 = Data._skillInfo[2499]
		local var_98_53

		if var_98_0 == 1 then
			var_98_53 = arg_98_0._player._opponent:getBattleCards("BCSD")
		else
			var_98_53 = arg_98_0._player:getBattleCardsByCategory("L", var_98_52._refCards[1])
		end

		if #var_98_53 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, B.sortCardsByBoardPos(var_98_53), 1, var_98_0 + var_98_3)
	elseif var_98_5:hasSkillFast(9479) then
		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 * BattleData.ChoiceId.stage_2 + var_98_3
		})
	elseif var_98_5:hasSkillFast(9854) then
		if var_98_0 == 1 then
			arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = var_98_1._card,
				_target = var_98_2 ~= nil and var_98_2._card or nil,
				_choice = var_98_3
			})
		else
			return arg_98_0:showChoiceGrave(var_98_1, var_98_2, B.mergeTable({
				B.sortCardsByBoardPos(arg_98_0._player._opponent:getBattleCards("BCSD")),
				B.sortCardsByBoardPos(arg_98_0._player:getBattleCards("BCSD"))
			}), 1, var_98_3)
		end
	elseif var_98_4 ~= nil and var_98_4._id == 13043 then
		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 * BattleData.ChoiceId.stage_2 + var_98_3
		})
	elseif var_98_4 ~= nil and var_98_4._id == 13913 then
		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 * BattleData.ChoiceId.stage_2 + var_98_3
		})
	elseif var_98_4 ~= nil and var_98_4._id == 7641 then
		local var_98_54

		if var_98_0 == 1 then
			var_98_54 = arg_98_0._player:filterCanChangeToHandCards(B.filterPendulumCards(arg_98_0._player:getBattleCards("PG"), true))
		else
			var_98_54 = arg_98_0._player:filterCanChangeToBoardCards(B.filterPendulumCards(arg_98_0._player:getBattleCards("PG"), true))
		end

		if #var_98_54 == 0 then
			arg_98_0:sendEvent(var_0_0.EventType.dialog_cannot_effect, var_98_5._type)
			arg_98_0:playAction(var_98_1, var_0_0.Action.replace_hand_card, 0, 1)

			return
		end

		return arg_98_0:showChoiceGrave(var_98_1, var_98_2, var_98_54, 1, var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3)
	elseif var_98_4 ~= nil and var_98_4._id == 7655 then
		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 + var_98_3
		})
	else
		arg_98_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = var_98_1._card,
			_target = var_98_2 ~= nil and var_98_2._card or nil,
			_choice = var_98_0 * BattleData.ChoiceId.stage_3 + var_98_3
		})
	end
end

function var_0_0.showChoiceNumber(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4, arg_99_5)
	local var_99_0 = arg_99_1._card
	local var_99_1 = arg_99_0:createChoiceMaskLayer(arg_99_1, arg_99_2, nil, arg_99_5)
	local var_99_2 = ""

	if arg_99_1._card:isSkillAtIndex(2964, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(2976, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(8116, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:hasSkillFast(5396) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_COUNT)
	elseif arg_99_1._card:hasSkillFast(5456) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_COUNT)
	elseif arg_99_1._card:hasSkillFast(9431) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_COUNT)
	elseif arg_99_1._card:hasSkillFast(9537) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_COUNT)
	elseif arg_99_1._card:hasSkillFast(9714) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(7480, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_NATURE)
	elseif arg_99_1._card:isSkillAtIndex(13141, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(13153, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(13240, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(13831, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(13851, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(13899, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(13980, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(14095, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(14325, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	elseif arg_99_1._card:isSkillAtIndex(14386, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then
		var_99_2 = Str(STR.CHOICE_TITLE_NUMBER_STAR)
	end

	local var_99_3 = ClientView.createTTF(var_99_2, ClientView.FontSize.M1)

	var_99_3:setColor(ClientView.COLOR_TEXT_TITLE)
	lc.addChildToPos(var_99_1, var_99_3, cc.p(lc.w(var_99_1) / 2, 640))

	local var_99_4 = arg_99_4 - arg_99_3 >= 5 and 2 or 1
	local var_99_5 = math.ceil((arg_99_4 - arg_99_3 + 1) / var_99_4)
	local var_99_6 = 0

	for iter_99_0 = arg_99_3, arg_99_4 do
		local var_99_7 = arg_99_0:createNumberButton(iter_99_0, arg_99_1._card:isSkillAtIndex(7480, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)))
		local var_99_8 = math.floor(var_99_6 / var_99_5)
		local var_99_9 = var_99_6 % var_99_5
		local var_99_10 = lc.w(var_99_7)
		local var_99_11 = lc.h(var_99_7)

		lc.addChildToPos(var_99_1, var_99_7, cc.p(lc.w(var_99_1) / 2 - (var_99_5 * var_99_10 + (var_99_5 - 1) * 40) / 2 + var_99_9 * (var_99_10 + 40) + var_99_10 / 2, 500 - var_99_8 * (var_99_11 + 40)))

		var_99_6 = var_99_6 + 1
	end

	local var_99_12 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_100_0)
		arg_99_0:onChoiceNumber(arg_100_0:getParent())
	end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

	var_99_12:addLabel(Str(STR.OK))
	lc.addChildToPos(var_99_1, var_99_12, cc.p(lc.cw(var_99_1), 200))
	var_99_12:setDisabledShader(ClientView.SHADER_DISABLE)
	var_99_12:setEnabled(false)

	var_99_1._btnOk = var_99_12
end

function var_0_0.onChoiceNumber(arg_101_0, arg_101_1)
	local var_101_0 = arg_101_1._pCard
	local var_101_1 = arg_101_1._pTargetCard
	local var_101_2 = arg_101_1._choiceBase
	local var_101_3 = arg_101_1._selectedBtn._num

	var_101_0:setVisible(true)
	arg_101_1:endChoice()
	arg_101_0:sendEvent(var_0_0.EventType.send_use_card, {
		_card = var_101_0._card,
		_target = var_101_1 ~= nil and var_101_1._card or nil,
		_choice = var_101_3 * BattleData.ChoiceId.stage_2 + var_101_2
	})
end

function var_0_0.createNumberButton(arg_102_0, arg_102_1, arg_102_2)
	local var_102_0 = ClientView.createShaderButton("room_number_btn", function(arg_103_0)
		if arg_103_0:getParent()._selectedBtn then
			arg_103_0:getParent()._selectedBtn:removeChildByTag(999)
		end

		arg_103_0:getParent()._selectedBtn = arg_103_0

		local var_103_0 = lc.createSprite("bat_online")

		lc.addChildToPos(arg_103_0:getParent()._selectedBtn, var_103_0, cc.p(98, 10), 0, 999)
		arg_103_0:getParent()._btnOk:setEnabled(true)
	end)

	var_102_0._num = arg_102_1

	local var_102_1 = arg_102_2 and Str(STR.NATURE_NONE + arg_102_1) or arg_102_1
	local var_102_2 = ClientView.createTTF(var_102_1, ClientView.FontSize.B2)

	lc.addChildToCenter(var_102_0, var_102_2)
	var_102_2:setColor(ClientView.COLOR_TEXT_DARK)

	return var_102_0
end

function var_0_0.showChoicePos(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4, arg_104_5, arg_104_6, arg_104_7)
	if not ClientData._isPosOn then
		arg_104_0:sendEvent(PlayerUi.EventType.send_use_card, {
			_card = arg_104_1._card,
			_target = arg_104_2 ~= nil and arg_104_2._card or nil,
			_choice = arg_104_4
		})

		return
	end

	local var_104_0 = BattlePosDialog.create(arg_104_0._battleUi, arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4, arg_104_5, arg_104_6, arg_104_7)

	var_104_0:show()

	arg_104_0._battleUi._choicePosDialog = var_104_0
end

function var_0_0.reverse(arg_105_0, arg_105_1)
	local var_105_0 = arg_105_0._avatarFrame

	if not arg_105_1 then
		var_105_0:setPosition(arg_105_0._isController and cc.p(0, 0) or cc.p(ClientView.SCR_W, ClientView.SCR_H))
		var_105_0:setAnchorPoint(arg_105_0._isController and cc.p(0, 0) or cc.p(1, 1))
		var_105_0._frame1:setFlippedX(not arg_105_0._isController)
		var_105_0._frame1:setFlippedY(not arg_105_0._isController)

		if var_105_0._crown then
			var_105_0._crown:setPosition(arg_105_0._isController and cc.p(112, 48) or cc.p(lc.w(var_105_0) - 112, lc.h(var_105_0) - 48))
		end

		if var_105_0._legendCrown then
			var_105_0._legendCrown:setPosition(arg_105_0._isController and cc.p(150, 48) or cc.p(lc.w(var_105_0) - 150, lc.h(var_105_0) - 48))
		end

		var_105_0._name:setPosition(arg_105_0._isController and cc.p(210, 30) or cc.p(lc.w(var_105_0) - 210, lc.h(var_105_0) - 30))
		var_105_0._frame3:setSpriteFrame(arg_105_0._isController and "bat_avatar_bg_03" or "bat_avatar_bg_04")

		local var_105_1 = arg_105_0._isController and cc.p(lc.w(var_105_0._avatar) / 2, lc.h(var_105_0._avatar) / 2) or cc.p(lc.w(var_105_0) - lc.w(var_105_0._avatar) / 2, lc.h(var_105_0) - lc.h(var_105_0._avatar) / 2)

		var_105_0._avatar:setPosition(var_105_1)

		var_105_0._avatarPos = var_105_1

		local var_105_2 = arg_105_0._isController and cc.p(90, 104) or cc.p(220, 40)

		arg_105_0._pHpLabel:setPosition(var_105_2)
		arg_105_0._pile:setPosition(cc.p(arg_105_0._isController and ClientView.SCR_W - 60 or 60, arg_105_0._isController and 40 or ClientView.SCR_H - 40))

		if arg_105_0._player._playerType == BattleData.PlayerType.observe then
			var_105_0._hideBtn:setPosition(cc.p(lc.left(arg_105_0._pile) - 40, lc.y(arg_105_0._pile)))
			var_105_0._hideBtn:setVisible(true)
		elseif arg_105_0._player._opponent._playerType == BattleData.PlayerType.observe then
			var_105_0._hideBtn:setPosition(cc.p(lc.right(arg_105_0._pile) + 40, lc.y(arg_105_0._pile)))
			var_105_0._hideBtn:setVisible(false)
		end
	else
		var_105_0:setPosition(arg_105_0._isController and cc.p(ClientView.SCR_W, ClientView.SCR_H) or cc.p(0, 0))
		var_105_0:setAnchorPoint(arg_105_0._isController and cc.p(1, 1) or cc.p(0, 0))
		var_105_0._frame1:setFlippedX(arg_105_0._isController)
		var_105_0._frame1:setFlippedY(arg_105_0._isController)

		if var_105_0._crown then
			var_105_0._crown:setPosition(arg_105_0._isController and cc.p(lc.w(var_105_0) - 112, lc.h(var_105_0) - 48) or cc.p(112, 48))
		end

		if var_105_0._legendCrown then
			var_105_0._legendCrown:setPosition(arg_105_0._isController and cc.p(lc.w(var_105_0) - 150, lc.h(var_105_0) - 48) or cc.p(150, 48))
		end

		var_105_0._name:setPosition(arg_105_0._isController and cc.p(lc.w(var_105_0) - 210, lc.h(var_105_0) - 30) or cc.p(210, 30))
		var_105_0._frame3:setSpriteFrame(arg_105_0._isController and "bat_avatar_bg_04" or "bat_avatar_bg_03")

		local var_105_3 = arg_105_0._isController and cc.p(lc.w(var_105_0) - lc.w(var_105_0._avatar) / 2, lc.h(var_105_0) - lc.h(var_105_0._avatar) / 2) or cc.p(lc.w(var_105_0._avatar) / 2, lc.h(var_105_0._avatar) / 2)

		var_105_0._avatar:setPosition(var_105_3)

		var_105_0._avatarPos = var_105_3

		local var_105_4 = arg_105_0._isController and cc.p(220, 40) or cc.p(90, 104)

		arg_105_0._pHpLabel:setPosition(var_105_4)
		arg_105_0._pile:setPosition(cc.p(not arg_105_0._isController and ClientView.SCR_W - 60 or 60, not arg_105_0._isController and 40 or ClientView.SCR_H - 40))

		if arg_105_0._player._playerType == BattleData.PlayerType.observe then
			var_105_0._hideBtn:setPosition(cc.p(lc.right(arg_105_0._pile) + 40, lc.y(arg_105_0._pile)))
			var_105_0._hideBtn:setVisible(false)
		elseif arg_105_0._player._opponent._playerType == BattleData.PlayerType.observe then
			var_105_0._hideBtn:setPosition(cc.p(lc.left(arg_105_0._pile) - 40, lc.y(arg_105_0._pile)))
			var_105_0._hideBtn:setVisible(true)
		end
	end

	arg_105_0._pRareLabel:setScaleY(-arg_105_0._pRareLabel:getScaleY())
	arg_105_0._pGraveLabel:setScaleY(-arg_105_0._pGraveLabel:getScaleY())
end

function var_0_0.clear(arg_106_0)
	arg_106_0._avatarFrame:removeFromParent()
	arg_106_0._pile:removeFromParent()
	arg_106_0._pGraveLabel:removeFromParent()
	arg_106_0._pRareLabel:removeFromParent()
end

function var_0_0.uiRandomTable(arg_107_0, arg_107_1, arg_107_2)
	if arg_107_1 == nil then
		return {}
	end

	local var_107_0 = {}
	local var_107_1 = #arg_107_1

	if var_107_1 < arg_107_2 then
		for iter_107_0 = 1, var_107_1 do
			table.insert(var_107_0, arg_107_1[iter_107_0])
		end
	else
		local var_107_2 = {}

		for iter_107_1 = 1, arg_107_2 do
			print("math.random()math.random()math.random()math.random()math.random()", math.random())

			local var_107_3 = math.min(math.floor(math.random() * var_107_1 + 1), var_107_1)

			while true do
				if var_107_2[var_107_3] ~= true then
					var_107_2[var_107_3] = true

					table.insert(var_107_0, arg_107_1[var_107_3])

					break
				else
					var_107_3 = var_107_3 % var_107_1 + 1
				end
			end
		end
	end

	return var_107_0
end

function var_0_0.initBoardRects(arg_108_0)
	local var_108_0 = arg_108_0._isController and {
		3,
		4,
		2,
		5,
		1
	} or {
		3,
		2,
		4,
		1,
		5
	}
	local var_108_1 = {}
	local var_108_2 = lc.ch(arg_108_0._battleUi._battleFrame) + (arg_108_0._isController and -148 or 148)

	for iter_108_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_108_3 = lc.createSprite("battle_board_large_01")

		lc.addChildToPos(arg_108_0._battleUi._battleFrame, var_108_3, cc.p(98 + var_108_0[iter_108_0] * 176, var_108_2))

		var_108_1[iter_108_0] = var_108_3
	end

	arg_108_0._largeRects = var_108_1

	local var_108_4 = lc.createSprite(arg_108_0._isController and "battle_ex" or "battle_ex_2")

	lc.addChildToPos(arg_108_0._battleUi._battleFrame, var_108_4, cc.p(lc.x(var_108_1[2]), lc.ch(arg_108_0._battleUi._battleFrame)))

	arg_108_0._exRect = var_108_4

	local var_108_5 = {}
	local var_108_6 = arg_108_0._isController and 94 or -94
	local var_108_7 = arg_108_0._isController and -64 or 64

	for iter_108_1 = 1, 2 do
		local var_108_8 = lc.createSprite("battle_board_small_01")

		lc.addChildToPos(arg_108_0._battleUi._battleFrame, var_108_8, cc.p(lc.x(var_108_1[2]), lc.y(var_108_1[2]) + (iter_108_1 == 1 and var_108_6 or var_108_7)))

		var_108_5[iter_108_1 == 1 and 6 or 2] = var_108_8
	end

	arg_108_0._smallRects = var_108_5
end

function var_0_0.switchBoard(arg_109_0, arg_109_1)
	arg_109_0._exRect:setVisible(arg_109_1)
	arg_109_0._largeRects[2]:setVisible(arg_109_1)
	arg_109_0._smallRects[2]:setVisible(not arg_109_1)
	arg_109_0._smallRects[6]:setVisible(not arg_109_1)

	for iter_109_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		if arg_109_0._pBoardCards[iter_109_0] ~= nil then
			arg_109_0._pBoardCards[iter_109_0]._pCardArea:setScale((iter_109_0 == 2 or iter_109_0 == 6) and not arg_109_1 and CardSprite.Scale.normal_small or CardSprite.Scale.normal)
			arg_109_0._pBoardCards[iter_109_0]:setPosition(arg_109_0:calBoardCardPos(arg_109_0._pBoardCards[iter_109_0]))
		end
	end

	arg_109_0:refreshBoardRectsColor()
	arg_109_0._opponentUi:refreshBoardRectsColor()
end

function var_0_0.refreshBoardRectsColor(arg_110_0)
	for iter_110_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		if arg_110_0._largeRects[iter_110_0] then
			arg_110_0._largeRects[iter_110_0]:setSpriteFrame(arg_110_0._player._linkPos[iter_110_0] and "battle_board_large_02" or "battle_board_large_01")
		end

		if arg_110_0._smallRects[iter_110_0] then
			arg_110_0._smallRects[iter_110_0]:setSpriteFrame(arg_110_0._player._linkPos[iter_110_0] and "battle_board_small_02" or "battle_board_small_01")
		end
	end
end

return var_0_0
