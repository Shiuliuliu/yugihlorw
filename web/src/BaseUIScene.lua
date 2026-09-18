local var_0_0 = class("BaseUIScene", require("BaseScene"))
local var_0_1 = cc.c4b(30, 20, 10, 255)
local var_0_2 = 60

var_0_0.STYLE_EMPTY = 0
var_0_0.STYLE_SIMPLE = 1
var_0_0.STYLE_TAB = 2

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if not var_0_0.super.init(arg_1_0, arg_1_1) then
		return false
	end

	arg_1_0:initCommonArea(arg_1_2, arg_1_3, arg_1_4)

	return true
end

function var_0_0.initCommonArea(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = lc.w(arg_2_0) / 2
	local var_2_1 = lc.createSprite("res/jpg/ui_scene_bg.jpg")

	lc.addChildToCenter(arg_2_0, var_2_1)

	arg_2_0._bg = var_2_1

	local function var_2_2(arg_3_0)
		arg_3_0:setEnabled(false)
		arg_3_0:runAction(lc.sequence(1, function()
			arg_3_0:setEnabled(true)
		end))
		arg_2_0:hide()
	end

	local function var_2_3(arg_5_0)
		arg_2_0:onHelp()
	end

	arg_2_0._titleArea = ClientView.createTitleArea(Str(arg_2_1), var_2_2, var_2_3, arg_2_3)

	arg_2_0:addChild(arg_2_0._titleArea, 1)

	if arg_2_2 ~= var_0_0.STYLE_EMPTY then
		-- block empty
	end
end

function var_0_0.onEnter(arg_6_0)
	var_0_0.super.onEnter(arg_6_0)

	local var_6_0 = ClientView.getResourceUI()

	var_6_0:setMode(Data.ResType.gold)
	arg_6_0._scene:addChild(var_6_0, ClientData.ZOrder.ui)
	arg_6_0._titleArea._btnBack:setEnabled(true)
	lc.Audio.playAudio(AUDIO.M_CITY)
end

function var_0_0.onExit(arg_7_0)
	var_0_0.super.onExit(arg_7_0)
	ClientView.removeResourceFromParent()
	arg_7_0._titleArea._btnBack:setEnabled(false)
end

function var_0_0.onCleanup(arg_8_0)
	var_0_0.super.onCleanup(arg_8_0)
end

function var_0_0.hide(arg_9_0)
	ClientView.popScene()
end

function var_0_0.onHelp(arg_10_0)
	local var_10_0

	if arg_10_0._sceneId == ClientData.SceneId.manage_troop then
		var_10_0 = Data.HelpType.herocenter
	elseif arg_10_0._sceneId == ClientData.SceneId.barrack then
		var_10_0 = Data.HelpType.barrack
	elseif arg_10_0._sceneId == ClientData.SceneId.factory_trap then
		var_10_0 = Data.HelpType.blacksmith
	elseif arg_10_0._sceneId == ClientData.SceneId.stable then
		var_10_0 = Data.HelpType.stable
	elseif arg_10_0._sceneId == ClientData.SceneId.factory_magic then
		var_10_0 = Data.HelpType.library
	elseif arg_10_0._sceneId == ClientData.SceneId.market then
		var_10_0 = Data.HelpType.market
	elseif arg_10_0._sceneId == ClientData.SceneId.tavern then
		local var_10_1 = arg_10_0._tabArea._focusedTab._index

		if var_10_1 == arg_10_0.TAB.time_limit then
			var_10_0 = Data.HelpType.tavern_time_limit
		elseif var_10_1 == arg_10_0.TAB.times_limit then
			var_10_0 = Data.HelpType.tavern_times_limit
		elseif var_10_1 == arg_10_0.TAB.draw_card then
			var_10_0 = Data.HelpType.tavern_draw_card
		elseif var_10_1 == arg_10_0.TAB.rare_draw_card then
			var_10_0 = Data.HelpType.tavern_rare_draw_card
		elseif var_10_1 == arg_10_0.TAB.depot_shop then
			var_10_0 = Data.HelpType.tavern_depot_shop
		elseif var_10_1 == arg_10_0.TAB.depot_vip_shop then
			var_10_0 = Data.HelpType.tavern_depot_vip_shop
		elseif var_10_1 == arg_10_0.TAB.rare_shop then
			var_10_0 = Data.HelpType.tavern_rare_shop
		elseif var_10_1 == arg_10_0.TAB.diamond_shop then
			var_10_0 = Data.HelpType.tavern_diamond_shop
		elseif var_10_1 == arg_10_0.TAB.god_pump then
			var_10_0 = Data.HelpType.tavern_god_pump
		elseif var_10_1 == arg_10_0.TAB.critical_card then
			var_10_0 = Data.HelpType.tavern_critical
		elseif var_10_1 == arg_10_0.TAB.select_card then
			var_10_0 = Data.HelpType.select_card
		elseif var_10_1 == arg_10_0.TAB.vote_shop then
			var_10_0 = Data.HelpType.vote_shop
		elseif var_10_1 == arg_10_0.TAB.vote_recovery then
			var_10_0 = Data.HelpType.recovery
		elseif var_10_1 == arg_10_0.TAB.clash then
			var_10_0 = Data.HelpType.clash_package
		elseif var_10_1 == arg_10_0.TAB.collect then
			var_10_0 = Data.HelpType.collect_package
		elseif var_10_1 == arg_10_0.TAB.new_shop then
			var_10_0 = Data.HelpType.new_shop
		elseif var_10_1 == arg_10_0.TAB.skill_shop then
			var_10_0 = Data.HelpType.skill_shop
		elseif var_10_1 == arg_10_0.TAB.badge_shop then
			var_10_0 = Data.HelpType.badge_shop
		elseif var_10_1 == arg_10_0.TAB.month_card5_shop then
			var_10_0 = Data.HelpType.month_card5_shop
		end
	elseif arg_10_0._sceneId == ClientData.SceneId.factory_monster then
		var_10_0 = Data.HelpType.heromansion
	elseif arg_10_0._sceneId == ClientData.SceneId.palace then
		var_10_0 = Data.HelpType.palace
	elseif arg_10_0._sceneId == ClientData.SceneId.train then
		var_10_0 = Data.HelpType.train
	elseif arg_10_0._sceneId == ClientData.SceneId.expedition then
		var_10_0 = Data.HelpType.expedition
	elseif arg_10_0._sceneId == ClientData.SceneId.guard then
		var_10_0 = Data.HelpType.guard
	elseif arg_10_0._sceneId == ClientData.SceneId.lottery then
		if arg_10_0._type == Data.LotteryType.explore then
			var_10_0 = Data.HelpType.lottery
		elseif arg_10_0._type == Data.LotteryType.dark then
			var_10_0 = Data.HelpType.dark_lottery
		elseif arg_10_0._type == Data.LotteryType.spring then
			var_10_0 = Data.HelpType.spring_lottery
		elseif arg_10_0._type == Data.LotteryType.week then
			var_10_0 = Data.HelpType.week_lottery
		end
	elseif arg_10_0._sceneId == ClientData.SceneId.find then
		local var_10_2 = arg_10_0._tabArea._focusedTab._index

		if var_10_2 == arg_10_0.TAB.clash then
			var_10_0 = Data.HelpType.seek
		elseif var_10_2 == arg_10_0.TAB.ladder then
			var_10_0 = Data.HelpType.elite
		elseif var_10_2 == arg_10_0.TAB.union_battle then
			var_10_0 = Data.HelpType.union_battle
		elseif var_10_2 == arg_10_0.TAB.dark then
			var_10_0 = Data.HelpType.dark
		elseif var_10_2 == arg_10_0.TAB.hall then
			var_10_0 = Data.HelpType.room
		elseif var_10_2 == arg_10_0.TAB.survival_ex then
			var_10_0 = Data.HelpType.survival
		elseif var_10_2 == arg_10_0.TAB.clash_ex then
			var_10_0 = Data.HelpType.clash_ex
		end
	elseif arg_10_0._sceneId == ClientData.SceneId.depot then
		var_10_0 = Data.HelpType.depot
	elseif arg_10_0._sceneId == ClientData.SceneId.union then
		var_10_0 = Data.HelpType.union
	elseif arg_10_0._sceneId == ClientData.SceneId.skin_shop then
		var_10_0 = Data.HelpType.skin_shop
	elseif arg_10_0._sceneId == ClientData.SceneId.in_room then
		var_10_0 = Data.HelpType.room
	elseif arg_10_0._sceneId == ClientData.SceneId.effect_shop then
		var_10_0 = Data.HelpType.effect_shop
	elseif arg_10_0._sceneId == ClientData.SceneId.card_operate then
		var_10_0 = Data.HelpType.card_operate
	elseif arg_10_0._sceneId == ClientData.SceneId.festival_lottery then
		var_10_0 = Data.HelpType.festival_lottery
	elseif arg_10_0._sceneId == ClientData.SceneId.survival_ex_hall then
		var_10_0 = Data.HelpType.survival
	elseif arg_10_0.getHelpType then
		var_10_0 = arg_10_0:getHelpType()
	end

	if var_10_0 then
		ClientView.showHelpForm(nil, var_10_0)
	end
end

BaseUIScene = var_0_0

return var_0_0
