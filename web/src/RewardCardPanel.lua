local var_0_0 = class("RewardCardPanel", require("BasePanel"))
local var_0_1 = require("CardThumbnail")
local var_0_2 = require("CardInfoPanel")
local var_0_3 = 255

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super.init(arg_2_0, true)

	if GuideManager.getCurStepName() == "evolve card" then
		GuideManager.startStepLater(0.3)
	end

	local var_2_0 = {}

	if #arg_2_2 >= 8 then
		local var_2_1 = lc.List.createH(cc.size(lc.w(arg_2_0), 400), 10 + ClientView.SCR_EDGE, 10)

		var_2_1:setAnchorPoint(0.5, 0.5)
		lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.cw(arg_2_0), lc.ch(arg_2_0) + 60))

		arg_2_0._list = var_2_1

		for iter_2_0 = 1, #arg_2_2 do
			local var_2_2 = var_0_1.createFromPool(arg_2_2[iter_2_0]._infoId, itemScale)

			var_2_2._thumbnail:setTouchEnabled(true)
			var_2_2._thumbnail:addTouchEventListener(function(arg_3_0, arg_3_1)
				if arg_3_1 == ccui.TouchEventType.ended then
					var_0_2.create(var_2_2._thumbnail._infoId, nil, var_0_2.OperateType.na):show()
				end
			end)
			table.insert(var_2_0, var_2_2._thumbnail)

			local var_2_3 = ccui.Layout:create()

			var_2_3:setContentSize(ClientView.CARD_SIZE)
			lc.addChildToCenter(var_2_3, var_2_2)
			var_2_1:pushBackCustomItem(var_2_3)
		end

		local var_2_4 = arg_2_0:createBackButton(180)

		lc.addChildToPos(arg_2_0, var_2_4, cc.p(lc.w(arg_2_0) / 2, 50 + lc.h(var_2_4) / 2))
	else
		local var_2_5 = 40
		local var_2_6 = ClientView.CARD_SIZE.width
		local var_2_7 = 1
		local var_2_8 = #arg_2_2

		if #arg_2_2 > 5 then
			var_2_7 = 2
			var_2_8 = math.ceil(#arg_2_2 / 2)
		end

		local var_2_9 = math.min((1024 - var_2_8 * var_2_5) / #arg_2_2, var_2_6)
		local var_2_10 = (var_2_9 + var_2_5) * var_2_8
		local var_2_11 = lc.h(arg_2_0) / 2 + 70

		if var_2_7 == 2 then
			var_2_11 = lc.h(arg_2_0) / 2 + 170
		end

		local var_2_12 = cc.p((lc.w(arg_2_0) - var_2_10 + var_2_9 + var_2_5) / 2, var_2_11)

		for iter_2_1, iter_2_2 in ipairs(arg_2_2) do
			local var_2_13 = var_0_1.createFromPool(iter_2_2._infoId, var_2_9 / var_2_6)

			lc.offset(var_2_13._countArea, 0, -80)
			lc.addChildToPos(arg_2_0, var_2_13, var_2_12, 1)
			table.insert(var_2_0, var_2_13._thumbnail)

			var_2_12.x = var_2_12.x + var_2_9 + var_2_5

			if #var_2_0 == var_2_8 then
				var_2_12.x = (lc.w(arg_2_0) - var_2_10 + var_2_9 + var_2_5) / 2
				var_2_12.y = var_2_12.y - ClientView.CARD_SIZE.height * var_2_9 / var_2_6 - var_2_5 + 20
			end

			var_2_13._thumbnail:setTouchEnabled(true)
			var_2_13._thumbnail:addTouchEventListener(function(arg_4_0, arg_4_1)
				if arg_4_1 == ccui.TouchEventType.ended then
					for iter_4_0 = 1, #lc._runningScene._scene:getChildren() do
						if lc._runningScene._scene:getChildren()[iter_4_0]._panelName == "CardInfoPanel" then
							return
						end
					end

					if GuideManager.isGuideEnabled() then
						GuideManager.pauseGuide()
					end

					if Data.getType(var_2_13._thumbnail._infoId) == Data.CardType.common_fragment then
						require("DescForm").create(var_2_13._thumbnail._infoId):show()
					else
						var_0_2.create(var_2_13._thumbnail._infoId, nil, var_0_2.OperateType.na):show()
					end
				end
			end)
		end

		local var_2_14 = arg_2_0:createBackButton(180)

		lc.addChildToPos(arg_2_0, var_2_14, cc.p(lc.w(arg_2_0) / 2, 20 + lc.h(var_2_14) / 2))
	end

	if arg_2_1 then
		local var_2_15 = lc.createSprite("img_title_bg")

		var_2_15:setScale(600 / lc.w(var_2_15), 1)
		lc.addChildToPos(arg_2_0, var_2_15, cc.p(lc.w(arg_2_0) / 2, lc.h(arg_2_0) - 50))

		local var_2_16 = ClientView.createTTF(arg_2_1, ClientView.FontSize.S1, lc.Color3B.yellow)

		lc.addChildToPos(arg_2_0, var_2_16, cc.p(lc.x(var_2_15), lc.y(var_2_15)))
	end

	arg_2_0._thumbnails = var_2_0

	lc.Audio.playAudio(AUDIO.E_CARD_GET)
end

function var_0_0.show(arg_5_0, arg_5_1)
	var_0_0.super.show(arg_5_0, arg_5_1)

	if #arg_5_0._thumbnails < 8 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._thumbnails) do
			arg_5_0:showEffect(iter_5_1)
		end
	end
end

function var_0_0.onEnter(arg_6_0)
	var_0_0.super.onEnter(arg_6_0)

	arg_6_0._listener = lc.addEventListener(GuideManager.Event.seek, function(arg_7_0)
		arg_6_0:onGuide(arg_7_0)
	end)
end

function var_0_0.onExit(arg_8_0)
	var_0_0.super.onExit(arg_8_0)
	lc.Dispatcher:removeEventListener(arg_8_0._listener)
end

function var_0_0.onCleanup(arg_9_0)
	var_0_0.super.onCleanup(arg_9_0)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._thumbnails) do
		var_0_1.releaseToPool(iter_9_1._item)
	end
end

function var_0_0.createBackButton(arg_10_0, arg_10_1)
	local var_10_0 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_11_0)
		arg_10_0:hide()
		GuideManager.finishStep()
	end, ClientView.CRECT_BUTTON, arg_10_1)

	var_10_0:addLabel(Str(STR.BACK))

	arg_10_0._btnBack = var_10_0

	return var_10_0
end

function var_0_0.showEffect(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2

	if var_12_0 == nil then
		var_12_0 = 0
	end

	local var_12_1 = arg_12_0:convertToNodeSpace(arg_12_1:convertToWorldSpace(cc.p(lc.w(arg_12_1) / 2, lc.h(arg_12_1) / 2)))
	local var_12_2
	local var_12_3
	local var_12_4
	local var_12_5 = Data.getInfo(arg_12_1._infoId)

	if var_12_5._quality >= Data.CardQuality.R then
		arg_12_1:setVisible(false)

		var_12_2 = Particle.create("par_reward1")
		var_12_3 = Particle.create("par_reward2")

		var_12_2:setTag(var_0_3)
		var_12_3:setTag(var_0_3)
		var_12_2:setPosition(var_12_1)
		var_12_3:setPosition(var_12_1)
		var_12_2:setScale(arg_12_1._scale * 1.3)
		var_12_3:setScale(arg_12_1._scale * 1.3)
		arg_12_0:addChild(var_12_2, 2)
		arg_12_0:addChild(var_12_3, 2)
		var_12_2:stopSystem()
		var_12_3:stopSystem()

		if var_12_5._quality == Data.CardQuality.UR then
			var_12_4 = Particle.create("par_hk")
		elseif var_12_5._quality == Data.CardQuality.SR then
			var_12_4 = Particle.create("par_zk")
		end

		if var_12_4 then
			var_12_4:setTag(var_0_3)
			var_12_4:setPosition(var_12_1)
			var_12_4:setScale(arg_12_1._scale * 1.3)
			arg_12_0:addChild(var_12_4)
			var_12_4:stopSystem()
		end

		arg_12_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_12_0 + 0.1), cc.CallFunc:create(function()
			if var_12_2 then
				var_12_2:resetSystem()
				var_12_2:runAction(cc.Sequence:create(cc.DelayTime:create(var_12_2:getDuration()), cc.CallFunc:create(function()
					var_12_3:resetSystem()
				end), cc.DelayTime:create(var_12_3:getDuration())))
			end
		end), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			arg_12_1:setVisible(true)

			if var_12_4 then
				var_12_4:resetSystem()
			end
		end)))
	else
		arg_12_1:setVisible(true)
	end
end

function var_0_0.onGuide(arg_16_0, arg_16_1)
	local var_16_0 = GuideManager.getCurStepName()

	if var_16_0 == "show card info" then
		GuideManager.setOperateLayer(arg_16_0._thumbnails[1])
	elseif var_16_0 == "leave card reward" then
		GuideManager.setOperateLayer(arg_16_0._btnBack, nil, {
			arg_16_0._list
		})
	elseif var_16_0 == "show tap card tip" then
		local var_16_1 = lc.createImageView({
			_name = "img_com_bg_11",
			_crect = ClientView.CRECT_COM_BG11,
			_size = cc.size(600, 66)
		})

		lc.addChildToPos(arg_16_0, var_16_1, cc.p(lc.w(arg_16_0) / 2, 180))

		local var_16_2 = ClientView.createBoldRichText(Str(STR.TAP_CARD_TIP), ClientView.RICHTEXT_PARAM_LIGHT_S1)

		lc.addChildToPos(var_16_1, var_16_2, cc.p(lc.w(var_16_1) / 2, lc.h(var_16_1) / 2 + 2))
		GuideManager.finishStepLater()
	elseif var_16_0 == "leave claim 1" then
		GuideManager.setOperateLayer(arg_16_0._btnBack, nil, {
			arg_16_0
		})
	else
		return
	end

	arg_16_1:stopPropagation()
end

return var_0_0
