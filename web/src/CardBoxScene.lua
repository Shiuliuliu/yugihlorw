local var_0_0 = require("CardList")
local var_0_1 = require("FilterWidget")
local var_0_2 = require("BaseUIScene")
local var_0_3 = require("CardOperatePanel")
local var_0_4 = class("CardBoxScene", var_0_2)
local var_0_5 = 0.6
local var_0_6 = 1
local var_0_7 = 1

function var_0_4.create(arg_1_0, arg_1_1)
	return lc.createScene(var_0_4, arg_1_0, arg_1_1)
end

function var_0_4.init(arg_2_0, arg_2_1, arg_2_2)
	if not var_0_4.super.init(arg_2_0, arg_2_1, STR.SID_FIXITY_NAME_1005, var_0_2.STYLE_TAB, true) then
		return false
	end

	arg_2_0:createFrame()
	arg_2_0:createCardList()
	ClientView.addVerticalTabButtons(arg_2_0, {
		Str(STR.MONSTER),
		Str(STR.MAGIC),
		Str(STR.TRAP),
		Str(STR.RARE) .. Str(STR.MONSTER)
	}, lc.top(arg_2_0._frame) - 80, lc.left(arg_2_0._frame) - 124, 480)

	arg_2_0._tabArea._focusTabIndex = arg_2_2 or Data.CardType.monster

	arg_2_0:syncData()

	return true
end

function var_0_4.onEnter(arg_3_0)
	var_0_4.super.onEnter(arg_3_0)

	arg_3_0._listeners = {}

	local var_3_0 = lc.addEventListener(Data.Event.card_list_dirty, function(arg_4_0)
		arg_3_0:updateView()
	end)

	table.insert(arg_3_0._listeners, var_3_0)
	arg_3_0:updateView()

	if ClientData._hasNewLotteryBook then
		arg_3_0:updateCardList()

		ClientData._hasNewLotteryBook = false
	end
end

function var_0_4.onExit(arg_5_0)
	var_0_4.super.onExit(arg_5_0)

	for iter_5_0 = 1, #arg_5_0._listeners do
		lc.Dispatcher:removeEventListener(arg_5_0._listeners[iter_5_0])
	end

	arg_5_0._listeners = {}
end

function var_0_4.syncData(arg_6_0)
	var_0_4.super.syncData(arg_6_0)
	arg_6_0:showTab(arg_6_0._tabArea._focusTabIndex)
	arg_6_0:updateView()

	if ClientData._hasNewLotteryBook then
		arg_6_0:updateCardList()

		ClientData._hasNewLotteryBook = false
	end
end

function var_0_4.createFrame(arg_7_0)
	local var_7_0 = ClientView.createFrameBox(cc.size(lc.w(arg_7_0) - (16 + ClientView.FRAME_TAB_WIDTH) * 2, lc.bottom(arg_7_0._titleArea)))

	lc.addChildToPos(arg_7_0, var_7_0, cc.p(lc.w(arg_7_0) / 2, lc.bottom(arg_7_0._titleArea) / 2))

	arg_7_0._frame = var_7_0
end

function var_0_4.createCardList(arg_8_0)
	local var_8_0 = 80

	arg_8_0._cardList = require("CardList").create(cc.size(lc.w(arg_8_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_8_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_8_0), 0.6, false)

	arg_8_0._cardList:setAnchorPoint(0.5, 0.5)
	arg_8_0._cardList:registerCardSelectedHandler(function(arg_9_0, arg_9_1)
		arg_8_0:onCardSelected(arg_9_0, arg_9_1)
	end)
	lc.addChildToPos(arg_8_0._frame, arg_8_0._cardList, cc.p(lc.w(arg_8_0._frame) / 2, var_8_0 / 2 + lc.h(arg_8_0._frame) / 2))

	local var_8_1 = (lc.w(arg_8_0._frame) - lc.w(arg_8_0._cardList)) / 2 + 16

	arg_8_0._cardList._pageLeft._pos = cc.p(-var_8_1, 8)
	arg_8_0._cardList._pageRight._pos = cc.p(lc.w(arg_8_0._cardList) + var_8_1, 8)

	local var_8_2 = var_8_1 + 32
	local var_8_3 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_8_0._frame, var_8_3, cc.p(-lc.w(var_8_3) / 2 + 12, 40), -1)

	arg_8_0._pageBg = var_8_3

	arg_8_0._cardList._pageLabel:setPosition(-var_8_2, -68)

	local var_8_4 = ClientView.createLineSprite("img_bottom_bg", lc.w(arg_8_0._cardList))

	var_8_4:setAnchorPoint(0.5, 0)
	lc.addChildToPos(arg_8_0._frame, var_8_4, cc.p(lc.w(arg_8_0._frame) / 2, ClientView.FRAME_INNER_BOTTOM - 12), -1)

	arg_8_0._bottomArea = var_8_4

	local var_8_5 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

	var_8_5:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_8_4, var_8_5, cc.p(20, lc.h(var_8_4) / 2))

	arg_8_0._info = var_8_5
end

function var_0_4.showTab(arg_10_0, arg_10_1)
	if arg_10_1 == var_0_4.TAB_TRANFER and P._level < Data._globalInfo._unlockSplit then
		ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockSplit))

		return
	end

	arg_10_0._tabArea:showTab(arg_10_1)
	arg_10_0:updateTabFlag()
	arg_10_0:updateTabContent()

	if arg_10_1 == var_0_4.TAB_MIX and GuideManager.getCurStepName() == "show tab mixbook" then
		GuideManager.finishStep()
	end

	return true
end

function var_0_4.updateTabContent(arg_11_0)
	local var_11_0 = arg_11_0._tabArea._focusTabIndex

	if arg_11_0._filterWidget then
		arg_11_0._filterWidget:removeFromParent()

		arg_11_0._filterWidget = nil
	end

	local var_11_1
	local var_11_2 = ""

	if var_11_0 == Data.CardType.monster or var_11_0 == Data.CardType.rare then
		var_11_1 = var_0_1.create(var_0_1.ModeType.monster, lc.h(arg_11_0._frame) - 80)

		var_11_1:resetAllFilter()

		var_11_2 = (var_11_0 == Data.CardType.rare and Str(STR.RARE) or "") .. Str(STR.MONSTER)
	elseif var_11_0 == Data.CardType.magic then
		var_11_1 = var_0_1.create(var_0_1.ModeType.magic, lc.h(arg_11_0._frame) - 80)

		var_11_1:resetAllFilter()

		var_11_2 = Str(STR.MAGIC)
	elseif var_11_0 == Data.CardType.trap then
		var_11_1 = var_0_1.create(var_0_1.ModeType.trap, lc.h(arg_11_0._frame) - 80)

		var_11_1:resetAllFilter()

		var_11_2 = Str(STR.TRAP)
	end

	if var_11_1 then
		arg_11_0._filterWidget = var_11_1

		arg_11_0._filterWidget:resetAllFilter()
		var_11_1:registerSortFilterHandler(function()
			arg_11_0:updateCardList()
		end)
		lc.addChildToPos(arg_11_0._frame, var_11_1, cc.p(lc.w(arg_11_0._frame) + ClientView.FRAME_TAB_WIDTH - lc.w(var_11_1) / 2 + 2, lc.h(var_11_1) / 2))
	end

	arg_11_0:updateCardList()
	arg_11_0._info:setString(var_11_2 .. ": " .. #arg_11_0._cardList._cards)
end

function var_0_4.updateCardList(arg_13_0)
	local var_13_0
	local var_13_1 = {}

	if arg_13_0._filterWidget then
		local var_13_2, var_13_3 = arg_13_0._filterWidget:getSortFunc()

		if var_13_2 then
			var_13_0 = {
				_func = var_13_2,
				_isReverse = not var_13_3
			}
		end

		local var_13_4, var_13_5 = arg_13_0._filterWidget:getFilterNatureFunc()

		if var_13_4 then
			var_13_1[var_0_0.FilterType.country] = {
				_func = var_13_4,
				_keyVal = var_13_5
			}
		end

		local var_13_6, var_13_7 = arg_13_0._filterWidget:getFilterCategoryFunc()

		if var_13_6 then
			var_13_1[var_0_0.FilterType.category] = {
				_func = var_13_6,
				_keyVal = var_13_7
			}
		end

		local var_13_8, var_13_9 = arg_13_0._filterWidget:getFilterLevelFunc()

		if var_13_8 then
			var_13_1[var_0_0.FilterType.cost] = {
				_func = var_13_8,
				_keyVal = var_13_9
			}
		end

		local var_13_10, var_13_11 = arg_13_0._filterWidget:getFilterQualityFunc()

		if var_13_10 then
			var_13_1[var_0_0.FilterType.quality] = {
				_func = var_13_10,
				_keyVal = var_13_11
			}
		end

		local var_13_12, var_13_13 = arg_13_0._filterWidget:getFilterMagicOptionFunc()

		if var_13_12 then
			var_13_1[var_0_0.FilterType.option] = {
				_func = var_13_12,
				_keyVal = var_13_13
			}
		end

		local var_13_14, var_13_15 = arg_13_0._filterWidget:getFilterTrapOptionFunc()

		if var_13_14 then
			var_13_1[var_0_0.FilterType.option] = {
				_func = var_13_14,
				_keyVal = var_13_15
			}
		end

		local var_13_16, var_13_17 = arg_13_0._filterWidget:getFilterSearchFunc()

		if var_13_16 then
			var_13_1[var_0_0.FilterType.search] = {
				_func = var_13_16,
				_keyVal = var_13_17
			}
		end
	end

	arg_13_0._cardList:init(arg_13_0._tabArea._focusTabIndex, excepts, var_13_0, var_13_1)
	arg_13_0._cardList:refresh(true)
end

function var_0_4.updateTabFlag(arg_14_0)
	return
end

function var_0_4.onCardSelected(arg_15_0, arg_15_1, arg_15_2)
	local CardInfoPanel = require("CardInfoPanel")
	local var_15_0 = CardInfoPanel.create(arg_15_1, P._playerCard._levels[arg_15_1] or 1, CardInfoPanel.OperateType.operate)
	local var_15_1 = (arg_15_0._cardList._curPage - 1) * arg_15_0._cardList._itemRow * arg_15_0._cardList._itemCol + (arg_15_2 or 1)
	var_15_0:setCardList(arg_15_0._cardList._cards, var_15_1, ClientData.getStrByCardType(Data.getType(arg_15_1)) .. Str(STR.CARD_LIST))
	var_15_0:show()
end

function var_0_4.onCardMix(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_2 = arg_16_2 or 1

	if ClientData.isMixable(arg_16_1._infoId) then
		local var_16_0 = arg_16_0._frameBottomArea._checkArea and arg_16_0._frameBottomArea._checkArea._isCheck or false

		if not arg_16_3 then
			require("PromptForm").ConfirmMix.create(arg_16_1, var_16_0, function(arg_17_0)
				arg_16_0:onCardMix(arg_16_1, arg_17_0, true)
			end, arg_16_1._type == Data.CardType.common_fragment):show()

			return
		end

		local var_16_1 = arg_16_0._cardList:getThumbnail(arg_16_1)
		local var_16_2 = Particle.create("par_card_mix")

		if var_16_1 then
			var_16_2:setPosition(arg_16_0:convertToNodeSpace(var_16_1:convertToWorldSpace(cc.p(lc.w(var_16_1) / 2, lc.h(var_16_1) / 2))))
		else
			var_16_2:setVisible(false)
		end

		arg_16_0:addChild(var_16_2, ClientData.ZOrder.effect)
		ClientView.getActiveIndicator():show()
		arg_16_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_16_2:getDuration()), cc.CallFunc:create(function()
			ClientView.getActiveIndicator():hide()

			local var_18_0, var_18_1 = P._playerCard:composeCard(arg_16_1._infoId, var_16_0)

			if var_18_0 == Data.ErrorType.ok and var_18_1 then
				ClientData.sendCardCompose(var_18_1._infoId, arg_16_2)
				var_16_2:stopSystem()
				var_16_2:removeFromParent()
				arg_16_0:updateTabFlag()

				if arg_16_1._type == Data.CardType.common_fragment then
					local var_18_2 = require("RewardPanel")

					var_18_2.create({
						{
							_infoId = arg_16_1._infoId,
							_count = arg_16_2
						}
					}, var_18_2.MODE_MIX_FRAGMENT):show()
				else
					if arg_16_1._type == Data.CardType.monster then
						local var_18_3 = cc.EventCustom:new(Data.Event.mix_hero)

						lc.Dispatcher:dispatchEvent(var_18_3)
					end

					require("RewardCardPanel").create(Str(STR.COMPOSE) .. Str(STR.SUCCESS), {
						var_18_1
					}):show()
				end
			end
		end)))
		lc.Audio.playAudio(AUDIO.E_CARD_MIX)
	else
		ToastManager.push(Str(STR.NEED_FRAGMENTS_MIX))
	end
end

function var_0_4.updateView(arg_19_0)
	return
end

function var_0_4.checkUnlockModule(arg_20_0)
	pcall(function()
		local var_20_0 = {}
		local var_20_1 = tonumber(P and P._level) or 1

		local unlockSplit = tonumber(Data._globalInfo and Data._globalInfo._unlockSplit)
		if unlockSplit then
			local prev = tonumber(lc.readConfig(ClientData.ConfigKey.lock_level_split, var_20_1)) or var_20_1
			if prev and prev < unlockSplit and var_20_1 >= unlockSplit then
				table.insert(var_20_0, #var_20_0 + 1, Str(STR.DECOMPOSE) .. Str(STR.UNLOCKED))
				lc.writeConfig(ClientData.ConfigKey.lock_level_split, var_20_1)
			end
		end

		if arg_20_0._sceneId == ClientData.SceneId.factory_monster then
			local var_20_2 = tonumber(lc.readConfig(ClientData.ConfigKey.lock_level_equip, var_20_1)) or var_20_1
			local var_20_3 = tonumber(P and P._playerCity and P._playerCity:getBlacksmithUnlockLevel())

			if var_20_2 and var_20_3 and var_20_2 < var_20_3 and var_20_3 <= var_20_1 then
				table.insert(var_20_0, #var_20_0 + 1, Str(STR.EQUIP) .. Str(STR.UNLOCKED))
				lc.writeConfig(ClientData.ConfigKey.lock_level_equip, var_20_1)
			end
		end

		if #var_20_0 > 0 then
			ToastManager.pushArray(var_20_0)
		end
	end)
end

function var_0_4.onGuide(arg_21_0, arg_21_1)
	local var_21_0 = GuideManager.getCurStepName()

	if var_21_0 == "leave heromansion" or var_21_0 == "leave blacksmith" or var_21_0 == "leave stable" or var_21_0 == "leave library" then
		GuideManager.setOperateLayer(arg_21_0._btnBack)
	elseif var_21_0 == "show card info" then
		GuideManager.setOperateLayer(arg_21_0._cardList:getItem(0)._thumbnail)
	elseif var_21_0 == "enter lottery book" then
		GuideManager.setOperateLayer(arg_21_0._btnLottery)
	elseif var_21_0 == "show tab mixbook" then
		GuideManager.setOperateLayer(arg_21_0._tabArea._tabs[var_0_4.TAB_MIX])
	else
		return
	end

	arg_21_1:stopPropagation()
end

return var_0_4