local var_0_0 = class("EliteForm", BaseForm)
local var_0_1 = cc.size(920, 640)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.COPY_ELITE))

	local var_2_0 = lc.createSprite("copy_main_bg")

	var_2_0:setScale(lc.w(arg_2_0._bg) / lc.w(var_2_0))
	lc.addChildToCenter(arg_2_0._bg, var_2_0)

	local var_2_1 = lc.w(arg_2_0._form) / 2
	local var_2_2 = lc.h(arg_2_0._form) / 2
	local var_2_3 = arg_2_0:createItem(1)

	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(var_2_1 - 200, var_2_2 + 140), 0, 1)

	local var_2_4 = arg_2_0:createItem(2)

	lc.addChildToPos(arg_2_0._form, var_2_4, cc.p(var_2_1 + 200, var_2_2 + 140), 0, 2)

	local var_2_5 = arg_2_0:createItem(3)

	lc.addChildToPos(arg_2_0._form, var_2_5, cc.p(var_2_1 - 200, var_2_2 - 140), 0, 3)

	local var_2_6 = arg_2_0:createItem(4)

	lc.addChildToPos(arg_2_0._form, var_2_6, cc.p(var_2_1 + 200, var_2_2 - 140), 0, 4)
	arg_2_0:checkTime()
end

function var_0_0.createItem(arg_3_0, arg_3_1)
	local var_3_0 = Data._copyInfo[(arg_3_1 - 1) * Data.COPY_LEVEL_COUNT + 1]
	local var_3_1 = ClientView.createScale9ShaderButton("img_com_bg_4", nil, ClientView.CRECT_COM_BG4, 380, 260)

	function var_3_1._callback()
		if var_3_1._isValid then
			require("SelectLevelForm").create(arg_3_1 + Data.CopyType.group_elite * 10):show()
		else
			ToastManager.push(Str(STR.COPY_INVALID_TIME))
		end
	end

	local var_3_2
	local var_3_3
	local var_3_4

	if arg_3_1 == Data.CardCountry.wei then
		var_3_2, var_3_3, var_3_4 = 11001, 11002, 11003
	elseif arg_3_1 == Data.CardCountry.shu then
		var_3_2, var_3_3, var_3_4 = 11004, 11005, 11006
	elseif arg_3_1 == Data.CardCountry.wu then
		var_3_2, var_3_3, var_3_4 = 11007, 11008, 11008
	elseif arg_3_1 == Data.CardCountry.qun then
		var_3_2, var_3_3, var_3_4 = 21001, 21002, 21001
	end

	local function var_3_5(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = cc.ShaderSprite:createWithFramename("card_frame_1_0")
		local var_5_1 = lc.w(var_5_0) / 2
		local var_5_2 = cc.ShaderSprite:createWithFramename(string.format("card_thu_%d", ClientData.getPicIdByInfoId(arg_5_1)))

		var_5_2:setScale(0.7)
		lc.addChildToPos(var_5_0, var_5_2, cc.p(var_5_1 + (arg_5_2 or 0), lc.h(var_5_2) / 2 - 80))

		function var_5_0.setGray(arg_6_0, arg_6_1)
			if arg_6_1 then
				var_5_0:setEffect(ClientView.SHADER_DISABLE)
				var_5_2:setEffect(ClientView.SHADER_DISABLE)
			else
				var_5_0:setEffect(nil)
				var_5_2:setEffect(nil)
			end
		end

		return var_5_0
	end

	local var_3_6 = var_3_5(arg_3_1, var_3_2)
	local var_3_7 = var_3_5(arg_3_1, var_3_3, -20)
	local var_3_8 = var_3_5(arg_3_1, var_3_4, 20)

	lc.addChildToPos(var_3_1, var_3_6, cc.p(lc.w(var_3_1) / 2, lc.h(var_3_6) / 2 + 20), 1)
	var_3_7:setScale(0.7)
	lc.addChildToPos(var_3_1, var_3_7, cc.p(lc.x(var_3_6) - 100, lc.y(var_3_6)))
	var_3_8:setScale(0.7)
	lc.addChildToPos(var_3_1, var_3_8, cc.p(lc.x(var_3_6) + 100, lc.y(var_3_6)))

	local var_3_9 = lc.createSprite({
		_name = "card_label_activate",
		_crect = cc.rect(34, 0, 1, 32),
		_size = cc.size(300, 32)
	})

	var_3_9:setColor(cc.c3b(160, 130, 100))
	lc.addChildToPos(var_3_1, var_3_9, cc.p(lc.w(var_3_1) / 2, lc.h(var_3_9) / 2 + 20), 1)

	var_3_1._timeBg = var_3_9
	var_3_1._center, var_3_1._left, var_3_1._right = var_3_6, var_3_7, var_3_8

	return var_3_1
end

function var_0_0.checkTime(arg_7_0)
	local var_7_0 = ClientData.getDayOfWeek()

	for iter_7_0 = 1, 4 do
		local var_7_1 = Data._copyInfo[(iter_7_0 - 1) * Data.COPY_LEVEL_COUNT + 1]
		local var_7_2

		for iter_7_1, iter_7_2 in ipairs(var_7_1._time) do
			if iter_7_2 == var_7_0 then
				var_7_2 = true

				break
			end
		end

		local var_7_3 = arg_7_0._form:getChildByTag(iter_7_0)

		var_7_3._center:setGray(not var_7_2)
		var_7_3._left:setGray(not var_7_2)
		var_7_3._right:setGray(not var_7_2)

		var_7_3._isValid = var_7_2

		arg_7_0:updateTimeAndTimes(iter_7_0)
	end
end

function var_0_0.updateTimeAndTimes(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._form:getChildByTag(arg_8_1)
	local var_8_1 = Data._copyInfo[(arg_8_1 - 1) * Data.COPY_LEVEL_COUNT + 1]
	local var_8_2 = var_8_0._timeBg

	var_8_2:removeAllChildren()

	local function var_8_3(arg_9_0)
		if arg_9_0 == 0 then
			return Str(STR.DAY_RI)
		else
			return Str(STR.NUM_1 + arg_9_0 - 1)
		end
	end

	local var_8_4 = var_8_3(var_8_1._time[1])

	for iter_8_0 = 2, #var_8_1._time do
		var_8_4 = var_8_4 .. Str(STR.COMMA_DUN) .. var_8_3(var_8_1._time[iter_8_0])
	end

	local var_8_5 = ClientView.createTTF(string.format(Str(STR.COPY_WEEK_TIME), var_8_4), ClientView.FontSize.S3)

	if var_8_0._isValid then
		local var_8_6 = ClientView.createTTF(string.format(Str(STR.BRACKETS_S), string.format("%d/%d", ClientData._player:getChallengeCopyRemainTimes(var_8_1._type), ClientData._player:getCopyTotalTimes(var_8_1._type))), ClientView.FontSize.S3, ClientView.COLOR_TEXT_GREEN)
		local var_8_7 = (lc.w(var_8_2) - (lc.w(var_8_5) + lc.w(var_8_6))) / 2

		lc.addChildToPos(var_8_2, var_8_5, cc.p(var_8_7 + lc.w(var_8_5) / 2, lc.h(var_8_2) / 2 + 2))
		lc.addChildToPos(var_8_2, var_8_6, cc.p(lc.right(var_8_5) + lc.w(var_8_6) / 2, lc.h(var_8_2) / 2 + 2))
	else
		lc.addChildToPos(var_8_2, var_8_5, cc.p(lc.w(var_8_2) / 2, lc.h(var_8_2) / 2 + 2))
	end
end

function var_0_0.onEnter(arg_10_0)
	var_0_0.super.onEnter(arg_10_0)

	arg_10_0._listener = lc.addEventListener(Data.Event.copy_times_dirty, function(arg_11_0)
		local var_11_0 = arg_11_0._param._type % 10

		arg_10_0:updateTimeAndTimes(var_11_0)
	end)
end

function var_0_0.onExit(arg_12_0)
	var_0_0.super.onExit(arg_12_0)
	lc.Dispatcher:removeEventListener(arg_12_0._listener)
end

function var_0_0.onShowActionFinished(arg_13_0)
	if not var_0_0._isShowFormTip then
		var_0_0._isShowFormTip = true

		arg_13_0:showFormTip(Str(STR.COPY_ELITE_GET), nil, -60)
	end
end

return var_0_0
