local var_0_0 = class("SkillDetailWidget", lc.ExtendUIWidget)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = var_0_0.new(lc.EXTEND_IMAGE, "img_com_bg_7", ccui.TextureResType.plistType)

	var_1_0:setScale9Enabled(true)
	var_1_0:setCapInsets(ClientView.CRECT_COM_BG7)
	var_1_0:setContentSize(cc.size(230, 200))
	var_1_0:setColor(arg_1_4)
	var_1_0:setOpacity(arg_1_5)
	var_1_0:setTouchEnabled(true)
	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_6, arg_1_7)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0._skillId = arg_2_1
	arg_2_0._curLevel = arg_2_2
	arg_2_0._dstLevel = arg_2_3
	arg_2_0._displayLevel = arg_2_2

	local var_2_0 = 10
	local var_2_1 = 24
	local var_2_2 = 10
	local var_2_3 = Data._skillInfo[arg_2_1]
	local var_2_4 = Str(var_2_3._nameSid)

	if var_2_3._val[1] ~= 0 then
		var_2_4 = var_2_4 .. string.format(" %d", arg_2_0._displayLevel)
	end

	local var_2_5 = ClientData.getSkillDesc(arg_2_1, arg_2_0._displayLevel)
	local var_2_6 = cc.Sprite:createWithSpriteFrameName(string.format("img_icon_skill_%d", Data.getSkillType(var_2_3._id)))

	var_2_6:setScale(0.8)

	local var_2_7 = cc.Label:createWithTTF(var_2_4, ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_7:setColor(arg_2_5)

	local var_2_8 = (lc.w(arg_2_0) - lc.w(var_2_6) - lc.w(var_2_7) - var_2_2) / 2

	lc.addChildToPos(arg_2_0, var_2_6, cc.p(var_2_8 + lc.w(var_2_6) / 2, lc.h(arg_2_0) - lc.h(var_2_6) / 2 - var_2_1))
	lc.addChildToPos(arg_2_0, var_2_7, cc.p(lc.right(var_2_6) + lc.w(var_2_7) / 2 + var_2_2, lc.y(var_2_6)))

	local var_2_9 = cc.Label:createWithTTF(var_2_5, ClientView.TTF_FONT, ClientView.FontSize.S2, cc.size(lc.w(arg_2_0) - 40, 0))

	var_2_9:setColor(arg_2_6)
	lc.addChildToPos(arg_2_0, var_2_9, cc.p(lc.w(arg_2_0) / 2, lc.bottom(var_2_6) - lc.h(var_2_9) / 2 - var_2_2))

	arg_2_0._skillIco = var_2_6
	arg_2_0._skillName = var_2_7
	arg_2_0._skillDesc = var_2_9

	if arg_2_4 and var_2_3._val[1] ~= 0 then
		local var_2_10 = ClientView.createShaderButton("img_icon_minus", function(arg_3_0)
			if arg_2_0._displayLevel > 1 then
				arg_2_0:updateDisplayLevel(arg_2_0._displayLevel - 1)
			end
		end)
		local var_2_11 = ClientView.createShaderButton("img_icon_add", function(arg_4_0)
			if arg_2_0._displayLevel < #var_2_3._val and var_2_3._val[arg_2_0._displayLevel + 1] ~= 0 then
				arg_2_0:updateDisplayLevel(arg_2_0._displayLevel + 1)
			end
		end)
		local var_2_12 = lc.w(var_2_10)

		var_2_10:setTouchRect(cc.rect(-var_2_12, -var_2_12, var_2_12 * 3, var_2_12 * 3))
		var_2_11:setTouchRect(cc.rect(-var_2_12, -var_2_12, var_2_12 * 3, var_2_12 * 3))
		lc.addChildToPos(arg_2_0, var_2_10, cc.p(var_2_0 + var_2_12 / 2, lc.y(var_2_6)))
		lc.addChildToPos(arg_2_0, var_2_11, cc.p(lc.w(arg_2_0) - var_2_0 - var_2_12 / 2, lc.y(var_2_6)))
	end
end

function var_0_0.updateDisplayLevel(arg_5_0, arg_5_1)
	arg_5_0._displayLevel = arg_5_1

	local var_5_0 = Data._skillInfo[arg_5_0._skillId]

	if var_5_0._val[1] ~= 0 then
		arg_5_0._skillName:setString(Str(var_5_0._nameSid) .. string.format(" %d", arg_5_0._displayLevel))
	else
		arg_5_0._skillName:setString(Str(var_5_0._nameSid))
	end

	arg_5_0._skillDesc:setString(ClientData.getSkillDesc(arg_5_0._skillId, arg_5_0._displayLevel))
end

return var_0_0
