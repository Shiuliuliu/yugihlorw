local var_0_0 = class("RewardPanel", require("BasePanel"))
local var_0_1 = 8
local var_0_2 = 140
local var_0_3 = 16

var_0_0.MODE_CHEST = 1
var_0_0.MODE_SPLIT = 2
var_0_0.MODE_CLAIM = 3
var_0_0.MODE_MIX_FRAGMENT = 4
var_0_0.MODE_CLAIM_ALL = 5
var_0_0.MODE_BUY = 6
var_0_0.MODE_LOTTERY = 7
var_0_0.MODE_UNION_CONTRIBUTE = 8
var_0_0.MODE_EXCHANGE = 9

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)
	local var_1_1 = {}

	if arg_1_1 == var_0_0.MODE_CLAIM then
		if arg_1_0._info then
			local var_1_2 = arg_1_0._info._rid
			local var_1_3 = arg_1_0._info._level
			local var_1_4 = arg_1_0._info._count
			local var_1_5 = arg_1_0._info._isFragment

			for iter_1_0 = 1, #var_1_2 do
				local var_1_6 = {
					_infoId = var_1_2[iter_1_0],
					_count = var_1_4[iter_1_0] * (arg_1_0._multiple or 1),
					_isFragment = var_1_5[iter_1_0] > 0,
					_level = var_1_3[iter_1_0]
				}

				table.insert(var_1_1, var_1_6)
			end

			var_0_0.tryAddBonusExtra(arg_1_0._info._id, var_1_1)
		else
			var_1_1 = arg_1_0._extraBonus
		end
	elseif arg_1_1 == var_0_0.MODE_CLAIM_ALL then
		var_1_1 = arg_1_0
	elseif arg_1_1 == var_0_0.MODE_SPLIT then
		var_1_1 = arg_1_0
	elseif arg_1_1 == var_0_0.MODE_MIX_FRAGMENT then
		var_1_1 = arg_1_0
	elseif arg_1_1 == var_0_0.MODE_UNION_CONTRIBUTE then
		var_1_1 = arg_1_0
	else
		for iter_1_1 = 1, #arg_1_0 do
			local var_1_7 = {
				_infoId = arg_1_0[iter_1_1].info_id or arg_1_0[iter_1_1]._infoId,
				_count = arg_1_0[iter_1_1].num or arg_1_0[iter_1_1].count or arg_1_0[iter_1_1]._num or arg_1_0[iter_1_1]._count,
				_isFragment = arg_1_0[iter_1_1].is_fragment or false,
				_level = arg_1_0[iter_1_1].level or 1
			}

			table.insert(var_1_1, var_1_7)
		end

		if arg_1_0._resMap then
			for iter_1_2, iter_1_3 in pairs(arg_1_0._resMap) do
				local var_1_8 = {
					_level = 1,
					_isFragment = false,
					_infoId = iter_1_2,
					_count = iter_1_3
				}

				table.insert(var_1_1, var_1_8)
			end
		end

		if arg_1_1 ~= var_0_0.MODE_EXCHANGE then
			local var_1_9 = P._characters[P:getCharacterId()]
			local var_1_10 = var_1_9._level

			P:addResourcesData(var_1_1)

			local var_1_11 = var_1_9._level

			if var_1_10 < var_1_11 then
				require("LevelUpPanel").createLord(var_1_10, var_1_11):show()
			end
		end
	end

	P:sortResultItems(var_1_1)

	var_1_0._bonuses = var_1_1

	var_1_0:init(arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._mode = arg_2_1

	local var_2_0 = lc.createSprite({
		_name = "img_reward_bg",
		_crect = cc.rect(0, 60, 196, 216),
		_size = cc.size(1300, 336)
	})

	var_2_0:setAnchorPoint(0.5, 0)
	lc.addChildToCenter(arg_2_0, var_2_0)

	local var_2_1 = cc.DragonBonesNode:createWithDecrypt("res/effects/lingjiang.lcres", "lingjiang", "lingjiang")

	var_2_1:gotoAndPlay(arg_2_1 == var_0_0.MODE_BUY and "effect3" or arg_2_1 == var_0_0.MODE_SPLIT and "effect5" or "effect")
	lc.addChildToCenter(arg_2_0, var_2_1)
	var_2_1:runAction(lc.sequence(var_2_1:getAnimationDuration(arg_2_1 == var_0_0.MODE_BUY and "effect3" or arg_2_1 == var_0_0.MODE_SPLIT and "effect5" or "effect"), function()
		var_2_1:gotoAndPlay(arg_2_1 == var_0_0.MODE_BUY and "effect4" or arg_2_1 == var_0_0.MODE_SPLIT and "effect6" or "effect2")
	end))

	local var_2_2 = arg_2_0._bonuses
	local var_2_3 = lc.List.createV(cc.size(), 10, 10)

	arg_2_0:addChild(var_2_3)

	local var_2_4 = 0
	local var_2_5 = 0
	local var_2_6 = 0
	local var_2_7 = ccui.Widget:create()
	local var_2_8 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		if iter_2_1._infoId == Data.ResType.clash_trophy or iter_2_1._infoId == Data.ResType.ladder_trophy or iter_2_1._infoId == Data.ResType.union_battle_trophy or iter_2_1._infoId == Data.ResType.dark_trophy then
			ToastManager.push(ClientData.getNameByInfoId(iter_2_1._infoId) .. " " .. (iter_2_1._count > 0 and "+" or "") .. iter_2_1._count)
		elseif var_2_7:getChildrenCount() == var_0_1 then
			var_2_7:setContentSize(var_2_5 - var_0_3, var_2_6)
			var_2_3:pushBackCustomItem(var_2_7)

			var_2_4 = math.max(lc.w(var_2_7), var_2_4)
			var_2_5, var_2_6 = 0, 0
			var_2_7 = ccui.Widget:create()
		end

		if iter_2_1._count > 0 then
			local var_2_9 = IconWidget.create(iter_2_1)

			var_2_9:setAnchorPoint(0, 0)
			var_2_9:setPosition(var_2_5, 0)
			var_2_9:setVisible(false)
			var_2_9:runAction(lc.sequence(0.3 + iter_2_0 * 0.2, function()
				var_2_9:setVisible(true)
			end, lc.scaleTo(0.1, 1.2), lc.scaleTo(0.1, 1)))
			var_2_7:addChild(var_2_9)

			var_2_5 = var_2_5 + lc.w(var_2_9) + var_0_3
			var_2_6 = math.max(var_2_6, lc.h(var_2_9))
		end

		if Data.hasBigCard(iter_2_1._infoId) and iter_2_1._count > 0 then
			table.insert(var_2_8, {
				_infoId = iter_2_1._infoId,
				_num = iter_2_1._count
			})
		end
	end

	if var_2_7:getChildrenCount() > 0 then
		var_2_7:setContentSize(var_2_5 - var_0_3, var_2_6)
		var_2_3:pushBackCustomItem(var_2_7)

		var_2_4 = math.max(lc.w(var_2_7), var_2_4)
	end

	var_2_3:refreshView()

	local var_2_10 = lc.Director:getVisibleSize().height - var_0_2
	local var_2_11 = math.min(300, var_2_3:getInnerContainerSize().height)

	var_2_0:setContentSize(lc.w(var_2_0), var_2_11 + 220)
	lc.offset(var_2_1, 0, var_2_11 - var_0_2)
	var_2_3:setAnchorPoint(0.5, 0)
	var_2_3:setContentSize(var_2_4 + 60, var_2_11)
	var_2_3:setPosition(lc.w(arg_2_0) / 2, lc.bottom(var_2_0) + 40)

	arg_2_0._item = var_2_7

	arg_2_0:addBackButton()

	if #var_2_8 > 0 then
		arg_2_0._bigCards = var_2_8
	end

	lc.Audio.playAudio(AUDIO.E_CLAIM)
end

function var_0_0.onEnter(arg_5_0)
	var_0_0.super.onEnter(arg_5_0)

	arg_5_0._listener = lc.addEventListener(GuideManager.Event.seek, function(arg_6_0)
		arg_5_0:onGuide(arg_6_0)
	end)

	if arg_5_0._bigCards then
		require("RewardCardPanel").create(Str(STR.GET) .. Str(STR.CARD), arg_5_0._bigCards):show()
	end
end

function var_0_0.onExit(arg_7_0)
	var_0_0.super.onExit(arg_7_0)

	if arg_7_0._exitFunc then
		arg_7_0._exitFunc()
	end

	lc.Dispatcher:removeEventListener(arg_7_0._listener)
end

function var_0_0.onCleanup(arg_8_0)
	var_0_0.super.onCleanup(arg_8_0)

	local var_8_0 = arg_8_0._mode
	local var_8_1
	local var_8_2 = (var_8_0 == var_0_0.MODE_CHEST or var_8_0 == var_0_0.MODE_LOTTERY) and "res/jpg/img_word_open_box.jpg" or var_8_0 == var_0_0.MODE_SPLIT and "res/jpg/img_word_split_card.jpg" or var_8_0 == var_0_0.MODE_MIX_FRAGMENT and "res/jpg/img_word_mix_frag.jpg" or var_8_0 == var_0_0.MODE_BUY and "res/jpg/img_word_buy_success.jpg" or "res/jpg/img_word_claim_reward.jpg"

	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(var_8_2))
end

function var_0_0.hide(arg_9_0)
	var_0_0.super.hide(arg_9_0)

	if GuideManager.getCurStepName() == "leave claim 2" then
		GuideManager.finishStep()
	end
end

function var_0_0.onGuide(arg_10_0, arg_10_1)
	if GuideManager.getCurStepName() == "leave claim 2" then
		GuideManager.setOperateLayer(arg_10_0._btnBack, nil, {
			arg_10_0
		})
	else
		return
	end

	arg_10_1:stopPropagation()
end

function var_0_0.tryAddBonusExtra(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = ClientData.getValidActivityByTypeAndParam(525, arg_11_0)

	if var_11_0 == nil then
		return
	end

	local var_11_2 = var_11_0._bonusId[var_11_1]
	local var_11_3 = Data._bonusInfo[var_11_2]

	if var_11_3 == nil then
		return
	end

	local var_11_4 = var_11_3._rid
	local var_11_5 = var_11_3._level
	local var_11_6 = var_11_3._count
	local var_11_7 = var_11_3._isFragment

	for iter_11_0 = 1, #var_11_4 do
		local var_11_8

		for iter_11_1 = 1, #arg_11_1 do
			if arg_11_1[iter_11_1]._infoId == var_11_4[iter_11_0] then
				var_11_8 = arg_11_1[iter_11_1]

				break
			end
		end

		if var_11_8 ~= nil then
			var_11_8._count = var_11_8._count + var_11_6[iter_11_0]
		else
			local var_11_9 = {
				_infoId = var_11_4[iter_11_0],
				_count = var_11_6[iter_11_0],
				_isFragment = var_11_7[iter_11_0] > 0,
				_level = var_11_5[iter_11_0]
			}

			table.insert(arg_11_1, var_11_9)
		end
	end
end

return var_0_0
