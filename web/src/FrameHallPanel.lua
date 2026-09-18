local var_0_0 = class("FrameHallPanel", require("BasePanel"))
local var_0_1 = cc.size(300, 660)
local var_0_2 = {
	[2] = cc.p(0, 20),
	[3] = cc.p(0, 0),
	[5] = cc.p(0, -40),
	[12] = cc.p(0, -40),
	[4] = cc.p(0, 26),
	[13] = cc.p(0, -4),
	[10] = cc.p(0, -54),
	[9] = cc.p(0, -24),
	[7] = cc.p(0, 6),
	[14] = cc.p(0, 6),
	[11] = cc.p(0, 6),
	[15] = cc.p(0, 6)
}

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0._isShowResourceUI = true

	var_0_0.super.init(arg_2_0, true)

	arg_2_0._panelName = "FrameHallPanel"

	local var_2_0 = lc.createSprite("res/jpg/frame_hall_bg.jpg")

	lc.addChildToCenter(arg_2_0, var_2_0)
	arg_2_0:createTopArea()

	arg_2_0._indicator = ClientView.showPanelActiveIndicator(var_2_0)

	ClientData.sendGetWorshipList()
end

function var_0_0.createTopArea(arg_3_0)
	local var_3_0 = ClientView.createTitleArea(Str(STR.FRAME_HALL), function()
		arg_3_0:hide()
	end)

	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.cw(arg_3_0), lc.h(arg_3_0) - lc.ch(var_3_0)))
end

function var_0_0.createStages(arg_5_0)
	if arg_5_0._stages then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._stages) do
			iter_5_1:removeFromParent()
		end

		arg_5_0._stages = nil
	end

	local var_5_0 = {
		{
			_title = "frame_dark_title",
			_type = Data.WorshipType.dark
		},
		{
			_title = "frame_clash_title",
			_type = Data.WorshipType.clash
		},
		{
			_title = "frame_arena_title",
			_type = Data.WorshipType.arena
		}
	}
	local var_5_1 = {}

	arg_5_0._stages = var_5_1

	for iter_5_2 = 1, #var_5_0 do
		var_5_1[iter_5_2] = arg_5_0:createStage(var_5_0[iter_5_2])
	end

	lc.addNodesToCenter(arg_5_0, var_5_1, 50, lc.ch(arg_5_0) - 20)

	arg_5_0._topArea = area

	return area
end

function var_0_0.createStage(arg_6_0, arg_6_1)
	local var_6_0 = P._playerBonus._bonusWorship[1]._value
	local var_6_1 = arg_6_0._worships[arg_6_1._type]
	local var_6_2 = var_6_1 and var_6_1._user or nil
	local var_6_3 = lc.createNode(var_0_1)
	local var_6_4 = lc.createSpriteWithMask("res/jpg/frame_item_bg.jpg")

	lc.addChildToPos(var_6_3, var_6_4, cc.p(lc.cw(var_6_3), lc.h(var_6_3) - lc.ch(var_6_4)))

	local var_6_5 = lc.createSpriteWithMask("res/jpg/frame_stage_bg.jpg")

	lc.addChildToPos(var_6_3, var_6_5, cc.p(lc.cw(var_6_3), lc.bottom(var_6_4) - lc.ch(var_6_5) + 50))

	if var_6_2 then
		local var_6_6 = P.getCharacterId(var_6_2)
		local var_6_7 = DragonBones.create(Data.getCharacterBoneName(var_6_6))

		var_6_7:gotoAndPlay(Data.getCharacterAniName(var_6_6))
		var_6_7:setScale(0.4)
		lc.addChildToCenter(var_6_4, var_6_7)

		local var_6_8 = var_0_2[var_6_6] or cc.p(0, 0)

		lc.offset(var_6_7, var_6_8.x, var_6_8.y - 100)

		local var_6_9 = Particle.create("mingrentangtexiao")

		lc.addChildToCenter(var_6_4, var_6_9)

		local var_6_10 = lc.createSprite({
			_name = "img_ui_scene_name_bg",
			_crect = cc.rect(0, 0, 47, 42),
			_size = cc.size(200, 40)
		})

		lc.addChildToPos(var_6_5, var_6_10, cc.p(lc.cw(var_6_5), lc.h(var_6_5) + lc.ch(var_6_10) - 8))

		local var_6_11 = ClientView.createTTF(var_6_2 and var_6_2._name or "", ClientView.FontSize.S1)

		lc.addChildToCenter(var_6_10, var_6_11)

		local var_6_12 = lc.createSprite(arg_6_1._title)

		lc.addChildToPos(var_6_5, var_6_12, cc.p(lc.cw(var_6_5), 60))

		local var_6_13 = ClientView.createTTF(var_6_1 and var_6_1._count or 0, ClientView.FontSize.S2)

		lc.addChildToPos(var_6_5, var_6_13, cc.p(185, 103))
	end

	if var_6_1 then
		local var_6_14 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
			if var_6_0 > 0 and not P:hasResource(Data.ResType.ingot, Data._globalInfo._worshipCost) then
				return ToastManager.push(Str(STR.NOT_ENOUGH_INGOT))
			end

			if var_6_0 > 1 then
				return ToastManager.push(Str(STR.WORSHIP_TOO_MUCH))
			end

			arg_6_0:worship(var_6_1)
		end, ClientView.CRECT_BUTTON_S, 140)

		lc.addChildToPos(var_6_3, var_6_14, cc.p(lc.cw(var_6_3), lc.ch(var_6_14)))
		var_6_14:addLabel(Str(STR.WORSHIP))
		var_6_14:setVisible(var_6_1 ~= nil)

		local var_6_15 = lc.createSprite({
			_name = "img_ui_scene_name_bg",
			_crect = cc.rect(0, 0, 47, 42),
			_size = cc.size(lc.w(var_6_14), 40)
		})

		lc.addChildToPos(var_6_3, var_6_15, cc.p(lc.x(var_6_14), lc.top(var_6_14) + lc.ch(var_6_15)))
		var_6_15:setVisible(var_6_1 ~= nil)

		if var_6_0 <= 0 then
			local var_6_16 = ClientView.createTTF(string.format(Str(STR.FREE_TIMES), 1), ClientView.FontSize.S3, ClientView.COLOR_TEXT_INGOT)

			lc.addChildToCenter(var_6_15, var_6_16)
		else
			ClientView.addPriceToBtn(var_6_15, Data._globalInfo._worshipCost, Data.ResType.ingot, lc.w(var_6_15))
		end
	end

	return var_6_3
end

function var_0_0.worship(arg_8_0, arg_8_1)
	local var_8_0 = P._playerBonus._bonusWorship[1]._value

	local function var_8_1()
		ClientData.sendWorship(arg_8_1._type)

		arg_8_1._count = arg_8_1._count + 1

		for iter_9_0, iter_9_1 in ipairs(P._playerBonus._bonusWorship) do
			iter_9_1._value = iter_9_1._value + 1

			if iter_9_1:canClaim() and P._playerBonus:claimBonus(iter_9_1._infoId) == Data.ErrorType.ok then
				local var_9_0 = require("RewardPanel")

				var_9_0.create(iter_9_1, var_9_0.MODE_CLAIM):show()
			end
		end

		arg_8_0:createStages()
	end

	if var_8_0 > 0 then
		require("Dialog").showDialog(string.format(Str(STR.CONFIRM_WORSHIP), Data._globalInfo._worshipCost), function()
			var_8_1()
			P:changeResource(Data.ResType.ingot, -Data._globalInfo._worshipCost)
		end)
	else
		var_8_1()
	end
end

function var_0_0.onEnter(arg_11_0)
	var_0_0.super.onEnter(arg_11_0)

	arg_11_0._listeners = {}

	table.insert(arg_11_0._listeners, lc.addEventListener(Data.Event.ingot_dirty, function()
		arg_11_0:createStages()
	end))
	ClientData.addMsgListener(arg_11_0, function(arg_13_0)
		return arg_11_0:onMsg(arg_13_0)
	end, 0)
end

function var_0_0.onExit(arg_14_0)
	var_0_0.super.onExit(arg_14_0)

	for iter_14_0 = 1, #arg_14_0._listeners do
		lc.Dispatcher:removeEventListener(arg_14_0._listeners[iter_14_0])
	end

	ClientData.removeMsgListener(arg_14_0)
end

function var_0_0.onMsg(arg_15_0, arg_15_1)
	if arg_15_1.type == SglMsgType_pb.PB_TYPE_WORLD_WORSHIP_LIST then
		if arg_15_0._indicator then
			arg_15_0._indicator:removeFromParent()

			arg_15_0._indicator = nil
		end

		local var_15_0 = arg_15_1.Extensions[World_pb.SglWorldMsg.worship_mvps_resp]

		arg_15_0._worships = {}

		for iter_15_0 = 1, #var_15_0 do
			local var_15_1 = var_15_0[iter_15_0]
			local var_15_2 = require("User").create(var_15_1.user_info)

			arg_15_0._worships[var_15_1.mvp_type] = {
				_type = var_15_1.mvp_type,
				_user = var_15_2,
				_count = var_15_1.count
			}
		end

		arg_15_0:createStages()

		return true
	end
end

function var_0_0.onCleanup(arg_16_0)
	lc.TextureCache:removeTextureForKey("res/jpg/frame_hall_bg.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/frame_item_bg.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/frame_stage_bg.jpg")
end

return var_0_0
