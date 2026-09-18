local var_0_0 = class("TeachingForm", BaseForm)
local var_0_1 = cc.size(1010, 700)
local var_0_2 = 60

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.GUIDANCE), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	arg_2_0._index = arg_2_1 or 10001

	arg_2_0._form:setTouchEnabled(false)
	arg_2_0:initData()

	local var_2_0 = {
		{
			_subIndex = 24,
			_isSub = true,
			_str = Str(STR.MID_TRANING_ELEMENT)
		},
		{
			_subIndex = 23,
			_isSub = true,
			_str = Str(STR.MID_TRANING_WARRIOR)
		},
		{
			_subIndex = 22,
			_isSub = true,
			_str = Str(STR.MID_TRANING_DRAGON)
		},
		{
			_subIndex = 21,
			_isSub = true,
			_str = Str(STR.MID_TRANING_MAGICIAN)
		}
	}
	local var_2_1 = {
		{
			_str = Str(STR.BASIC_TRAINING),
			_index = Data.TeachType.basic_teach
		},
		{
			_str = Str(STR.MID_TRAINING),
			_index = Data.TeachType.mid_teach,
			_tabs = var_2_0,
			checkValid = function()
				if P:getMaxCharacterLevel() < Data._globalInfo._unlockMidTeach then
					ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockMidTeach))

					return false
				end

				return true
			end
		},
		{
			_str = Str(STR.MASTER_TRAINING),
			_index = Data.TeachType.master_teach,
			checkValid = function()
				if P:getMaxCharacterLevel() < Data._globalInfo._unlockMasterTeach then
					ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockMasterTeach))

					return false
				end

				return true
			end
		},
		{
			_str = Str(STR.NEW_TRAINING),
			_index = Data.TeachType.new_teach,
			checkValid = function()
				if P:getMaxCharacterLevel() < Data._globalInfo._unlockNewTeach then
					ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockNewTeach))

					return false
				end

				return true
			end
		}
	}
	local var_2_2 = ClientView.createVerticalTabListArea(lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM, var_2_1, function(arg_6_0, arg_6_1, arg_6_2)
		arg_2_0:showTab(arg_6_0._index, not arg_6_1, arg_6_2)
	end)

	function var_2_2._subTabExpandCallback()
		arg_2_0:updateButtonFlags()
	end

	lc.addChildToPos(arg_2_0._frame, var_2_2, cc.p(ClientView.FRAME_INNER_LEFT + lc.w(var_2_2) / 2, lc.h(arg_2_0._frame) / 2), 0)

	arg_2_0._tabArea = var_2_2

	local var_2_3 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - lc.right(var_2_2) - ClientView.FRAME_INNER_RIGHT - 24, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_0_2 - 52), 10, 10)

	var_2_3:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0._frame, var_2_3, cc.p(lc.right(var_2_2) + 14 + lc.w(var_2_3) / 2, lc.h(arg_2_0._frame) / 2 - var_0_2))

	arg_2_0._list = var_2_3

	local var_2_4 = lc.createNode()

	lc.addChildToPos(arg_2_0._frame, var_2_4, cc.p((lc.w(arg_2_0._frame) + lc.right(var_2_2)) / 2 - 14, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - var_0_2))

	local var_2_5 = "bat_passed_bg"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_2_5 .. "_2")) then
		var_2_5 = var_2_5 .. "_2"
	end

	local var_2_6 = lc.createSprite(lc.formatJpg(var_2_5))

	var_2_4:addChild(var_2_6)

	local var_2_7 = ClientView.createTTF("", ClientView.FontSize.S1)

	var_2_7:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_2_4, var_2_7, cc.p(235, lc.h(var_2_4) / 2 - 10))

	arg_2_0._passLabel = var_2_7
end

function var_0_0.initData(arg_8_0)
	arg_8_0._teachInfos = {
		{},
		{},
		{},
		{}
	}

	for iter_8_0, iter_8_1 in pairs(Data._teachInfo) do
		local var_8_0 = math.floor(iter_8_1._id / Data.INFO_ID_GROUP_SIZE_LARGE)

		arg_8_0._teachInfos[var_8_0][#arg_8_0._teachInfos[var_8_0] + 1] = iter_8_1
	end
end

function var_0_0.onEnter(arg_9_0)
	var_0_0.super.onEnter(arg_9_0)

	local var_9_0 = math.floor(arg_9_0._index / Data.INFO_ID_GROUP_SIZE_LARGE)

	if var_9_0 ~= Data.TeachType.mid_teach then
		arg_9_0._tabArea:showTab(var_9_0, false)
	else
		local var_9_1 = Data.getTeachSubTypeIndex(arg_9_0._index)

		arg_9_0._tabArea:showTab(var_9_0, false)
		arg_9_0._tabArea:showTab(var_9_0 * 10 + var_9_1, false)
	end
end

function var_0_0.onExit(arg_10_0)
	var_0_0.super.onExit(arg_10_0)
end

function var_0_0.onCleanup(arg_11_0)
	var_0_0.super.onCleanup(arg_11_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/task_novice_top.jpg"))
end

function var_0_0.hide(arg_12_0, arg_12_1)
	var_0_0.super.hide(arg_12_0, arg_12_1)

	if GuideManager.getCurStepName() == "close task" then
		GuideManager.finishStep()
	end
end

function var_0_0.showTab(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_2 then
		return
	end

	arg_13_0._focusTabIndex = arg_13_1

	if arg_13_1 < 10 then
		arg_13_0:updatePassed(arg_13_1)
	else
		arg_13_0:updatePassed(math.floor(arg_13_1 / 10), arg_13_1 % 10)
	end

	arg_13_0:refreshList()

	if GuideManager.isGuideEnabled() and arg_13_3 then
		GuideManager.finishStepLater()
	end
end

function var_0_0.updatePassed(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = #arg_14_0:getTeachInfos(arg_14_1, arg_14_2)
	local var_14_1 = arg_14_0:getTeachPassed(arg_14_1, arg_14_2)
	local var_14_2 = string.format(var_14_1 .. "/" .. var_14_0)

	arg_14_0._passLabel:setString(var_14_2)
end

function var_0_0.getTeachInfos(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 == nil then
		return arg_15_0._teachInfos[arg_15_1]
	end

	local var_15_0 = {}

	for iter_15_0 = 1, #arg_15_0._teachInfos[arg_15_1] do
		local var_15_1 = arg_15_0._teachInfos[arg_15_1][iter_15_0]

		if Data.getTeachSubTypeIndex(var_15_1._id) == arg_15_2 then
			var_15_0[#var_15_0 + 1] = var_15_1
		end
	end

	return var_15_0
end

function var_0_0.getTeachPassed(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_0._teachInfos[arg_16_1]) do
		local var_16_1 = P._playerBonus._bonusTeach[iter_16_1._bonusId]

		if (arg_16_2 == nil or Data.getTeachSubTypeIndex(iter_16_1._id) == arg_16_2) and var_16_1 ~= nil and arg_16_0:isTeachComplete(var_16_1) then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_0.isTeachComplete(arg_17_0, arg_17_1)
	return arg_17_1._isClaimed or arg_17_1._isClaimed == false and arg_17_1:canClaim()
end

function var_0_0.refreshList(arg_18_0)
	local var_18_0 = arg_18_0._list

	if arg_18_0._topBar then
		arg_18_0._topBar:removeFromParent()

		arg_18_0._topBar = nil
	end

	local function var_18_1(arg_19_0, arg_19_1)
		local var_19_0 = P._playerBonus._bonusTeach[arg_19_0._bonusId]
		local var_19_1 = P._playerBonus._bonusTeach[arg_19_1._bonusId]

		if var_19_0._isClaimed and not var_19_1._isClaimed then
			return false
		elseif not var_19_0._isClaimed and var_19_1._isClaimed then
			return true
		else
			return arg_19_0._id < arg_19_1._id
		end
	end

	for iter_18_0 = Data.TeachType.basic_teach, Data.TeachType.count do
		table.sort(arg_18_0._teachInfos[iter_18_0], var_18_1)
	end

	var_18_0:gotoTop()

	local var_18_2

	if arg_18_0._focusTabIndex < 10 then
		var_18_2 = arg_18_0:getTeachInfos(arg_18_0._focusTabIndex)
	else
		var_18_2 = arg_18_0:getTeachInfos(math.floor(arg_18_0._focusTabIndex / 10), arg_18_0._focusTabIndex % 10)
	end

	var_18_0:bindData(var_18_2, function(arg_20_0, arg_20_1)
		arg_18_0:setOrCreateItem(arg_20_0, arg_20_1)
	end, math.min(5, #var_18_2))

	for iter_18_1 = 1, var_18_0._cacheCount do
		var_18_0:pushBackCustomItem(arg_18_0:setOrCreateItem(nil, var_18_2[iter_18_1]))
	end

	var_18_0:checkEmpty(Str(STR.LIST_EMPTY_NO_TRAINING))
	arg_18_0:updateButtonFlags()
end

function var_0_0.setOrCreateItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = P._playerBonus._bonusTeach[arg_21_2._bonusId]
	local var_21_1 = math.floor(arg_21_2._id / 10000)
	local var_21_2

	if var_21_1 ~= Data.TeachType.mid_teach then
		var_21_2 = string.format("%d-%d ", var_21_1, arg_21_2._id % 100) .. Str(arg_21_2._titleSid)
	else
		local var_21_3 = Data.getTeachSubTypeIndex(arg_21_2._id)
		local var_21_4 = arg_21_2._id % 10000 < 100 and arg_21_2._id % 100 - (var_21_3 - 1) * 8 or arg_21_2._id % 100

		var_21_2 = string.format("%d-%d-%d ", var_21_1, var_21_3, var_21_4) .. Str(arg_21_2._titleSid)
	end

	local var_21_5 = Str(arg_21_2._briefSid)

	if arg_21_1 == nil then
		arg_21_1 = require("BonusWidget").create(lc.w(arg_21_0._list), var_21_0, var_21_2, var_21_5)
	else
		arg_21_1:setBonus(var_21_0, var_21_2, var_21_5)
	end

	arg_21_1:registerCallback(function(arg_22_0)
		arg_21_0:dealTeachTask(arg_21_2, arg_22_0)
	end)

	if var_21_0._value >= var_21_0._info._val then
		if var_21_0._isClaimed then
			arg_21_1._button:setVisible(true)
			arg_21_1._button._label:setString(Str(STR.BATTLE_AGAIN))
		end

		arg_21_1._claimedFlag:setSpriteFrame("passed_bg")
		arg_21_1._claimedFlag:setColor(lc.Color3B.white)
		arg_21_1._claimedFlag:setPositionY(120)
		arg_21_1._claimedFlag:setVisible(true)
		arg_21_1._claimedFlag._label:setVisible(false)
	elseif var_21_0._value < var_21_0._info._val then
		arg_21_1._button._label:setString(Str(STR.CAPTURE))
	end

	arg_21_1._button:setPositionY(64)
	arg_21_1._button:setEnabled(arg_21_0:isLastTeachPass(arg_21_2))
	arg_21_1._button:setVisible(true)

	return arg_21_1
end

function var_0_0.dealTeachTask(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2._value >= arg_23_2._info._val and not arg_23_2._isClaimed then
		local var_23_0 = ClientData.claimBonus(arg_23_2)

		arg_23_0:refreshList()
		ClientView.showClaimBonusResult(arg_23_2, var_23_0)

		return
	end

	local var_23_1 = ClientData.genInputFromUnitTest()

	var_23_1._ygo = arg_23_1._id
	var_23_1._battleType = Data.BattleType.teach
	var_23_1._conditionIds = arg_23_1._condition
	var_23_1._conditionValues = arg_23_1._value
	var_23_1._teachingId = arg_23_1._id

	lc.replaceScene(require("ResSwitchScene").create(lc._runningScene._sceneId, ClientData.SceneId.battle, var_23_1))
	arg_23_0:hide(true)
end

function var_0_0.isLastTeachPass(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1._passId[1]

	if var_24_0 == 0 then
		return true
	end

	local var_24_1 = Data._teachInfo[var_24_0]
	local var_24_2 = P._playerBonus._bonusTeach[var_24_1._bonusId]

	return var_24_2._value >= var_24_2._info._val
end

function var_0_0.updateButtonFlags(arg_25_0)
	local var_25_0 = arg_25_0._tabArea._list:getItems()

	for iter_25_0 = 1, #var_25_0 do
		local var_25_1 = var_25_0[iter_25_0]

		if var_25_1._index < 10 then
			local var_25_2 = ClientData.getUnpassTeachCount(var_25_1._index)
			local var_25_3 = ClientView.checkNewFlag(arg_25_0._tabArea._list:getItems()[iter_25_0], var_25_2, -20, -4)

			if var_25_3 ~= nil then
				var_25_3:setSpriteFrame("img_new_g")
			end
		else
			local var_25_4 = ClientData.getUnpassTeachCount(math.floor(var_25_1._index / 10), var_25_1._index % 10)
			local var_25_5 = ClientView.checkNewFlag(arg_25_0._tabArea._list:getItems()[iter_25_0], var_25_4, -10, -4)

			if var_25_5 ~= nil then
				var_25_5:setSpriteFrame("img_new_g")
			end
		end
	end
end

return var_0_0
