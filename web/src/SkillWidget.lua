local var_0_0 = class("SkillWidget", lc.ExtendUIWidget)
local var_0_1 = 250
local var_0_2 = 66

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = var_0_0.new(lc.EXTEND_IMAGE, "img_com_bg_7", ccui.TextureResType.plistType)

	var_1_0:setScale9Enabled(true)
	var_1_0:setCapInsets(ClientView.CRECT_COM_BG7)
	var_1_0:setContentSize(cc.size(var_0_1, var_0_2))
	var_1_0:setColor(arg_1_3)
	var_1_0:setOpacity(arg_1_4)
	var_1_0:setTouchEnabled(true)
	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0._skillId = arg_2_1
	arg_2_0._curLevel = arg_2_2
	arg_2_0._dstLevel = arg_2_3

	local var_2_0 = 22
	local var_2_1 = 16
	local var_2_2 = 8
	local var_2_3 = Data._skillInfo[arg_2_1]
	local var_2_4 = Str(var_2_3._nameSid)

	if var_2_3._val[1] ~= 0 then
		var_2_4 = var_2_4 .. string.format(" %d", arg_2_2)
	end

	local var_2_5 = cc.Sprite:createWithSpriteFrameName(string.format("img_icon_skill_%d", Data.getSkillType(var_2_3._id)))

	var_2_5:setScale(0.8)

	local var_2_6 = cc.Label:createWithTTF(var_2_4, ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_6:setColor(arg_2_6)
	lc.addChildToPos(arg_2_0, var_2_5, cc.p(lc.sw(var_2_5) / 2 + var_2_0, lc.h(arg_2_0) / 2))
	lc.addChildToPos(arg_2_0, var_2_6, cc.p(lc.right(var_2_5) + lc.w(var_2_6) / 2 + var_2_2, lc.y(var_2_5)))

	arg_2_0._skillName = var_2_6

	local var_2_7 = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_7:setColor(lc.Color3B.red)
	arg_2_0:addChild(var_2_7)

	arg_2_0._incLevel = var_2_7

	arg_2_0:updateDstLevel(arg_2_3)

	local var_2_8 = ClientView.createShaderButton("img_btn_squarel_s_2", function(arg_3_0)
		arg_2_0:onSkillDetail()
	end)
	local var_2_9 = ClientView.createBMFont(ClientView.BMFont.huali_20, "...")

	var_2_9:setScale(0.8)
	lc.addChildToCenter(var_2_8, var_2_9)
	lc.addChildToPos(arg_2_0, var_2_8, cc.p(var_0_1 - lc.w(var_2_8) / 2 - 6, var_0_2 / 2))

	arg_2_0._button = var_2_8

	local var_2_10 = require("SkillDetailWidget").create(arg_2_1, arg_2_2, arg_2_3, true, arg_2_4, arg_2_5, arg_2_6, arg_2_6)

	var_2_10:setAnchorPoint(0.5, 0)
	var_2_10:setVisible(false)
	var_2_10:setPosition(var_0_1 / 2, var_0_2)
	arg_2_0:addChild(var_2_10)

	arg_2_0._detail = var_2_10
end

function var_0_0.onSkillDetail(arg_4_0)
	if not arg_4_0._detail:isVisible() then
		arg_4_0._detail:updateDisplayLevel(arg_4_0._dstLevel)
		arg_4_0._detail:setVisible(true)
	else
		arg_4_0._detail:setVisible(false)
	end
end

function var_0_0.updateDstLevel(arg_5_0, arg_5_1)
	arg_5_0._dstLevel = arg_5_1

	local var_5_0 = Data._skillInfo[arg_5_0._skillId]

	if arg_5_0._dstLevel == arg_5_0._curLevel or var_5_0._val[1] == 0 then
		arg_5_0._incLevel:setVisible(false)
	else
		arg_5_0._incLevel:setVisible(true)
		arg_5_0._incLevel:setString(string.format("->%d", arg_5_1))
		arg_5_0._incLevel:setPosition(lc.right(arg_5_0._skillName) + lc.w(arg_5_0._incLevel) / 2, lc.y(arg_5_0._skillName))
	end
end

return var_0_0
