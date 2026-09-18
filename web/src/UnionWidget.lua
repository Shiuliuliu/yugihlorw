local var_0_0 = class("UnionWidget", lc.ExtendCCNode)

var_0_0.SIZE = cc.size(400, 96)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(var_0_0.SIZE)
	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ClientView.createBadge(1, "")

	var_2_0:setScale(0.6)
	lc.addChildToPos(arg_2_0, var_2_0, cc.p(math.floor(lc.sw(var_2_0) / 2), lc.h(arg_2_0) / 2))

	arg_2_0._badge = var_2_0

	if arg_2_2 then
		local var_2_1 = lc.createSprite("img_glow")

		var_2_1:setScale(0.5)
		lc.addChildToPos(arg_2_0, var_2_1, cc.p(var_2_0:getPosition()), -1)
	end

	local var_2_2 = ClientView.createLevelNameArea(1, "")

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.right(var_2_0) - 2, lc.y(var_2_0) + lc.h(var_2_2) / 2 - 22), -1)

	arg_2_0._nameArea = var_2_2
	arg_2_0._id = ClientView.addIconValue(arg_2_0, "img_icon_id", 0, lc.left(var_2_2) + 30, lc.bottom(var_2_2) - 4)

	arg_2_0._id:setColor(ClientView.COLOR_TEXT_DARK)

	arg_2_0._member = ClientView.addIconValue(arg_2_0, "img_icon_troop", 0, lc.left(var_2_2) + 176, lc.y(arg_2_0._id))

	arg_2_0._member:setColor(ClientView.COLOR_TEXT_DARK)

	if arg_2_1 then
		arg_2_0:setUnion(arg_2_1)
	end
end

function var_0_0.setUnion(arg_3_0, arg_3_1)
	arg_3_0._union = arg_3_1

	arg_3_0._badge:update(arg_3_1._badge, arg_3_1._word)
	arg_3_0._nameArea._level:setString(arg_3_1._level)
	arg_3_0._nameArea:setName(arg_3_1._name)
	arg_3_0._id:setString(ClientData.convertId(arg_3_1._id))
	arg_3_0._member:setString(string.format("%d/%d", arg_3_1:getMembersNum(), arg_3_1._memberCapacity))
end

return var_0_0
