local var_0_0 = class("UserWidget", lc.ExtendCCNode)

var_0_0.FRAME_SIZE = 100
var_0_0.NAME_WIDTH = 264
var_0_0.TROPHY_WIDTH = 140
var_0_0.AVATAR_GAP = -10
var_0_0.Flag = {
	CLICKABLE = 65536,
	REGION = 8,
	TROPHY = 1,
	VIP = 16,
	LEVEL_NAME = 2,
	UNION = 4
}
var_0_0.Flag.NAME_UNION = bor(var_0_0.Flag.LEVEL_NAME, var_0_0.Flag.UNION)
var_0_0.Flag.NAME_UNION_VIP = bor(var_0_0.Flag.LEVEL_NAME, var_0_0.Flag.UNION, var_0_0.Flag.VIP)
var_0_0.Flag.REGION_NAME_UNION = bor(var_0_0.Flag.LEVEL_NAME, var_0_0.Flag.UNION, var_0_0.Flag.REGION)
var_0_0.Flag.ALL = bor(var_0_0.Flag.LEVEL_NAME, var_0_0.Flag.TROPHY, var_0_0.Flag.UNION, var_0_0.Flag.REGION)

local var_0_1 = 1000

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._user = arg_2_1
	arg_2_0._flag = arg_2_2 or 0
	arg_2_0._isFlipX = arg_2_4 or false

	local var_2_0 = lc.createNode(cc.size(104, 104))

	if arg_2_3 then
		var_2_0:setScale(arg_2_3)
	end

	local var_2_1 = "avatar_frame_001"
	local var_2_2

	if band(arg_2_0._flag, var_0_0.Flag.CLICKABLE) ~= 0 then
		var_2_2 = ClientView.createShaderButton(var_2_1, function()
			require("LordForm").create():show()
		end)
	else
		var_2_2 = lc.createSprite(var_2_1)
	end

	arg_2_0._frameSize = lc.makeEven(var_0_0.FRAME_SIZE * var_2_2:getScale())
	arg_2_0._frame = var_2_2

	local var_2_3 = arg_2_0._frameSize
	local var_2_4 = arg_2_0._frameSize

	arg_2_0:setContentSize(var_2_3, var_2_4)
	lc.addChildToPos(arg_2_0, var_2_2, cc.p(var_2_3 / 2, var_2_4 / 2))

	local var_2_5 = lc.createSprite("img_card_ico_bg")

	lc.addChildToCenter(var_2_2, var_2_5, -1)

	arg_2_0._avatarBg = var_2_5

	local var_2_6 = lc.createSprite("card_icon_unknow")

	lc.addChildToCenter(var_2_2, var_2_6, -1)
	var_2_6:setScale(0.8)

	arg_2_0._avatar = var_2_6

	if band(arg_2_0._flag, var_0_0.Flag.LEVEL_NAME) ~= 0 then
		var_2_3 = var_2_3 + var_0_0.AVATAR_GAP + var_0_0.NAME_WIDTH

		arg_2_0:setContentSize(var_2_3, var_2_4)

		local var_2_7 = ClientView.createLevelNameArea(0, "", arg_2_0._isFlipX)

		arg_2_0:addChild(var_2_7, -1)
		var_2_7._level:setVisible(false)

		arg_2_0._nameArea = var_2_7

		if band(arg_2_0._flag, var_0_0.Flag.REGION) ~= 0 then
			local var_2_8 = ClientView.createTTF("0", ClientView.FontSize.S3, ClientView.COLOR_LABEL_DARK)

			var_2_8:setAnchorPoint(0, 0)
			arg_2_0:addChild(var_2_8)

			arg_2_0._regionArea = var_2_8

			local var_2_9 = ClientView.createTTF("0", ClientView.FontSize.S3, ClientView.COLOR_LABEL_DARK)

			var_2_9:setAnchorPoint(1, 0)
			arg_2_0:addChild(var_2_9)

			arg_2_0._idArea = var_2_9
		end
	end

	if band(arg_2_0._flag, var_0_0.Flag.UNION) ~= 0 then
		if var_2_3 == 0 then
			local var_2_10 = var_2_3 + var_0_0.AVATAR_GAP + var_0_0.NAME_WIDTH

			arg_2_0:setContentSize(var_2_10, var_2_4)
		end

		local var_2_11 = ClientView.createUnionInfoArea(arg_2_1, arg_2_0._isFlipX)

		arg_2_0:addChild(var_2_11)

		arg_2_0._unionArea = var_2_11
	end

	if arg_2_1 then
		arg_2_0:setUser(arg_2_1, true)
	end
end

function var_0_0.setUser(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._user = arg_4_1

	arg_4_0:setAvatar(arg_4_1)
	arg_4_0:setLevel(arg_4_1._level)
	arg_4_0:setRegion(arg_4_1._regionId)
	arg_4_0:setId(arg_4_1._id)
	arg_4_0:setName(arg_4_1._name)

	if band(arg_4_0._flag, var_0_0.Flag.VIP) ~= 0 then
		arg_4_0:setVip(arg_4_1._vip)
	end

	if arg_4_1._unionId and arg_4_1._unionId > 0 then
		if arg_4_0._unionArea then
			arg_4_0._unionArea:setVisible(true)
			arg_4_0:setUnion(arg_4_1._unionBadge, arg_4_1._unionWord, arg_4_1._unionName)
		end
	elseif arg_4_0._unionArea then
		arg_4_0._unionArea:setVisible(false)
	end

	if arg_4_2 and arg_4_0._nameArea then
		local var_4_0 = arg_4_0._frameSize - math.floor(lc.h(arg_4_0._nameArea) / 2)

		if not arg_4_0._isFlipX then
			arg_4_0._frame:setPosition(arg_4_0._frameSize / 2, arg_4_0._frameSize / 2)

			local var_4_1 = arg_4_0._frameSize + var_0_0.AVATAR_GAP

			arg_4_0._nameArea:setPosition(var_4_1, var_4_0)

			if arg_4_0._unionArea and arg_4_0._unionArea:isVisible() then
				arg_4_0._unionArea:setPosition(var_4_1 + lc.w(arg_4_0._unionArea) / 2 + 18, var_4_0 - 36)
			end

			if arg_4_0._regionArea and arg_4_0._regionArea:isVisible() then
				arg_4_0._regionArea:setPosition(lc.left(arg_4_0._nameArea), lc.top(arg_4_0._nameArea))
				arg_4_0._idArea:setPosition(lc.right(arg_4_0._regionArea) + 70 + lc.cw(arg_4_0._idArea), lc.top(arg_4_0._nameArea))
			end
		else
			arg_4_0._frame:setPosition(lc.w(arg_4_0) - arg_4_0._frameSize / 2, arg_4_0._frameSize / 2)

			local var_4_2 = lc.left(arg_4_0._frame) - var_0_0.AVATAR_GAP

			arg_4_0._nameArea:setPosition(var_4_2, var_4_0)

			if arg_4_0._unionArea and arg_4_0._unionArea:isVisible() then
				arg_4_0._unionArea:setPosition(var_4_2 - lc.w(arg_4_0._unionArea) / 2 - 18, var_4_0 - 36)
			end

			if arg_4_0._regionArea and arg_4_0._regionArea:isVisible() then
				arg_4_0._regionArea:setPosition(var_4_2 - lc.w(arg_4_0._regionArea), lc.top(arg_4_0._nameArea))
				arg_4_0._idArea:setPosition(lc.left(arg_4_0._regionArea) - lc.cw(arg_4_0._idArea) + 20, lc.top(arg_4_0._nameArea))
			end
		end
	end
end

function var_0_0.setAvatar(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._frame

	var_5_0:removeChildrenByTag(var_0_1)

	local var_5_1 = arg_5_1._id and arg_5_1._id == P._id
	local var_5_2 = P._propBag:validPropId(arg_5_1._avatarFrameId, var_5_1)

	if arg_5_1.hasPrivilege and arg_5_1:hasPrivilege(Data.Privilege.clash_mvp) then
		var_5_2 = Data.PropsId.avatar_frame_dark
	end

	local var_5_3 = ClientData.getAvatarFrameName(var_5_2 or Data.PropsId.avatar_frame, arg_5_1._vip)

	if var_5_0.loadTextureNormal then
		var_5_0:loadTextureNormal(var_5_3, ccui.TextureResType.plistType)
	else
		var_5_0:setSpriteFrame(var_5_3)
	end

	if var_5_2 ~= nil and var_5_2 >= 7513 and var_5_2 <= 7515 then
		local var_5_4 = arg_5_1._avatarFrameCount or P._propBag._props[var_5_2] and P._propBag._props[var_5_2]._num or 0

		if var_5_4 > 0 and var_5_4 <= 9 then
			local var_5_5 = var_5_4 % 3

			if var_5_5 == 0 then
				var_5_5 = 3
			end

			local var_5_6 = ({
				"avatar_star",
				"avatar_moon",
				"avatar_sun"
			})[math.floor((var_5_4 - 1) / 3) + 1]

			for iter_5_0 = 1, var_5_5 do
				local var_5_7 = lc.createSprite(var_5_6)

				lc.addChildToPos(var_5_0, var_5_7, cc.p(lc.cw(var_5_0) + 6, 16), 0, var_0_1)

				if iter_5_0 == 1 and var_5_5 == 2 then
					lc.offset(var_5_7, 8)
				elseif iter_5_0 == 2 then
					lc.offset(var_5_7, var_5_5 == 2 and -8 or -15)
				elseif iter_5_0 == 3 then
					lc.offset(var_5_7, 15)
				end
			end
		elseif var_5_4 > 9 then
			local var_5_8 = "avatar_crown"
			local var_5_9 = lc.createSprite(var_5_8)

			lc.addChildToPos(var_5_0, var_5_9, cc.p(lc.cw(var_5_0) + 6, 20), 0, var_0_1)
		end
	end

	local var_5_10 = arg_5_1._avatar
	local var_5_11

	if arg_5_1._id == 0 then
		var_5_11 = "card_ico_0"
	elseif var_5_10 then
		var_5_11 = ClientData.getAvatarName(var_5_10)

		if lc.FrameCache:getSpriteFrame(var_5_11) == nil then
			var_5_11 = string.format("avatar_%02d", var_5_10)
		end

		if lc.FrameCache:getSpriteFrame(var_5_11) == nil then
			var_5_11 = "avatar_00"
		end
	else
		var_5_11 = "avatar_00"
	end

	if ClientData.isAppStoreReviewing() then
		var_5_11 = "avatar_9999"
	end

	arg_5_0._avatar:setSpriteFrame(var_5_11)
	arg_5_0._avatarBg:setPosition(lc.w(var_5_0) / 2, lc.h(var_5_0) / 2)
	arg_5_0._avatar:setPosition(lc.w(var_5_0) / 2, lc.h(var_5_0) / 2)

	local crownData = arg_5_1._crown
	if not crownData then
		local gc = tonumber(arg_5_1.gold_cup or (arg_5_1._account and arg_5_1._account.gold_cup) or 0) or 0
		local sc = tonumber(arg_5_1.silver_cup or (arg_5_1._account and arg_5_1._account.silver_cup) or 0) or 0
		local bc = tonumber(arg_5_1.bronze_cup or (arg_5_1._account and arg_5_1._account.bronze_cup) or 0) or 0
		if gc > 0 then crownData = { _infoId = 7204, _num = gc }
		elseif sc > 0 then crownData = { _infoId = 7205, _num = sc }
		elseif bc > 0 then crownData = { _infoId = 7206, _num = bc }
		end
		if crownData then arg_5_1._crown = crownData end
	end

	if arg_5_1.hasPrivilege and arg_5_1:hasPrivilege(Data.Privilege.foot_crown) and ClientData.getServerTick() <= 2018072300 then
		arg_5_0:setCrown(7208, 0)
	elseif arg_5_1.hasPrivilege and (arg_5_1:hasPrivilege(Data.Privilege.dark_mvp) or arg_5_1:hasPrivilege(Data.Privilege.clash_mvp) or arg_5_1:hasPrivilege(Data.Privilege.arena_mvp)) then
		arg_5_0:setCrown(7207, 0)
	elseif arg_5_1._crown == nil or arg_5_0._crown == nil or arg_5_1._crown._infoId ~= arg_5_0._crown._infoId or arg_5_1._crown._num ~= arg_5_0._crown._num then
		arg_5_0:setCrown(arg_5_1._crown and arg_5_1._crown._infoId or nil, arg_5_1._crown and arg_5_1._crown._num or 0)
	end

	if arg_5_1._legendCrown == nil or arg_5_0._legendCrown == nil or arg_5_1._legendCrown._infoId ~= arg_5_0._legendCrown._infoId or arg_5_1._legendCrown._num ~= arg_5_0._legendCrown._num then
		arg_5_0:setLegendCrown(arg_5_1._legendCrown and arg_5_1._legendCrown._infoId or nil, arg_5_1._legendCrown and arg_5_1._legendCrown._num or 0)
	end

	if arg_5_0._darkParticle then
		arg_5_0._darkParticle:removeFromParent()

		arg_5_0._darkParticle = nil
	end

	if arg_5_1.hasPrivilege and arg_5_1:hasPrivilege(Data.Privilege.dark_mvp) then
		local var_5_12 = Particle.create("touxiang")

		lc.addChildToCenter(arg_5_0._frame, var_5_12)

		arg_5_0._darkParticle = var_5_12
	end
end

function var_0_0.setVip(arg_6_0, arg_6_1)
	if arg_6_1 <= 0 then
		if arg_6_0._vip then
			arg_6_0._vip:setVisible(false)
		end

		return
	end

	if arg_6_0._vip == nil and not ClientData.isAppStoreReviewing() then
		local var_6_0 = lc.createSprite("avatar_vip_bg")

		arg_6_0._frame:addChild(var_6_0)

		arg_6_0._vip = var_6_0

		local var_6_1 = ClientView.createBMFont(ClientView.BMFont.huali_20, "")

		var_6_1:setScale(0.7)
		var_6_1:setColor(lc.Color3B.yellow)
		lc.addChildToPos(var_6_0, var_6_1, cc.p(32, lc.h(var_6_0) - 10))

		var_6_0._value = var_6_1
	end

	if arg_6_0._vip then
		arg_6_0._vip:setVisible(true)
		arg_6_0._vip._value:setString(arg_6_1 > 0 and string.format("VIP %d", arg_6_1) or "")

		local var_6_2, var_6_3 = ClientView.getAvatarVipOffset(arg_6_0._user._avatarFrameId or Data.PropsId.avatar_frame)

		arg_6_0._vip:setPosition(lc.w(arg_6_0._frame) / 2 + var_6_2, lc.h(arg_6_0._frame) / 2 + var_6_3)
	end
end

function var_0_0.setLevel(arg_7_0, arg_7_1)
	if arg_7_0._nameArea then
		arg_7_0._nameArea._level:setString(string.format("%d", arg_7_1))
	end
end

function var_0_0.setRegion(arg_8_0, arg_8_1)
	if arg_8_0._regionArea then
		if arg_8_1 and arg_8_1 > 0 then
			arg_8_0._regionArea:setVisible(true)
			arg_8_0._regionArea:setString(ClientData.genChannelRegionName(arg_8_1))
		else
			arg_8_0._regionArea:setVisible(false)
		end
	end
end

function var_0_0.setId(arg_9_0, arg_9_1)
	if arg_9_0._idArea then
		if arg_9_1 and arg_9_1 > 0 then
			arg_9_0._idArea:setVisible(true)
			arg_9_0._idArea:setString(ClientData.convertId(arg_9_1))
		else
			arg_9_0._idArea:setVisible(false)
		end
	end
end

function var_0_0.setName(arg_10_0, arg_10_1)
	if arg_10_0._nameArea then
		arg_10_0._nameArea:setName(arg_10_1)
	end
end

function var_0_0.setUnion(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0._unionArea then
		if arg_11_1 and arg_11_1 > 0 then
			arg_11_0._unionArea._badge:setSpriteFrame(string.format("avatar_badge_s_%d", arg_11_1))
		end

		if arg_11_2 then
			arg_11_0._unionArea._word:setString(arg_11_2)
		end

		if arg_11_3 then
			arg_11_0._unionArea:setName(arg_11_3)
		end
	end
end

function var_0_0.setCrown(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._crown then
		arg_12_0._crown:removeFromParent()
	end

	arg_12_0._crown = nil

	if arg_12_1 == nil or arg_12_1 == 0 then
		return
	end

	local var_12_0 = ClientView.createCrown(arg_12_1, arg_12_2)

	lc.addChildToPos(arg_12_0._frame, var_12_0, lc.convertPos(cc.p(0, 0), arg_12_0._avatar, arg_12_0._frame))

	arg_12_0._crown = var_12_0
end

function var_0_0.setLegendCrown(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._legendCrown then
		arg_13_0._legendCrown:removeFromParent()
	end

	arg_13_0._legendCrown = nil

	if arg_13_1 == nil or arg_13_1 == 0 then
		return
	end

	local var_13_0 = ClientView.createCrown(arg_13_1, arg_13_2)

	lc.addChildToPos(arg_13_0._frame, var_13_0, lc.convertPos(cc.p(lc.w(arg_13_0._avatar), 0), arg_13_0._avatar, arg_13_0._frame))

	arg_13_0._legendCrown = var_13_0
end

UserWidget = var_0_0

return var_0_0
