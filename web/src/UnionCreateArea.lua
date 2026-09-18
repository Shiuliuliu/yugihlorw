local var_0_0 = class("UnionCreateArea", lc.ExtendCCNode)
local var_0_1 = 708
local var_0_2 = 640
local var_0_3 = cc.size(320, 320)

var_0_0.Mode = {
	edit = 2,
	create = 1
}

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(cc.size(arg_1_1, arg_1_0 == var_0_0.Mode.create and var_0_1 or var_0_2))
	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._mode = arg_2_1

	local function var_2_0(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		local var_3_0 = ClientView.createTTF(arg_3_0 .. ":", ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)

		var_3_0:setAnchorPoint(1, 0.5)

		local var_3_1 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(arg_3_4 or 320, 56), arg_3_3 or "", true)

		lc.addChildToPos(arg_2_0, var_3_0, cc.p(arg_3_1 or lc.w(arg_2_0) / 2 + 20, arg_3_2 - lc.h(var_3_1) / 2))
		lc.addChildToPos(arg_2_0, var_3_1, cc.p(lc.right(var_3_0) + lc.w(var_3_1) / 2 + 12, lc.y(var_3_0)))

		return var_3_1, arg_3_2 - lc.h(var_3_1) - 16
	end

	local var_2_1 = lc.h(arg_2_0) - 16
	local var_2_2

	arg_2_0._iptName, var_2_2 = var_2_0(Str(STR.UNION_NAME), nil, var_2_1)

	local var_2_3

	arg_2_0._iptDesc, var_2_3 = var_2_0(Str(STR.UNION_SUMMARY), nil, var_2_2)

	local function var_2_4(arg_4_0, arg_4_1)
		local var_4_0 = ClientView.createTTF(arg_4_0 .. ":", ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)

		var_4_0:setAnchorPoint(1, 0.5)

		local var_4_1 = ClientView.createScale9ShaderButton("img_com_bg_5", nil, ClientView.CRECT_COM_BG5, 320, 56)
		local var_4_2 = ClientView.createTTF("", ClientView.FontSize.S1)

		lc.addChildToPos(var_4_1, var_4_2, cc.p(lc.w(var_4_1) / 2, lc.h(var_4_1) / 2 + 1))

		var_4_1._label = var_4_2

		lc.addChildToPos(arg_2_0, var_4_0, cc.p(lc.w(arg_2_0) / 2 + 20, arg_4_1 - lc.h(var_4_1) / 2))
		lc.addChildToPos(arg_2_0, var_4_1, cc.p(lc.right(var_4_0) + lc.w(var_4_1) / 2 + 12, lc.y(var_4_0)))

		return var_4_1, arg_4_1 - lc.h(var_4_1) - 16
	end

	local var_2_5, var_2_6 = var_2_4(Str(STR.UNION_LEVEL_REQUIRE), var_2_3)

	function var_2_5._callback()
		local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
			return {
				_str = arg_6_1,
				_handler = function()
					arg_6_0._level = arg_6_2

					arg_6_0._label:setString(arg_6_1)
				end
			}
		end

		local var_5_1 = P._playerCity:getUnionUnlockLevel()
		local var_5_2 = {
			var_5_0(var_2_5, Str(STR.NO_REQUIREMENT), var_5_1)
		}

		for iter_5_0 = var_5_1 + 10, 100, 10 do
			local var_5_3 = string.format("%s %d", Str(STR.LORD_LEVEL), iter_5_0)

			table.insert(var_5_2, var_5_0(var_2_5, var_5_3, iter_5_0))
		end

		arg_2_0:popSelectPanel(var_2_5, var_5_2)
	end

	arg_2_0._btnLevelRequire = var_2_5

	local var_2_7, var_2_8 = var_2_4(Str(STR.UNION_TYPE), var_2_6)

	var_2_7._type = Data.UnionJoinType.any

	var_2_7._label:setString(Str(STR.UNION_TYPE_ANY))

	function var_2_7._callback()
		local function var_8_0(arg_9_0, arg_9_1, arg_9_2)
			return {
				_str = arg_9_1,
				_handler = function()
					arg_9_0._type = arg_9_2

					arg_9_0._label:setString(arg_9_1)
				end
			}
		end

		local var_8_1 = {}

		for iter_8_0 = 0, 2 do
			table.insert(var_8_1, var_8_0(var_2_7, Str(STR.UNION_TYPE_ANY + iter_8_0), Data.UnionJoinType.any + iter_8_0))
		end

		arg_2_0:popSelectPanel(var_2_7, var_8_1)
	end

	arg_2_0._btnJoinType = var_2_7

	local var_2_9 = lc.createSprite("img_glow")

	lc.addChildToPos(arg_2_0, var_2_9, cc.p(lc.left(arg_2_0._iptName) - 270, lc.h(arg_2_0) - 116))

	local var_2_10 = ClientView.createBadge(1, "")

	lc.addChildToPos(arg_2_0, var_2_10, cc.p(lc.x(var_2_9), lc.y(var_2_9) - 10))

	arg_2_0._flagIcon = var_2_10
	arg_2_0._iptWord = var_2_0(Str(STR.UNION_WORD), lc.x(var_2_9) - 20, lc.top(var_2_7), Str(STR.UNION_WORD_TIP), 100)

	arg_2_0._iptWord:registerScriptEditBoxHandler(function(arg_11_0)
		if arg_11_0 == "changed" then
			arg_2_0:updateFlagPreview()
		end
	end)

	local var_2_11 = ClientView.createTTF(Str(STR.SELECT_UNION_BADGE), ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)

	lc.addChildToPos(arg_2_0, var_2_11, cc.p(lc.w(arg_2_0) / 2, lc.bottom(var_2_7) - 40))

	local var_2_12 = 1140
	local var_2_13 = lc.List.createH(cc.size(math.min(lc.w(arg_2_0) + 10, var_2_12), 215), 40, 60)

	var_2_13:setAnchorPoint(0.5, 0.5)

	if var_2_12 <= lc.w(var_2_13) then
		var_2_13:setBounceEnabled(false)
	end

	lc.addChildToPos(arg_2_0, var_2_13, cc.p(lc.w(arg_2_0) / 2, lc.bottom(var_2_11) - 10 - lc.h(var_2_13) / 2))

	for iter_2_0 = 1, 5 do
		local var_2_14 = ClientView.createShaderButton(nil, function()
			arg_2_0._flag = iter_2_0

			arg_2_0:updateFlagPreview()
		end)
		local var_2_15 = ClientView.createBadge(iter_2_0)

		var_2_14:setContentSize(var_2_15:getContentSize())
		lc.addChildToCenter(var_2_14, var_2_15)
		var_2_13:pushBackCustomItem(var_2_14)
	end

	arg_2_0._flag = 1

	local function var_2_16(arg_13_0)
		local var_13_0 = arg_2_0._btnLevelRequire

		var_13_0._level = arg_13_0

		if arg_13_0 <= P._playerCity:getUnionUnlockLevel() then
			var_13_0._label:setString(Str(STR.NO_REQUIREMENT))
		else
			var_13_0._label:setString(string.format("%s %d", Str(STR.LORD_LEVEL), arg_13_0))
		end
	end

	local function var_2_17(arg_14_0)
		local var_14_0 = arg_2_0._btnJoinType

		var_14_0._type = arg_14_0

		var_14_0._label:setString(Str(STR.UNION_TYPE_ANY + arg_14_0 - Data.UnionJoinType.any))
	end

	if arg_2_1 == var_0_0.Mode.create then
		local var_2_18

		if P:getItemCount(Data.PropsId.union_create) > 0 then
			var_2_18 = ClientView.createResConsumeButtonArea(160, "img_icon_props_s7038", ClientView.COLOR_RES_LABEL_BG_LIGHT, 1, Str(STR.CREATE_UNION))
		else
			var_2_18 = ClientView.createResConsumeButtonArea(160, "img_icon_res3_s", ClientView.COLOR_RES_LABEL_BG_LIGHT, tostring(Data._globalInfo._createUnionIngot), Str(STR.CREATE_UNION))
		end

		function var_2_18._btn._callback()
			arg_2_0:createUnion()
		end

		lc.addChildToPos(arg_2_0, var_2_18, cc.p(lc.w(arg_2_0) / 2, 20 + lc.h(var_2_18) / 2))
		var_2_16(P._playerCity:getUnionUnlockLevel())
		var_2_17(Data.UnionJoinType.any)
	else
		local var_2_19 = ClientView.createScale9ShaderButton("img_btn_1", function()
			arg_2_0:changeInfo(true)
		end, ClientView.CRECT_BUTTON, 160)

		var_2_19:addLabel(Str(STR.CHANGE) .. Str(STR.INFO))
		lc.addChildToPos(arg_2_0, var_2_19, cc.p(lc.w(arg_2_0) / 2, lc.h(var_2_19) / 2))

		local var_2_20 = P._playerUnion:getMyUnion()

		arg_2_0._iptName:setText(var_2_20._name)
		arg_2_0._iptDesc:setText(var_2_20._announce)
		arg_2_0._iptWord:setText(var_2_20._word)

		arg_2_0._flag = var_2_20._badge

		var_2_16(var_2_20._reqLevel)
		var_2_17(var_2_20._joinType)
	end

	arg_2_0:updateFlagPreview()
end

function var_0_0.popSelectPanel(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = require("TopMostPanel").ButtonList.create(var_0_3)

	if var_17_0 then
		local var_17_1 = lc.convertPos(cc.p(lc.w(arg_17_1) / 2, lc.h(arg_17_1) / 2), arg_17_1)

		var_17_0:setButtonDefs(arg_17_2)
		var_17_0:setPosition(var_17_1.x, var_17_1.y - lc.h(var_17_0) / 2 - 24)
		var_17_0:linkNode(arg_17_1)
		var_17_0:show()
	end
end

function var_0_0.updateFlagPreview(arg_18_0)
	arg_18_0._flagIcon:update(arg_18_0._flag, arg_18_0:getFlagWord())
end

function var_0_0.getFlagWord(arg_19_0)
	return lc.getUtf8Char(arg_19_0._iptWord:getText(), 1)
end

function var_0_0.createUnion(arg_20_0)
	if not arg_20_0._iptName:isValidName() then
		ToastManager.push(Str(STR.INPUT_NAME_INVALID))

		return
	end

	local var_20_0 = string.trim(arg_20_0._iptName:getText())
	local var_20_1 = arg_20_0._iptDesc:getText()

	if lc.utf8len(var_20_1) > ClientData.MAX_INPUT_LEN then
		ToastManager.push(Str(STR.UNION_SUMMARY) .. string.format(Str(STR.CANNOT_MORE_THAN), ClientData.MAX_INPUT_LEN))

		return
	end

	local var_20_2 = arg_20_0:getFlagWord()

	if var_20_2 == "" then
		ToastManager.push(Str(STR.INPUT_UNION_WORD))

		return
	end

	if P:getItemCount(Data.PropsId.union_create) <= 0 and not ClientView.checkIngot(Data._globalInfo._createUnionIngot) then
		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendCreateUnion(var_20_0, var_20_1, arg_20_0._btnLevelRequire._level, arg_20_0._btnJoinType._type, arg_20_0._flag, var_20_2)
end

function var_0_0.changeInfo(arg_21_0, arg_21_1)
	local var_21_0 = P._playerUnion:getMyUnion()
	local var_21_1 = 0
	local var_21_2 = string.trim(arg_21_0._iptName:getText())
	local var_21_3 = var_21_2 ~= var_21_0._name

	if not arg_21_0._iptName:isValidName() then
		ToastManager.push(Str(STR.INPUT_NAME_INVALID))

		return
	elseif var_21_3 then
		var_21_1 = var_21_1 + Data._globalInfo._editUnionNameIngot
	end

	local var_21_4 = arg_21_0._iptDesc:getText()

	if lc.utf8len(var_21_4) > ClientData.MAX_INPUT_LEN then
		ToastManager.push(Str(STR.UNION_SUMMARY) .. string.format(Str(STR.CANNOT_MORE_THAN), ClientData.MAX_INPUT_LEN))

		return
	end

	local var_21_5 = arg_21_0:getFlagWord()
	local var_21_6 = var_21_5 ~= var_21_0._word or arg_21_0._flag ~= var_21_0._badge

	if var_21_5 == "" then
		ToastManager.push(Str(STR.INPUT_UNION_WORD))

		return
	elseif var_21_6 then
		var_21_1 = var_21_1 + Data._globalInfo._editUnionTagIngot
	end

	if var_21_1 > 0 and arg_21_1 then
		require("PromptForm").ConfirmEditUnion.create(var_21_3, var_21_6, function()
			arg_21_0:changeInfo()
		end):show()

		return
	end

	if not ClientView.checkIngot(var_21_1) then
		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING), nil, function()
		P:changeResource(Data.ResType.ingot, -var_21_1)

		P._playerUnion._hasDetailInfo = false
	end)
	ClientData.sendChangeUnion(var_21_2, var_21_4, arg_21_0._btnLevelRequire._level, arg_21_0._btnJoinType._type, arg_21_0._flag, var_21_5)
end

return var_0_0
