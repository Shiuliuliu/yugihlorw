local var_0_0 = class("EquipSkillForm", BaseForm)
local var_0_1 = cc.size(800, 640)
local var_0_2 = cc.size(190, 250)
local var_0_3 = 20
local var_0_4 = 2
local var_0_5 = cc.size(240, 120)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	arg_2_0._infoId = arg_2_1
	arg_2_0._cardId, arg_2_0._isFragment, arg_2_0._isGold, arg_2_0._extraSid = Data.removeAdditional(arg_2_1)
	arg_2_0._cardSpecificId = Data.setAdditional(arg_2_0._cardId, false, arg_2_0._isGold, arg_2_0._extraSid)
	arg_2_0._sids = arg_2_2
	arg_2_0._callback = arg_2_3

	local var_2_0 = lc.List.createH(cc.size(lc.w(arg_2_0._form) - 60, lc.h(arg_2_0._frame) - 40), 10, var_0_3)

	lc.addChildToPos(arg_2_0._form, var_2_0, cc.p(30, 40))

	arg_2_0._list = var_2_0

	arg_2_0:refreshItemList()
end

function var_0_0.refreshItemList(arg_3_0)
	local var_3_0 = lc.arrayToTable(arg_3_0._sids, var_0_4)
	local var_3_1 = arg_3_0._list

	var_3_1:bindData(var_3_0, function(arg_4_0, arg_4_1)
		arg_3_0:setOrCreateItem(arg_4_0, arg_4_1)
	end, math.min(8, #var_3_0))

	for iter_3_0 = 1, var_3_1._cacheCount do
		local var_3_2 = arg_3_0:setOrCreateItem(nil, var_3_0[iter_3_0])

		var_3_1:pushBackCustomItem(var_3_2)
	end

	var_3_1:jumpToTop()
	var_3_1:checkEmpty(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.SKILL)))
end

function var_0_0.setOrCreateItem(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == nil then
		local var_5_0 = var_0_2.width
		local var_5_1 = (var_0_2.height + var_0_3) * var_0_4 - var_0_3

		arg_5_1 = ccui.Widget:create()

		arg_5_1:setContentSize(var_5_0, var_5_1)

		arg_5_1._pos = {}
		arg_5_1._skills = {}

		local var_5_2 = var_5_0 / 2
		local var_5_3 = var_5_1 - var_0_2.height / 2

		for iter_5_0 = 1, var_0_4 do
			arg_5_1._pos[iter_5_0] = cc.p(var_5_2, var_5_3)
			var_5_3 = var_5_3 - var_0_2.height - var_0_3
		end
	end

	local var_5_4 = arg_5_1._skills

	for iter_5_1 = 1, var_0_4 do
		local var_5_5 = var_5_4[iter_5_1]
		local var_5_6 = arg_5_2[iter_5_1]

		if iter_5_1 <= #arg_5_2 then
			if var_5_5 == nil then
				var_5_5 = arg_5_0:createSkillItem(var_5_6)

				lc.addChildToPos(arg_5_1, var_5_5, arg_5_1._pos[iter_5_1])

				var_5_4[iter_5_1] = var_5_5
			else
				var_5_5.update(var_5_6)
			end

			var_5_5:setVisible(true)
		elseif var_5_5 then
			var_5_5:setVisible(false)
		end
	end

	return arg_5_1
end

function var_0_0.createSkillItem(arg_6_0, arg_6_1)
	local var_6_0 = ccui.Widget:create()

	var_6_0:setContentSize(var_0_2)

	local var_6_1 = lc.createImageView({
		_name = "img_com_bg_16",
		_crect = ClientView.CRECT_COM_BG16,
		_size = cc.size(var_0_2.width, var_0_2.height - 30)
	})

	lc.addChildToPos(var_6_0, var_6_1, cc.p(lc.cw(var_6_0), lc.h(var_6_0) - lc.ch(var_6_1)))

	local var_6_2 = IconWidget.createByInfoId(arg_6_1, arg_6_0._sids._isFindSurvival and 1 or P:getItemCount(arg_6_1), IconWidget.DisplayFlag.ITEM)

	lc.addChildToCenter(var_6_1, var_6_2)
	var_6_2:setNameColor(lc.Color3B.white)

	var_6_1._icon = var_6_2

	local var_6_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_7_0)
		arg_6_0:onEquip(arg_7_0._sid)
	end, ClientView.CRECT_BUTTON, 150)

	var_6_3:addLabel(arg_6_0._sids._isFindSurvival and Str(STR.EQUIP) or Str(STR.RUB))
	lc.addChildToPos(var_6_0, var_6_3, cc.p(lc.cw(var_6_1), 30))

	function var_6_0.update(arg_8_0)
		var_6_3._sid = arg_8_0
		var_6_1._icon._data._infoId = arg_8_0

		var_6_1._icon:setData(var_6_1._icon._data)
	end

	var_6_0.update(arg_6_1)

	return var_6_0
end

function var_0_0.onEquip(arg_9_0, arg_9_1)
	if arg_9_0._sids._isFindSurvival then
		require("Dialog").showDialog(Str(STR.SURE_TO_EQUIP), function()
			ToastManager.push(Str(STR.EQUIP_SUCCESS))
			P._playerFindSurvivalEx:equipSkill(arg_9_0._cardSpecificId, arg_9_1)

			if arg_9_0._callback then
				arg_9_0._callback()
			end

			arg_9_0:hide()
		end)
	else
		require("Dialog").showDialog(Str(STR.SURE_TO_RUB), function()
			P:addResource(arg_9_1, 1, -1)
			P._playerCard:equipSkill(arg_9_0._cardSpecificId, arg_9_1)

			if arg_9_0._callback then
				arg_9_0._callback()
			end

			arg_9_0:hide()
		end)
	end
end

function var_0_0.onCleanup(arg_12_0)
	var_0_0.super.onCleanup(arg_12_0)
end

return var_0_0
