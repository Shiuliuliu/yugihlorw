require("TavernScene")
require("HeroCenterScene")

local var_0_0 = class("CityScene2", require("BaseScene"))
local var_0_1 = {
	Data.FixityId.union,
	Data.FixityId.manage_troop,
	Data.FixityId.duel,
	Data.FixityId.palace
}
local var_0_2 = {
	Data.FixityId.duel,
	Data.FixityId.depot
}

function var_0_0.create()
	return lc.createScene(var_0_0)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.city) then
		return false
	end

	local var_2_0 = lc.Director:getVisibleSize()
	local var_2_1 = ClientData.getAppId()
	local var_2_2 = lc.createSprite("res/updater/loadingr.jpg")

	lc.addChildToCenter(arg_2_0, var_2_2)

	arg_2_0._bg = var_2_2

	arg_2_0:initButtons()

	return true
end

function var_0_0.initButtons(arg_3_0)
	if ClientData.getAppStoreReviewingType() == 3 then
		local var_3_0 = lc.createSprite("city_3_role")

		var_3_0:setAnchorPoint(0.5, 0)
		var_3_0:setScale(1.2)
		lc.addChildToPos(arg_3_0, var_3_0, cc.p(ClientView.SCR_CW - 380, 0))

		local var_3_1 = {
			"rank",
			"gold",
			"mail",
			"badge"
		}
		local var_3_2 = {
			STR.RANK,
			STR.EXCHANGE,
			STR.MAIL,
			STR.BADGE
		}

		for iter_3_0 = 1, #var_3_1 do
			local var_3_3 = ClientView.createShaderButton("city_3_btn1_" .. var_3_1[iter_3_0], function(arg_4_0)
				arg_3_0:onButton(iter_3_0)
			end)
			local var_3_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(var_3_2[iter_3_0]))

			lc.addChildToPos(var_3_3, var_3_4, cc.p(lc.cw(var_3_3), 4))
			lc.addChildToPos(arg_3_0, var_3_3, cc.p(ClientView.SCR_W - ClientView.SCR_EDGE + 30 - iter_3_0 * 110, ClientView.SCR_H - 70))
		end

		local var_3_5 = {
			"role",
			"bag",
			"union"
		}
		local var_3_6 = {
			STR.CHARACTER,
			STR.BAG,
			STR.UNION
		}

		for iter_3_1 = 1, #var_3_5 do
			local var_3_7 = ClientView.createShaderButton("city_3_btn2_" .. var_3_5[iter_3_1], function(arg_5_0)
				arg_3_0:onButton(iter_3_1 + 10)
			end)
			local var_3_8 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(var_3_6[iter_3_1]))

			lc.addChildToPos(var_3_7, var_3_8, cc.p(lc.cw(var_3_7) + 16, lc.ch(var_3_7) + 4))
			lc.addChildToPos(arg_3_0, var_3_7, cc.p(ClientView.SCR_CW + 700 - iter_3_1 * 266, ClientView.SCR_CH + 102))
			var_3_7:setVisible(iter_3_1 ~= 1)
		end

		local var_3_9 = {
			"chaos",
			"dark",
			"clash"
		}
		local var_3_10 = {
			STR.FIND_UNION_BATTLE_TITLE,
			STR.DARK_BATTLE,
			STR.PUBG
		}

		for iter_3_2 = 1, #var_3_9 do
			local var_3_11 = ClientView.createShaderButton("city_3_btn3_bg", function(arg_6_0)
				arg_3_0:onButton(iter_3_2 + 20)
			end)
			local var_3_12 = lc.createSprite("city_3_btn3_" .. var_3_9[iter_3_2])

			lc.addChildToPos(var_3_11, var_3_12, cc.p(lc.cw(var_3_11), lc.ch(var_3_11) + 16))

			local var_3_13 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(var_3_10[iter_3_2]))

			lc.addChildToPos(var_3_11, var_3_13, cc.p(lc.cw(var_3_11), 40))
			lc.addChildToPos(arg_3_0, var_3_11, cc.p(ClientView.SCR_CW + 660 - iter_3_2 * 266, ClientView.SCR_CH - 30))
		end
	else
		local var_3_14 = ClientData.getAppStoreReviewingType() == 1 and var_0_1 or var_0_2

		for iter_3_3 = 1, #var_3_14 do
			local var_3_15 = ClientView.createShaderButton("city_btn_" .. var_3_14[iter_3_3], function(arg_7_0)
				arg_3_0:onButton(var_3_14[iter_3_3])
			end)

			if iter_3_3 ~= 4 then
				lc.addChildToCenter(arg_3_0._bg, var_3_15)

				local var_3_16 = lc.FrameCache:getSpriteFrame("city_btn_" .. var_3_14[iter_3_3])
				local var_3_17 = var_3_16:getOffsetInPixels()
				local var_3_18 = var_3_16:getRectInPixels()
				local var_3_19 = var_3_18.width
				local var_3_20 = var_3_18.height

				var_3_15:setTouchRect(cc.rect(lc.cw(arg_3_0._bg) + var_3_17.x - math.floor(var_3_19 / 2), lc.ch(arg_3_0._bg) + var_3_17.y - math.floor(var_3_20 / 2), var_3_19, var_3_20))
			else
				lc.addChildToPos(arg_3_0, var_3_15, cc.p(ClientView.SCR_W - 60, ClientView.SCR_H - 110))
			end
		end
	end
end

function var_0_0.onEnter(arg_8_0)
	var_0_0.super.onEnter(arg_8_0)
	lc.Audio.playAudio(AUDIO.M_CITY)

	if ClientData.getAppStoreReviewingType() == 3 then
		-- block empty
	else
		local var_8_0 = ClientView.getResourceUI()

		var_8_0:setMode(Data.ResType.gold)
		arg_8_0._scene:addChild(var_8_0, math.max(var_8_0:getLocalZOrder(), ClientData.ZOrder.ui))
	end
end

function var_0_0.onExit(arg_9_0)
	var_0_0.super.onExit(arg_9_0)
	ClientView.removeResourceFromParent()
end

function var_0_0.onCleanup(arg_10_0)
	var_0_0.super.onCleanup(arg_10_0)
end

function var_0_0.onButton(arg_11_0, arg_11_1)
	if ClientData.getAppStoreReviewingType() == 3 then
		if arg_11_1 == 1 then
			require("RankForm").create(Data.RankRange.lord):show()
		elseif arg_11_1 == 2 then
			ClientView.showResExchangeForm(Data.ResType.gold)
		elseif arg_11_1 == 3 then
			require("MailForm").create():show()
		elseif arg_11_1 == 4 then
			require("BadgeForm").create():show()
		elseif arg_11_1 == 11 then
			require("ChangeCharacterPanel").create(false):show()
		elseif arg_11_1 == 12 then
			lc.pushScene(require("DepotScene").create())
		elseif arg_11_1 == 13 then
			lc.pushScene(require("UnionScene").create())
		elseif arg_11_1 == 21 then
			lc.pushScene(require("FindScene").create(5))
		elseif arg_11_1 == 22 then
			lc.pushScene(require("FindScene").create(6))
		elseif arg_11_1 == 23 then
			lc.pushScene(require("FindScene").create(8))
		end
	elseif arg_11_1 == Data.FixityId.manage_troop then
		lc.pushScene(require("HeroCenterScene").create())
	elseif arg_11_1 == Data.FixityId.duel then
		lc.pushScene(require("FindScene").create(ClientData.getAppStoreReviewingType() == 1 and 3 or 2))
	elseif arg_11_1 == Data.FixityId.union then
		lc.pushScene(require("UnionScene").create())
	elseif arg_11_1 == Data.FixityId.depot then
		lc.pushScene(require("DepotScene").create())
	elseif arg_11_1 == Data.FixityId.palace then
		require("RankForm").create(Data.RankRange.lord):show()
	end
end

function var_0_0.clearCity(arg_12_0)
	arg_12_0:removeAllChildren()
end

return var_0_0
