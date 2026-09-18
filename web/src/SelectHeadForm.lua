local var_0_0 = class("SelectHeadForm", BaseForm)
local var_0_1 = cc.size(840, 640)
local var_0_2 = 6

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.CHANGE_ICON), 0)

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 32, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 20, 20)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._frame, var_2_0)

	arg_2_0._list = var_2_0

	local var_2_1 = P:getCharacterId() * 100
	local var_2_2 = {}

	for iter_2_0 = 1, ClientData.isAnotherSkin() and 3 or 1 do
		local var_2_3 = var_2_1 + iter_2_0

		if lc.FrameCache:getSpriteFrame(ClientData.getAvatarName(var_2_3)) == nil then
			break
		end

		table.insert(var_2_2, var_2_3)
	end

	for iter_2_1, iter_2_2 in pairs(Data._skinInfo) do
		if iter_2_2._infoId == P:getCharacterId() and iter_2_2._id >= 52000 and iter_2_2._id < 53000 and P._playerCard:hasSkin(iter_2_2._id) then
			table.insert(var_2_2, iter_2_2._id)
		end
	end

	arg_2_0._avatarIds = var_2_2

	arg_2_0:updateAvatarList()
end

function var_0_0.updateAvatarList(arg_3_0)
	local var_3_0 = {}
	local var_3_1

	table.insert(var_3_0, Str(STR.AVATAR_CARD_TIP))

	for iter_3_0 = 1, #arg_3_0._avatarIds do
		if var_3_1 == nil or #var_3_1 == var_0_2 then
			var_3_1 = {}

			table.insert(var_3_0, var_3_1)
		end

		table.insert(var_3_1, arg_3_0._avatarIds[iter_3_0])
	end

	local var_3_2 = arg_3_0._list

	var_3_2:bindData(var_3_0, function(arg_4_0, arg_4_1)
		arg_3_0:setOrCreateItem(arg_4_0, arg_4_1)
	end, math.min(8, #var_3_0), 1)

	for iter_3_1 = 1, var_3_2._cacheCount do
		local var_3_3 = var_3_0[iter_3_1]
		local var_3_4 = arg_3_0:setOrCreateItem(nil, var_3_3)

		var_3_2:pushBackCustomItem(var_3_4)
	end

	var_3_2:jumpToTop()
end

function var_0_0.setOrCreateItem(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == nil then
		arg_5_1 = ccui.Widget:create()
	end

	arg_5_1:removeAllChildren()

	if type(arg_5_2) == "string" then
		local var_5_0 = 66

		arg_5_1:setContentSize(lc.w(arg_5_0._list), var_5_0)
		ClientView.addDecoratedLabel(arg_5_1, arg_5_2, cc.p(lc.w(arg_5_1) / 2, var_5_0 / 2), 26)
	else
		local var_5_1 = 104
		local var_5_2 = 20
		local var_5_3 = (var_5_1 + var_5_2) * var_0_2 - var_5_2

		arg_5_1:setContentSize(var_5_3, 100)

		local var_5_4 = cc.p(var_5_1 / 2, lc.h(arg_5_1) / 2)

		for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
			local var_5_5 = ClientView.createShaderButton("avatar_frame_001", function()
				if ClientData._player:changeIcon(iter_5_1) then
					ClientData.sendSetAvatar(iter_5_1)
					arg_5_0:hide()
				end
			end)

			lc.addChildToPos(arg_5_1, var_5_5, var_5_4)

			local var_5_6 = lc.createSprite("img_card_ico_bg")

			lc.addChildToCenter(var_5_5, var_5_6, -1)

			local var_5_7 = lc.createSprite(ClientData.getAvatarName(iter_5_1))

			var_5_7:setScale(0.8)
			lc.addChildToCenter(var_5_5, var_5_7, -1)

			var_5_4.x = var_5_4.x + lc.w(var_5_5) + var_5_2
		end
	end

	return arg_5_1
end

return var_0_0
