local var_0_0 = class("FindScene", BaseUIScene)
local var_0_1 = require("FindClashArea")
local var_0_2 = require("FindLadderArea")
local var_0_3 = require("HallAreaNew")
local var_0_4 = require("UnionBattleArea")
local var_0_5 = require("DarkBattleArea")
local var_0_6 = require("FindSurvivalArea")
local var_0_7 = require("FindSurvivalExArea")
local var_0_8 = require("ClashExArea")
local var_0_9 = "res/jpg/find_match_bg.jpg"

var_0_0.TAB = {
	clash = Data.FindMatchType.clash,
	ladder = Data.FindMatchType.ladder,
	hall = Data.FindMatchType.hall,
	union_battle = Data.FindMatchType.union_battle,
	dark = Data.FindMatchType.dark,
	survival = Data.FindMatchType.survival,
	survival_ex = Data.FindMatchType.survival_ex,
	clash_ex = Data.FindMatchType.clash_ex
}

function var_0_0.create(arg_1_0)
	return lc.createScene(var_0_0, arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.find, STR.FIND_TITLE, BaseUIScene.STYLE_EMPTY, true) then
		return false
	end

	ClientData.loadLCRes("res/find.lcres")

	arg_2_0._initTabIndex = arg_2_1 or var_0_0.TAB.clash

	arg_2_0:initTabArea()

	function arg_2_0._titleArea._btnBack._callback()
		if P._playerFindDark:isInDarkBattle() then
			require("Dialog").showDialog(Str(STR.DARK_BATTLE_WARNING), function()
				P._playerFindDark:retreat(true)
				arg_2_0:onBattleWait()
			end)
		else
			arg_2_0:hide()
		end
	end

	return true
end

function var_0_0.syncData(arg_5_0)
	var_0_0.super.syncData(arg_5_0)

	if not P._playerFindClash._isSyncData then
		arg_5_0:setTabIndicators(true)
		ClientData.sendClashSync()
	end
	if P._playerFindClash._isSyncData then
		arg_5_0:setTabIndicators(false)
	end

	local var_5_0

	if arg_5_0._tabArea._focusedTab then
		var_5_0 = arg_5_0._tabArea._focusedTab._index
	else
		var_5_0 = arg_5_0._initTabIndex
	end

	if not P._playerFindClash._isSyncData and var_5_0 ~= var_0_0.TAB.dark and not ClientData.isAppStoreReviewing() then
		var_5_0 = var_0_0.TAB.clash
	end

	if P._playerFindDark:isInDarkBattle() then
		var_5_0 = var_0_0.TAB.dark
	end

	arg_5_0._tabArea:showTab(var_5_0, true)
	arg_5_0:showTabFlag()
	arg_5_0._titleArea:setVisible(true)
	arg_5_0._titleArea:setOpacity(255)
end

function var_0_0.initTabArea(arg_6_0)
	local var_6_0 = {}

	if not ClientData.isAppStoreReviewing() then
		table.insert(var_6_0, {
			_icon = "img_icon_pvp_01",
			_index = var_0_0.TAB.clash,
			checkValid = function()
				return true
			end
		})
		table.insert(var_6_0, {
			_icon = "img_icon_clash_ex",
			_index = var_0_0.TAB.clash_ex,
			checkValid = function()
				return true
			end
		})
		table.insert(var_6_0, {
			_icon = "img_icon_pvp_02",
			_index = var_0_0.TAB.ladder,
			checkValid = function()
				if false and P:getMaxCharacterLevel() < Data._globalInfo._unlockLadder then
					local var_9_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

					var_9_0:init(false, true)

					function var_9_0.onCleanup(arg_10_0)
						lc.TextureCache:removeTextureForKey("res/jpg/ad_20.jpg")
						lc.TextureCache:removeTextureForKey("res/jpg/ad_20_2.jpg")
					end

					local var_9_1 = "ad_20"

					if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_9_1 .. "_2")) then
						var_9_1 = var_9_1 .. "_2"
					end

					local var_9_2 = lc.createSprite(lc.formatJpg(var_9_1))

					lc.addChildToCenter(var_9_0, var_9_2)
					var_9_0:show()

					return false
				end

				if not P._playerFindClash._isSyncData then
					return false
				end

				return true
			end
		})
		table.insert(var_6_0, {
			_icon = "img_icon_survival",
			_index = var_0_0.TAB.survival_ex,
			checkValid = function()
				if false and P:getMaxCharacterLevel() < Data._globalInfo._unlockSurvival then
					local var_11_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

					var_11_0:init(false, true)

					function var_11_0.onCleanup(arg_12_0)
						lc.TextureCache:removeTextureForKey("res/jpg/ad_survival.jpg")
						lc.TextureCache:removeTextureForKey("res/jpg/ad_survival_2.jpg")
					end

					local var_11_1 = "ad_survival"

					if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_11_1 .. "_2")) then
						var_11_1 = var_11_1 .. "_2"
					end

					local var_11_2 = lc.createSprite(lc.formatJpg(var_11_1))

					lc.addChildToCenter(var_11_0, var_11_2)
					var_11_0:show()

					return false
				end

				return true
			end
		})

		if P._playerFindDark:getIsDarkActivityValid() then
			table.insert(var_6_0, {
				_icon = "img_icon_dark",
				_index = var_0_0.TAB.dark,
				checkValid = function()
					if P:getMaxCharacterLevel() < Data._globalInfo._unlockDark then
						local var_13_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

						var_13_0:init(false, true)

						function var_13_0.onCleanup(arg_14_0)
							lc.TextureCache:removeTextureForKey("res/jpg/ad_dark.jpg")
							lc.TextureCache:removeTextureForKey("res/jpg/ad_dark_2.jpg")
						end

						local var_13_1 = "ad_dark"

						if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_13_1 .. "_2")) then
							var_13_1 = var_13_1 .. "_2"
						end

						local var_13_2 = lc.createSprite(lc.formatJpg(var_13_1))

						lc.addChildToCenter(var_13_0, var_13_2)
						var_13_0:show()

						return false
					end

					return true
				end
			})
		end

		if P._playerFindUnionBattle:getIsUnionBattleActivityValid() then
			table.insert(var_6_0, {
				_icon = "img_icon_union_battle",
				_index = var_0_0.TAB.union_battle,
				checkValid = function()
					if P:getMaxCharacterLevel() < Data._globalInfo._unlock2v2 then
						local var_15_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

						var_15_0:init(false, true)

						function var_15_0.onCleanup(arg_16_0)
							lc.TextureCache:removeTextureForKey("res/jpg/ad_18.jpg")
							lc.TextureCache:removeTextureForKey("res/jpg/ad_18_2.jpg")
						end

						local var_15_1 = "ad_18"

						if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_15_1 .. "_2")) then
							var_15_1 = var_15_1 .. "_2"
						end

						local var_15_2 = lc.createSprite(lc.formatJpg(var_15_1))

						lc.addChildToCenter(var_15_0, var_15_2)
						var_15_0:show()

						return false
					end

					if not P._playerFindClash._isSyncData then
						return false
					end

					return true
				end
			})
		end

		table.insert(var_6_0, {
			_icon = "img_icon_hall",
			_index = var_0_0.TAB.hall,
			checkValid = function()
				if false and P:getMaxCharacterLevel() < Data._globalInfo._unlockHall then
					local var_17_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

					var_17_0:init(false, true)

					function var_17_0.onCleanup(arg_18_0)
						lc.TextureCache:removeTextureForKey("res/jpg/ad_15.jpg")
						lc.TextureCache:removeTextureForKey("res/jpg/ad_15_2.jpg")
					end

					local var_17_1 = "ad_15"

					if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_17_1 .. "_2")) then
						var_17_1 = var_17_1 .. "_2"
					end

					local var_17_2 = lc.createSprite(lc.formatJpg(var_17_1))

					lc.addChildToCenter(var_17_0, var_17_2)
					var_17_0:show()

					return false
				end

				if not P._playerFindClash._isSyncData then
					return false
				end

				return true
			end
		})
	elseif ClientData.getAppStoreReviewingType() == 1 then
		table.insert(var_6_0, {
			_icon = "img_icon_pvp_01",
			_index = var_0_0.TAB.clash,
			checkValid = function()
				return true
			end
		})
	elseif ClientData.getAppStoreReviewingType() == 2 then
		table.insert(var_6_0, {
			_icon = "img_icon_pvp_02",
			_index = var_0_0.TAB.ladder,
			checkValid = function()
				return true
			end
		})
	elseif ClientData.getAppStoreReviewingType() == 3 then
		if arg_6_0._initTabIndex == 5 then
			table.insert(var_6_0, {
				_icon = "city_3_icon_union_battle",
				_index = var_0_0.TAB.union_battle,
				checkValid = function()
					return true
				end
			})
		elseif arg_6_0._initTabIndex == 6 then
			table.insert(var_6_0, {
				_icon = "city_3_icon_dark",
				_index = var_0_0.TAB.dark,
				checkValid = function()
					return true
				end
			})
		else
			table.insert(var_6_0, {
				_icon = "city_3_icon_survival",
				_index = var_0_0.TAB.survival_ex,
				checkValid = function()
					return true
				end
			})
		end
	end

	local var_6_1 = ClientView.createVerticalIconTabListArea(lc.bottom(arg_6_0._titleArea), var_6_0, function(arg_24_0, arg_24_1, arg_24_2)
		if not arg_24_1 or arg_24_2 then
			arg_6_0:showTab(arg_24_0)
		end
	end, ClientView.SCR_EDGE)

	lc.addChildToPos(arg_6_0, var_6_1, cc.p(lc.w(var_6_1) / 2 - 4 + ClientView.SCR_EDGE, lc.bottom(arg_6_0._titleArea) / 2 + 2), 1)

	arg_6_0._tabArea = var_6_1
end

function var_0_0.showTab(arg_25_0, arg_25_1)
	if P._playerFindDark:isInDarkBattle() and arg_25_1._index ~= var_0_0.TAB.dark then
		require("Dialog").showDialog(Str(STR.DARK_BATTLE_WARNING), function()
			P._playerFindDark:retreat(true)
			arg_25_0:onBattleWait()
		end)
		arg_25_0._tabArea:showTab(var_0_0.TAB.dark)
	end

	local var_25_0 = arg_25_0._contentArea

	if var_25_0 then
		if var_25_0._linkObjs then
			for iter_25_0, iter_25_1 in ipairs(var_25_0._linkObjs) do
				iter_25_1:removeFromParent()
			end
		end

		var_25_0:removeFromParent()

		arg_25_0._contentArea = nil
	end

	local var_25_1 = lc.w(arg_25_0) - lc.right(arg_25_0._tabArea)
	local var_25_2, var_25_3, var_25_4 = lc.bottom(arg_25_0._titleArea)

	if arg_25_1._index ~= var_0_0.TAB.clash then
		ClientData._isAutoBattle = false
		ClientData._autoReloadCount = 0
	end

	if arg_25_1._index == var_0_0.TAB.clash then
		var_25_3 = var_0_1.create(var_25_1, var_25_2)
	elseif arg_25_1._index == var_0_0.TAB.ladder then
		var_25_3 = var_0_2.create(var_25_1, var_25_2)
	elseif arg_25_1._index == var_0_0.TAB.hall then
		var_25_3 = var_0_3.create(var_25_1, var_25_2)
	elseif arg_25_1._index == var_0_0.TAB.union_battle then
		var_25_3 = var_0_4.create(var_25_1, var_25_2)
	elseif arg_25_1._index == var_0_0.TAB.dark then
		var_25_3 = var_0_5.create(var_25_1, var_25_2)
	elseif arg_25_1._index == var_0_0.TAB.survival then
		var_25_3 = var_0_6.create(var_25_1, var_25_2)
	elseif arg_25_1._index == var_0_0.TAB.survival_ex then
		var_25_3 = var_0_7.create(var_25_1, var_25_2)
	elseif arg_25_1._index == var_0_0.TAB.clash_ex then
		var_25_3 = var_0_8.create(var_25_1, var_25_2)
	end

	if var_25_3 then
		lc.addChildToPos(arg_25_0, var_25_3, cc.p((lc.w(arg_25_0) + lc.right(arg_25_0._tabArea)) / 2, var_25_4 or lc.h(var_25_3) / 2))

		arg_25_0._contentArea = var_25_3
	end

	arg_25_0:setResourceMode()
end

function var_0_0.showTabFlag(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._tabArea._list:getItems()

	if arg_27_1 == nil or arg_27_1 == var_0_0.TAB.trophy then
		local var_27_1 = P._playerLog:getNewDefenseLogCount()

		ClientView.checkNewFlag(var_27_0[1], var_27_1)

		if var_0_0.TAB.trophy == arg_27_0._tabArea._focusedTab._index then
			arg_27_0._contentArea:updateLogFlag()
		end
	end

	if arg_27_1 ~= nil and arg_27_1 == var_0_0.TAB.clash then
		-- block empty
	end
end

function var_0_0.setResourceMode(arg_28_0)
	ClientView.getResourceUI():setVisible(true)

	local var_28_0 = arg_28_0._tabArea._focusedTab._index

	if var_28_0 == var_0_0.TAB.clash then
		ClientView.getResourceUI():setMode(Data.ResType.clash_trophy)
	elseif var_28_0 == var_0_0.TAB.ladder then
		ClientView.getResourceUI():setMode(not P._playerFindLadder._hasTicket and Data.PropsId.ladder_ticket or ClientData.isAppStoreReviewing() and Data.ResType.gold or Data.ResType.ladder_trophy)
	elseif var_28_0 == var_0_0.TAB.hall then
		ClientView.getResourceUI():setMode(Data.ResType.gold)
	elseif var_28_0 == var_0_0.TAB.union_battle then
		ClientView.getResourceUI():setMode(Data.ResType.gold)
	elseif var_28_0 == var_0_0.TAB.dark then
		ClientView.getResourceUI():setMode(Data.ResType.dark_trophy)
		ClientView.getResourceUI():setVisible(not P._playerFindDark:isInDarkBattle())
	elseif var_28_0 == var_0_0.TAB.survival_ex then
		ClientView.getResourceUI():setMode(Data.ResType.gold)
	end
end

function var_0_0.onEnter(arg_29_0)
	var_0_0.super.onEnter(arg_29_0)

	arg_29_0._listeners = {}

	table.insert(arg_29_0._listeners, lc.addEventListener(Data.Event.log_dirty, function(arg_30_0)
		local var_30_0 = require("PlayerLog")

		if arg_30_0._event == var_30_0.Event.defense_log_dirty then
			arg_29_0:showTabFlag(var_0_0.TAB.trophy)
		end
	end))
	table.insert(arg_29_0._listeners, lc.addEventListener(Data.Event.clash_sync_ready, function(arg_31_0)
		arg_29_0:setTabIndicators(false)
	end))
	if P._playerFindClash._isSyncData then
		arg_29_0:setTabIndicators(false)
	end
	arg_29_0:checkSurvivalBonus()
	table.insert(arg_29_0._listeners, lc.addEventListener(Data.Event.survival_game_over, function(arg_32_0)
		ClientView.getActiveIndicator():hide()
		arg_29_0:checkSurvivalBonus()
	end))
	table.insert(arg_29_0._listeners, lc.addEventListener(Data.Event.survival_explore_end, function(arg_33_0)
		arg_29_0:checkSurvivalBonus()
	end))
	arg_29_0:checkSurvivalExBonus()
	table.insert(arg_29_0._listeners, lc.addEventListener(Data.Event.survival_ex_game_over, function(arg_34_0)
		ClientView.getActiveIndicator():hide()
		arg_29_0:checkSurvivalExBonus()
	end))
	table.insert(arg_29_0._listeners, lc.addEventListener(Data.Event.survival_ex_explore_end, function(arg_35_0)
		arg_29_0:checkSurvivalExBonus()
	end))

	local var_29_0 = false
	local var_29_1 = arg_29_0._contentArea

	if var_29_1 == nil or not var_29_1._ignoreSync then
		local var_29_2 = true

		arg_29_0:syncData()
	else
		var_29_1._ignoreSync = nil

		arg_29_0:setResourceMode()
	end

	local var_29_3

	if arg_29_0._tabArea._focusedTab then
		var_29_3 = arg_29_0._tabArea._focusedTab._index
	else
		var_29_3 = arg_29_0._initTabIndex
	end

	if not P._playerFindClash._isSyncData and var_29_3 ~= var_0_0.TAB.dark and not ClientData.isAppStoreReviewing() then
		var_29_3 = var_0_0.TAB.clash
	end

	if P._playerFindDark:isInDarkBattle() then
		var_29_3 = var_0_0.TAB.dark
	end

	arg_29_0._tabArea:showTab(var_29_3, true)
end

function var_0_0.setTabIndicators(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._tabArea._list:getItems()

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if iter_36_1._index ~= var_0_0.TAB.clash and iter_36_1._index ~= var_0_0.TAB.dark then
			local var_36_1 = iter_36_1._indicator

			if arg_36_1 then
				if not var_36_1 then
					iter_36_1._indicator = ClientView.showPanelActiveIndicator(iter_36_1)
				end
			elseif var_36_1 then
				var_36_1:removeFromParent()

				iter_36_1._indicator = nil
			end
		end
	end
end

function var_0_0.onExit(arg_37_0)
	var_0_0.super.onExit(arg_37_0)

	for iter_37_0 = 1, #arg_37_0._listeners do
		lc.Dispatcher:removeEventListener(arg_37_0._listeners[iter_37_0])
	end
end

function var_0_0.onCleanup(arg_38_0)
	var_0_0.super.onCleanup(arg_38_0)
	ClientView.getResourceUI():setVisible(true)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(var_0_9))
	lc.TextureCache:removeTextureForKey("res/jpg/union_battle_bg.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/dark_battle_bg.jpg")
	ClientData.unloadLCRes({
		"find.jpm",
		"find.png.sfb"
	})
end

function var_0_0.onBattleEnd(arg_39_0, arg_39_1)
	if arg_39_1:HasField("dark_duel_end_resp") then
		ClientView.getActiveIndicator():hide()

		local var_39_0 = {}
		local var_39_1 = arg_39_1.resource

		for iter_39_0, iter_39_1 in ipairs(var_39_1) do
			if iter_39_1.info_id ~= Data.PropsId.flag and (not (iter_39_1.info_id >= Data.PropsId.clash_chest) or not (iter_39_1.info_id <= Data.PropsId.clash_chest_end)) then
				table.insert(var_39_0, iter_39_1)
			end
		end

		if ClientView._findMatchPanel then
			ClientView._findMatchPanel:hide()
		end

		require("RewardPanel").create(var_39_0):show()
	else
		var_0_0.super:onBattleEnd(arg_39_1)
	end
end

function var_0_0.checkSurvivalBonus(arg_40_0)
	local var_40_0 = P._playerFindSurvival

	if var_40_0._rewards then
		arg_40_0:runAction(lc.sequence(0, function()
			require("SurvivalBonusPanel").create():show()
			var_40_0:clearBonus()
		end))
	end
end

function var_0_0.checkSurvivalExBonus(arg_42_0)
	local var_42_0 = P._playerFindSurvivalEx

	if var_42_0._rewards then
		arg_42_0:runAction(lc.sequence(0, function()
			require("SurvivalBonusPanel").create(true):show()
			var_42_0:clearBonus()
		end))
	end
end

function var_0_0.onOpponentNotFound(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0._contentArea

	if var_44_0 and var_44_0.onOpponentNotFound then
		var_44_0:onOpponentNotFound(arg_44_1)
	end
end

return var_0_0
