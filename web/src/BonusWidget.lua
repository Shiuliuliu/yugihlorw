local var_0_0 = class("BonusWidget", lc.ExtendUIWidget)
local var_0_1 = 220
local var_0_2 = 30
local var_0_3 = 30
local var_0_4 = 20
local var_0_5 = 140

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setContentSize(arg_1_0, var_0_1)
	var_1_0:init(arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:setBackGroundImage("img_com_bg_29", ccui.TextureResType.plistType)
	arg_2_0:setBackGroundImageScale9Enabled(true)
	arg_2_0:setBackGroundImageCapInsets(ClientView.CRECT_COM_BG29)

	local var_2_0 = lc.createSprite("img_bg_deco_29")

	var_2_0:setPosition(cc.p(lc.w(arg_2_0) - lc.w(var_2_0) / 2, lc.h(arg_2_0) / 2))
	arg_2_0:addProtectedChild(var_2_0)

	local var_2_1 = lc.createSprite("img_deco_bar_01")

	var_2_1:setPosition(lc.w(var_2_1) / 2, lc.h(arg_2_0) - lc.h(var_2_1) / 2 - var_0_4)
	arg_2_0:addProtectedChild(var_2_1)

	arg_2_0._titleBg = var_2_1

	local var_2_2 = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S1)

	var_2_2:setColor(ClientView.COLOR_TEXT_LIGHT)
	var_2_2:setPosition(0, lc.h(var_2_1) / 2)
	var_2_1:addChild(var_2_2)

	arg_2_0._title = var_2_2

	local var_2_3 = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_3:setColor(ClientView.COLOR_TEXT_TITLE_DESC)
	var_2_1:addChild(var_2_3)

	arg_2_0._desc = var_2_3

	if arg_2_1._id then
		local var_2_4 = ClientView.createTTF("", ClientView.FontSize.S2, ClientView.COLOR_TEXT_TITLE)

		var_2_4:setAnchorPoint(1, 0.5)
		lc.addChildToPos(var_2_1, var_2_4, cc.p(lc.w(var_2_1) - 60, lc.h(var_2_1) / 2))

		arg_2_0._time = var_2_4
	end

	arg_2_0:setBonus(arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.setBonus(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._bonus = arg_3_1

	local var_3_0 = arg_3_1.isDouble and arg_3_1:isDouble() or false
	local var_3_1 = arg_3_0._title

	var_3_1:setString(arg_3_2 or Str(arg_3_1._info._nameSid))
	var_3_1:setPositionX(40 + lc.w(var_3_1) / 2)

	local var_3_2 = arg_3_0._desc

	var_3_2:setString(arg_3_3 or "")
	var_3_2:setPosition(lc.right(var_3_1) + 28 + lc.w(var_3_2) / 2, lc.bottom(var_3_1) + lc.h(var_3_2) / 2)

	local var_3_3 = arg_3_0._time

	if var_3_3 then
		var_3_3:setString(ClientData.getTimeAgo(arg_3_1._timestamp))
	end

	ClientView.checkNewFlag(arg_3_0, 0)
	arg_3_0:removeAllChildren()

	arg_3_0._progBar = nil

	local var_3_4 = lc.bottom(arg_3_0._titleBg) - 14

	arg_3_0:addBonusItems(var_3_4)
	arg_3_0:addButton(var_3_4)

	if var_3_0 then
		local var_3_5 = lc.createSprite("img_icon_double")

		lc.addChildToPos(arg_3_0._button, var_3_5, cc.p(lc.w(arg_3_0._button) - lc.cw(var_3_5), lc.h(arg_3_0._button) - lc.ch(var_3_5)))
	end

	local var_3_6 = arg_3_1._info

	if var_3_6 then
		if var_3_6._type == Data.BonusType.grain or var_3_6._type == Data.BonusType.online or var_3_6._type == Data.BonusType.facebook then
			local var_3_7 = ClientView.createTTF("", ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

			var_3_7:setScale(0.8)
			var_3_7:setAnchorPoint(1, 1)
			lc.addChildToPos(arg_3_0, var_3_7, cc.p(lc.right(arg_3_0._button), lc.bottom(arg_3_0._button) - 20))

			arg_3_0._tip = var_3_7
		elseif var_3_6._val > 0 and arg_3_1.isChapter and not arg_3_1:isChapter() and not arg_3_1:isTeach() then
			local var_3_8 = ClientView.createLabelProgressBar(var_0_5)

			lc.addChildToPos(arg_3_0, var_3_8, cc.p(lc.w(arg_3_0) - var_0_5 / 2 - var_0_3 - 10, lc.bottom(arg_3_0._button) - 6 - lc.h(var_3_8) / 2))

			arg_3_0._progBar = var_3_8
		end
	end

	arg_3_0:updateView()
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0._listener = lc.addEventListener(Data.Event.bonus_dirty, function(arg_5_0)
		if arg_5_0._data == arg_4_0._bonus then
			arg_4_0:updateView()
		end
	end)

	arg_4_0:scheduleUpdateWithPriorityLua(function(arg_6_0)
		arg_4_0:onSchedule(arg_6_0)
	end, 0)
end

function var_0_0.onExit(arg_7_0)
	lc.Dispatcher:removeEventListener(arg_7_0._listener)
	arg_7_0:unscheduleUpdate()
end

function var_0_0.onSchedule(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._bonus._info

	if var_8_0 and var_8_0._type == Data.BonusType.online then
		arg_8_0:updateOnlineBonusTip()
	end
end

function var_0_0.updateOnlineBonusTip(arg_9_0)
	local var_9_0 = arg_9_0._bonus
	local var_9_1 = arg_9_0._bonus._info
	local var_9_2 = var_9_0:getPrevBonus()

	if var_9_2 == nil or var_9_2._isClaimed then
		if var_9_0._isClaimed or var_9_0:canClaim() then
			arg_9_0._tip:setString("")
		else
			local var_9_3 = math.ceil(var_9_1._val - var_9_0._value)

			if var_9_3 < 0 then
				var_9_3 = 0
			end

			arg_9_0._tip:setString(string.format(Str(STR.CLAIM_AFTER1), ClientData.formatPeriod(var_9_3)))
		end
	else
		local var_9_4 = var_9_1._val - (var_9_2 and var_9_2._info._val or 0)

		if var_9_4 < 0 then
			var_9_4 = 0
		end

		arg_9_0._tip:setString(string.format(Str(STR.CLAIM_AFTER2), ClientData.formatPeriod(var_9_4, 1)))
	end
end

function var_0_0.addBonusItems(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_0._bonus._info

	if var_10_1 then
		local var_10_2 = var_10_1._rid
		local var_10_3 = var_10_1._level
		local var_10_4 = var_10_1._count
		local var_10_5 = var_10_1._isFragment

		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			local var_10_6 = IconWidget.create({
				_infoId = iter_10_1,
				_level = var_10_3[iter_10_0],
				_isFragment = var_10_5[iter_10_0] > 0,
				_count = var_10_4[iter_10_0]
			})

			var_10_6._name:setColor(lc.Color3B.black)
			table.insert(var_10_0, var_10_6)
		end
	else
		for iter_10_2, iter_10_3 in ipairs(arg_10_0._bonus._extraBonus) do
			local var_10_7 = IconWidget.create(iter_10_3)

			var_10_7._name:setColor(lc.Color3B.black)
			table.insert(var_10_0, var_10_7)
		end
	end

	P:sortResultItems(var_10_0)

	local var_10_8 = var_0_2 + 20
	local var_10_9 = arg_10_1

	for iter_10_4, iter_10_5 in ipairs(var_10_0) do
		lc.addChildToPos(arg_10_0, iter_10_5, cc.p(var_10_8 + lc.w(iter_10_5) / 2, var_10_9 - lc.h(iter_10_5) / 2 + 4))

		var_10_8 = var_10_8 + lc.w(iter_10_5) + 10

		iter_10_5:checkHighlight()
	end
end

function var_0_0.addButton(arg_11_0, arg_11_1)
	local var_11_0 = ClientView.createStatusLabel(Str(STR.CLAIMED), ClientView.COLOR_TEXT_GREEN)

	lc.addChildToPos(arg_11_0, var_11_0, cc.p(lc.w(arg_11_0) - lc.w(var_11_0) / 2 - var_0_3 - 10, arg_11_1 - lc.h(var_11_0) / 2), 1)

	arg_11_0._claimedFlag = var_11_0

	local var_11_1 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_12_0)
		if arg_11_0._callback then
			arg_11_0._callback(arg_11_0._bonus)
		end

		local var_12_0 = GuideManager.getCurStepName()

		if var_12_0 == "claim task" or string.find(var_12_0, "goto task") then
			GuideManager.finishStepLater()
		end

		if arg_12_0._softGuideFinger then
			GuideManager.releaseFinger()
		end
	end, ClientView.CRECT_BUTTON_S, var_0_5)

	var_11_1:addLabel("")
	var_11_1:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(arg_11_0, var_11_1, cc.p(lc.w(arg_11_0) - var_0_5 / 2 - var_0_3 - 10, arg_11_1 - lc.h(var_11_1) / 2), 1)

	arg_11_0._button = var_11_1
end

function var_0_0.registerCallback(arg_13_0, arg_13_1)
	arg_13_0._callback = arg_13_1
end

function var_0_0.updateView(arg_14_0)
	local var_14_0 = arg_14_0._bonus
	local var_14_1 = arg_14_0._bonus._info
	local var_14_2 = var_14_0:canClaim()

	if arg_14_0._progBar then
		local var_14_3 = var_14_1._cid
		local var_14_4 = var_14_0._value
		local var_14_5 = var_14_1._val

		if var_14_3 == 205 or var_14_3 == 305 then
			var_14_4 = var_14_4 + 1
			var_14_5 = var_14_5 + 1
		end

		arg_14_0._progBar._bar:setPercent(var_14_4 * 100 / var_14_5)
		arg_14_0._progBar._bar:setColor(var_14_2 and lc.Color3B.green or lc.Color3B.white)

		local var_14_6 = var_14_0._info._type == Data.BonusType.gold_cost or var_14_0._info._type == Data.BonusType.gold_gain

		arg_14_0._progBar:setLabel(var_14_4, var_14_5, var_14_6)
		arg_14_0._progBar:setVisible(not var_14_0._isClaimed)
	end

	if arg_14_0._tip then
		if var_14_1._type == Data.BonusType.grain then
			local var_14_7 = var_14_0._info._cid % 100

			arg_14_0._tip:setString(string.format(Str(STR.GRAIN_TASK_TIP), Data.GRAIN_TIME[var_14_7][1], Data.GRAIN_TIME[var_14_7][2]))
		elseif var_14_1._type == Data.BonusType.online then
			arg_14_0:updateOnlineBonusTip()
		else
			arg_14_0._tip:setString("")
		end
	end

	local var_14_8 = arg_14_0._button

	if var_14_8 then
		var_14_8:setVisible(not var_14_0._isClaimed)
		arg_14_0._claimedFlag:setVisible(var_14_0._isClaimed)
		ClientView.checkNewFlag(arg_14_0, 0)

		if not var_14_0._isClaimed then
			var_14_8:setEnabled(true)

			if var_14_2 then
				if var_14_0._claimTimesMax then
					local var_14_9 = var_14_0._value - var_14_0._claimTimes

					var_14_8._label:setString(var_14_9 == 1 and Str(STR.CLAIM) or Str(STR.CLAIM_ALL))

					local var_14_10 = ClientView.checkNewFlag(arg_14_0, var_14_9, -32, -20, 1)

					if var_14_10 then
						var_14_10:setSpriteFrame("img_new_g")
					end
				else
					var_14_8._label:setString(Str(STR.CLAIM))
				end

				var_14_8:loadTextureNormal("img_btn_1_s", ccui.TextureResType.plistType)
			else
				local var_14_11 = var_14_1._cid

				if (var_14_11 ~= 101 or var_14_1._type == Data.BonusType.novice) and var_14_11 ~= 301 and var_14_11 ~= 302 and var_14_11 ~= 304 and var_14_11 ~= 401 and var_14_11 ~= 402 and var_14_11 ~= 404 and var_14_11 ~= Data.BonusCid.new_server_level and var_14_1._type ~= Data.BonusType.grain and var_14_1._type ~= Data.BonusType.online and var_14_1._type ~= Data.BonusType.fund_all and var_14_1._type ~= Data.BonusType.fund_level and var_14_1._type ~= Data.BonusType.invite and var_14_1._type ~= Data.BonusType.level and var_14_1._type ~= Data.BonusType.bottle and var_14_1._type ~= Data.BonusType.login_day and not Data.isPersonalFund(var_14_1._id) and (not (var_14_1._cid >= Data.BonusCid.channel_begin) or not (var_14_1._cid <= Data.BonusCid.channel_end)) then
					var_14_8._label:setString(Str(STR.GO))
					var_14_8:loadTextureNormal("img_btn_2_s", ccui.TextureResType.plistType)
				else
					local var_14_12 = false

					if var_14_1._type == Data.BonusType.level then
						local var_14_13 = var_14_0._info._cid - 2000

						if Data._characterInfo[var_14_13]._breakOut > 0 and P:isMaxLevel(var_14_13) and var_14_1._val > P:getMaxLevel(var_14_13) and not P:isCharBreakOut(var_14_13) then
							var_14_12 = true
							arg_14_0._charId = var_14_13
						end
					end

					arg_14_0._isShowBreakOut = var_14_12

					if var_14_12 then
						var_14_8:setEnabled(true)
						var_14_8:setSwallowTouches(false)
						var_14_8._label:setString(Str(STR.BREAK_OUT))
					else
						var_14_8:setEnabled(false)
						var_14_8:setSwallowTouches(false)
						var_14_8._label:setString(Str(STR.CLAIM))
					end
				end
			end

			var_14_8:setContentSize(cc.size(var_0_5, ClientView.CRECT_BUTTON_S.height))
		end
	end
end

function var_0_0.adjustPosition(arg_15_0, arg_15_1)
	if arg_15_1 then
		arg_15_0._button:setPositionY(var_0_1 / 2 + 15)
		arg_15_0._button:setContentSize(cc.size(var_0_5, 50))
		arg_15_0._button._label:setPositionY(25)
		arg_15_0._progBar:setPositionY(lc.ch(arg_15_0._progBar) + 15)
	end
end

return var_0_0
