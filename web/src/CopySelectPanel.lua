local var_0_0 = require("BasePanel")
local var_0_1 = class("CopySelectPanel", var_0_0)
local var_0_2 = 1016
local var_0_3 = 644
local var_0_4 = {
	cc.p(0, 0),
	cc.p(0.5, 1),
	cc.p(0.5, 0),
	cc.p(1, 0)
}
local var_0_5 = {
	cc.p(0, 0),
	cc.p(var_0_2 / 2 - 7, var_0_3 + 4),
	cc.p(var_0_2 / 2 - 20, 0),
	cc.p(var_0_2, 0)
}
local var_0_6 = {
	cc.p(0.5, 0),
	cc.p(0.5, 1),
	cc.p(0.5, 0),
	cc.p(0.5, 0)
}
local var_0_7 = {
	Data.CopyType.elite,
	Data.CopyType.boss,
	Data.CopyType.commander,
	Data.CopyType.expedition
}
local var_0_8 = {
	[Data.CopyType.elite] = Data._globalInfo._unlockRobExp,
	[Data.CopyType.boss] = Data._globalInfo._unlockRobGold,
	[Data.CopyType.commander] = Data._globalInfo._unlockCommander,
	[Data.CopyType.expedition] = Data._globalInfo._unlockExpedition
}

function var_0_1.create(arg_1_0)
	local var_1_0 = var_0_1.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1)
	var_0_1.super.init(arg_2_0, true)
	ClientData.loadLCRes("res/copy.lcres")

	arg_2_0._panelName = "CopySelectPanel"
	arg_2_0._focusCopyGroup = arg_2_1
	ClientView._copySelectPanel = arg_2_0

	local var_2_0 = cc.Node:create()

	var_2_0:setContentSize(var_0_2, var_0_3)
	lc.addChildToCenter(arg_2_0, var_2_0)

	arg_2_0._copyArea = var_2_0
	arg_2_0._copySprites = {}

	for iter_2_0 = 1, 4 do
		arg_2_0:createCopySprite(iter_2_0)
	end

	return true
end

function var_0_1.onEnter(arg_3_0)
	var_0_1.super.onEnter(arg_3_0)

	local var_3_0 = {}

	table.insert(var_3_0, lc.addEventListener(GuideManager.Event.seek, function(arg_4_0)
		arg_3_0:onGuide(arg_4_0)
	end))

	arg_3_0._listeners = var_3_0

	if GuideManager.isGuideEnabled() and GuideManager.getCurStepName() == "enter select copy" then
		GuideManager.finishStepLater()
	end
end

function var_0_1.onExit(arg_5_0)
	var_0_1.super.onExit(arg_5_0)

	for iter_5_0 = 1, #arg_5_0._listeners do
		lc.Dispatcher:removeEventListener(arg_5_0._listeners[iter_5_0])
	end
end

function var_0_1.onCleanup(arg_6_0)
	var_0_1.super.onCleanup(arg_6_0)
	ClientData.unloadLCRes({
		"copy.jpm",
		"copy.png.sfb"
	})
end

function var_0_1.createCopySprite(arg_7_0, arg_7_1)
	local var_7_0 = ClientView.createTouchSpriteWithShader(string.format("img_copy_%02d", arg_7_1), function(arg_8_0)
		arg_7_0:onSelectCopy(arg_8_0)
	end)

	var_7_0._copyType = var_0_7[arg_7_1]

	var_7_0:setAnchorPoint(var_0_4[arg_7_1])
	lc.addChildToPos(arg_7_0._copyArea, var_7_0, var_0_5[arg_7_1])

	arg_7_0._copySprites[arg_7_1] = var_7_0
end

function var_0_1.onSelectCopy(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1._copyType

	if P._level < var_0_8[var_9_0] then
		ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), var_0_8[var_9_0]))

		return
	end

	if var_9_0 == nil then
		ToastManager.push(Str(STR.NOT_OPENED))

		return
	end

	if GuideManager.isGuideEnabled() then
		GuideManager.finishStep()
	end

	require("SelectLevelForm").create(var_9_0):show()
end

function var_0_1.onGuide(arg_10_0, arg_10_1)
	local var_10_0 = GuideManager.getCurStepName()

	if string.sub(var_10_0, 1, 10) == "enter copy" then
		local var_10_1 = tonumber(string.sub(var_10_0, 11, 12))

		GuideManager.setOperateLayer(arg_10_0._copySprites[var_10_1])

		return
	end

	arg_10_1:stopPropagation()
end

return var_0_1
