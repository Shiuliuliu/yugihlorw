local var_0_0 = class("GroupWidget", lc.ExtendCCNode)

var_0_0.Flag = {
	CLICKABLE = 65536,
	NAME = 1,
	UNION = 4,
	REGION = 2
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._group = arg_2_1
	arg_2_0._flag = arg_2_2 or 0
	arg_2_3 = arg_2_3 or 0.6
	arg_2_0._avatar = ClientView.createGroupAvatar()

	arg_2_0._avatar:setScale(arg_2_3)

	local var_2_0 = lc.createSprite("group_name_bg")

	arg_2_0:setContentSize(cc.size(lc.w(arg_2_0._avatar) * arg_2_3 + lc.w(var_2_0), lc.h(arg_2_0._avatar) * arg_2_3))
	lc.addChildToPos(arg_2_0, arg_2_0._avatar, cc.p(lc.cw(arg_2_0._avatar), lc.ch(arg_2_0)), 1)
	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.right(arg_2_0._avatar) + lc.cw(var_2_0) - 20, lc.h(arg_2_0) - lc.ch(var_2_0) - 30 * arg_2_3))

	local var_2_1 = ClientView.createTTF("", ClientView.FontSize.S3)

	lc.addChildToCenter(var_2_0, var_2_1)

	arg_2_0._nameLabel = var_2_1

	var_2_0:setVisible(band(arg_2_0._flag, var_0_0.Flag.NAME) ~= 0)

	local var_2_2 = ClientView.createTTF("", ClientView.FontSize.S3)

	var_2_2:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.right(arg_2_0._avatar), 40 * arg_2_3))
	var_2_2:setVisible(band(arg_2_0._flag, var_0_0.Flag.REGION) ~= 0)

	arg_2_0._regionLabel = var_2_2

	if arg_2_1 then
		arg_2_0:setGroup(arg_2_1)
	end
end

function var_0_0.setAvatar(arg_3_0, arg_3_1)
	if arg_3_0._avatar then
		arg_3_0._avatar.update(arg_3_1)
	end
end

function var_0_0.setGroup(arg_4_0, arg_4_1)
	arg_4_0._group = arg_4_1

	arg_4_0:setAvatar(arg_4_1._avatar)
	arg_4_0:setName(arg_4_1._name)
	arg_4_0:setRegion(arg_4_1._members[1]._regionId)
end

function var_0_0.setName(arg_5_0, arg_5_1)
	if arg_5_0._nameLabel then
		arg_5_0._nameLabel:setString(arg_5_1)
	end
end

function var_0_0.setRegion(arg_6_0, arg_6_1)
	if arg_6_0._regionLabel then
		arg_6_0._regionLabel:setString(ClientData.genChannelRegionName(arg_6_1))
	end
end

return var_0_0
