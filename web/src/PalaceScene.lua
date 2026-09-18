local var_0_0 = class("PalaceScene", BaseUIScene)
local var_0_1 = require("PalaceTaskArea")
local var_0_2 = require("PalaceVisitArea")
local var_0_3 = require("PalaceSmithArea")
local var_0_4 = "res/jpg/palace_bg.jpg"

var_0_0.TAB = {
	smith = 3,
	task = 1,
	visit = 2
}

function var_0_0.create()
	return lc.createScene(var_0_0)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.palace, STR.SID_FIXITY_NAME_1001, BaseUIScene.STYLE_EMPTY, true) then
		return false
	end

	local var_2_0 = lc.createSprite(var_0_4)
	local var_2_1 = lc.w(arg_2_0) / lc.w(var_2_0)
	local var_2_2 = lc.bottom(arg_2_0._titleArea) / lc.h(var_2_0)

	var_2_0:setScale(var_2_2 < var_2_1 and var_2_1 or var_2_2)
	var_2_0:setPosition(lc.w(arg_2_0) / 2, lc.sh(var_2_0) / 2)
	arg_2_0:addChild(var_2_0)
	arg_2_0:initTabArea()
	arg_2_0._tabArea:showTab(var_0_0.TAB.task)

	return true
end

function var_0_0.syncData(arg_3_0)
	var_0_0.super.syncData(arg_3_0)
	arg_3_0:showTab(arg_3_0._tabArea._focusedTab)
end

function var_0_0.initTabArea(arg_4_0)
	local var_4_0 = {
		{
			_index = var_0_0.TAB.task,
			_str = Str(STR.PALACE_REVIEW)
		},
		{
			_index = var_0_0.TAB.visit,
			_str = Str(STR.PALACE_VISIT)
		}
	}
	local var_4_1 = ClientView.createVerticalTabListArea(lc.bottom(arg_4_0._titleArea) + 10, var_4_0, function(arg_5_0, arg_5_1, arg_5_2)
		if not arg_5_1 or arg_5_2 then
			arg_4_0:showTab(arg_5_0)
		end
	end)

	lc.addChildToPos(arg_4_0, var_4_1, cc.p(lc.w(var_4_1) / 2 - 4, lc.bottom(arg_4_0._titleArea) / 2 + 2))

	arg_4_0._tabArea = var_4_1
end

function var_0_0.showTab(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._contentArea

	if var_6_0 then
		if var_6_0._linkObjs then
			for iter_6_0, iter_6_1 in ipairs(var_6_0._linkObjs) do
				iter_6_1:removeFromParent()
			end
		end

		var_6_0:removeFromParent()

		arg_6_0._contentArea = nil
	end

	local var_6_1 = lc.w(arg_6_0) - ClientView.VERTICAL_TAB_WIDTH + 4
	local var_6_2, var_6_3, var_6_4 = lc.bottom(arg_6_0._titleArea)

	if arg_6_1._index == var_0_0.TAB.task then
		var_6_3 = var_0_1.create(var_6_1, var_6_2)
	elseif arg_6_1._index == var_0_0.TAB.visit then
		var_6_3 = var_0_2.create(var_6_1, var_6_2)
	elseif arg_6_1._index == var_0_0.TAB.smith then
		-- block empty
	end

	if var_6_3 then
		lc.addChildToPos(arg_6_0, var_6_3, cc.p((lc.w(arg_6_0) + ClientView.VERTICAL_TAB_WIDTH) / 2 - 4, var_6_4 or lc.h(var_6_3) / 2))

		arg_6_0._contentArea = var_6_3
	end
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)

	arg_7_0._listeners = {}

	local var_7_0 = lc.addEventListener(Data.Event.palace_visit_dirty, function(arg_8_0)
		arg_7_0:showTabFlag()
	end)

	table.insert(arg_7_0._listeners, var_7_0)
	arg_7_0:showTabFlag()
end

function var_0_0.onExit(arg_9_0)
	var_0_0.super.onExit(arg_9_0)

	for iter_9_0 = 1, #arg_9_0._listeners do
		lc.Dispatcher:removeEventListener(arg_9_0._listeners[iter_9_0])
	end
end

function var_0_0.onCleanup(arg_10_0)
	var_0_0.super.onCleanup(arg_10_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(var_0_4))
end

function var_0_0.showTabFlag(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._tabArea._list:getItems()

	if arg_11_1 == nil or arg_11_1 == var_0_0.TAB.task then
		local var_11_1 = P._playerPalace:getFinishedTaskNumber()

		ClientView.checkNewFlag(var_11_0[1], var_11_1)
	end

	if arg_11_1 == nil or arg_11_1 == var_0_0.TAB.visit then
		local var_11_2 = P._playerPalace._visit
		local var_11_3 = var_11_2 and not var_11_2:isFinished() and 1 or 0

		ClientView.checkNewFlag(var_11_0[2], var_11_3)
	end
end

function var_0_0.onGuide(arg_12_0, arg_12_1)
	local var_12_0 = GuideManager.getCurStepName()

	if string.find(var_12_0, "palace reviewdetail") then
		local var_12_1 = tonumber(var_12_0:split(" ")[3])

		GuideManager.setOperateLayer(arg_12_0._contentArea._list:getItem(var_12_1)._btnDetail)
	else
		return
	end

	arg_12_1:stopPropagation()
end

return var_0_0
