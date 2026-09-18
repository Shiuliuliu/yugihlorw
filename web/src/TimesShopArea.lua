local var_0_0 = class("TimesShopArea", lc.ExtendCCNode)
local var_0_1 = require("CardInfoPanel")

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_2, arg_1_3)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanUp()
		end
	end)
	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._curRecruitInfo = arg_3_2
	arg_3_0._packageCards = {}
	arg_3_0._tavernScene = arg_3_1

	ClientData.addMsgListener(arg_3_0, function(arg_4_0)
		return arg_3_0:onMsg(arg_4_0)
	end, 0)

	local var_3_0 = lc.createSpriteWithMask("res/jpg/times_limit_chest.jpg")

	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 40))
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendCardBoxInfo(arg_3_2._value)

	local var_3_1 = lc.createNode()

	lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 20))

	arg_3_0._cardsNode = var_3_1

	local var_3_2 = ClientData.getPropIconName(Data.PropsId.times_package_ticket)
	local var_3_3 = arg_3_2._param[2]
	local var_3_4 = ClientView.createResConsumeButton(230, 100, var_3_2, var_3_3, Str(STR.SETTING_OPEN), "img_btn_1_s")

	lc.offset(var_3_4._resArea, 0, -10)
	lc.offset(var_3_4._label, 0, -10)
	lc.addChildToPos(arg_3_0, var_3_4, cc.p(lc.cw(arg_3_0), lc.bottom(var_3_0) - lc.ch(var_3_4) - 0))
	var_3_4:setDisabledShader(ClientView.SHADER_DISABLE)

	function var_3_4._callback()
		arg_3_0:sendBuyPackage()
	end

	arg_3_0._btn = var_3_4

	local var_3_5 = 5
	local var_3_6 = ClientView.createTTF(string.format(Str(STR.REMAIN_BUY_TIMES), var_3_5), ClientView.FontSize.S1)

	lc.addChildToPos(var_3_0, var_3_6, cc.p(lc.cw(var_3_0), 45))

	arg_3_0._remainNumLabel = var_3_6

	local var_3_7 = ClientData.getValidActivityByParam(arg_3_2._value - 200000, true)
	local var_3_8 = ClientView.createBMFont(ClientView.BMFont.huali_26, ClientData.getActivityDurationStr(var_3_7))

	lc.addChildToPos(arg_3_0, var_3_8, cc.p(lc.cw(arg_3_0), lc.h(arg_3_0) - 20))
end

function var_0_0.showCardBox(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._packageCards) do
		local var_6_1 = require("CardThumbnail").create(iter_6_1._infoId, 0.65)
		local var_6_2 = ClientView.createShaderButton(nil, function(arg_7_0)
			var_0_1.create(iter_6_1._infoId, 1, var_0_1.OperateType.view):show()
		end)

		var_6_2:setContentSize(var_6_1:getContentSize())
		lc.addChildToCenter(var_6_2, var_6_1)
		table.insert(var_6_0, var_6_2)
	end

	lc.addNodesToCenter(arg_6_0._cardsNode, var_6_0, 20)
	arg_6_0:refreshView()
end

function var_0_0.refreshView(arg_8_0)
	local var_8_0 = arg_8_0._curRecruitInfo._param[2]

	arg_8_0._btn._resLabel:setColor(P._propBag:hasProps(Data.PropsId.times_package_ticket, var_8_0) and ClientView.COLOR_TEXT_WHITE or ClientView.COLOR_TEXT_RED)

	local var_8_1 = 5

	for iter_8_0, iter_8_1 in pairs(arg_8_0._packageCards) do
		var_8_1 = var_8_1 - P._playerCard:getCardCount(iter_8_1._infoId)
	end

	arg_8_0._remainNumLabel:setString(string.format(Str(STR.REMAIN_BUY_TIMES), var_8_1))
end

function var_0_0.onMsg(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.type
	local var_9_1 = arg_9_1.status

	if var_9_0 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY then
		if arg_9_0._tavernScene._detailInfoOnce then
			return false
		end

		local var_9_2 = {}
		local var_9_3 = {}
		local var_9_4 = arg_9_1.Extensions[Card_pb.SglCardMsg.card_lottery_resp]

		for iter_9_0, iter_9_1 in ipairs(var_9_4) do
			local var_9_5 = Data.getType(iter_9_1.info_id)

			if P._playerCard:addCard(iter_9_1.info_id, iter_9_1.num) then
				var_9_3[var_9_5] = true
			end

			table.insert(var_9_2, {
				_infoId = iter_9_1.info_id,
				_num = iter_9_1.num
			})
		end

		for iter_9_2 in pairs(var_9_3) do
			P._playerCard:sendCardListDirty(iter_9_2)
		end

		ClientView.getActiveIndicator():hide()
		require("RewardCardPanel").create(Str(STR.GET) .. Str(STR.CARD), var_9_2):show()
		lc.Audio.playAudio(AUDIO.E_CARD_GET)
		arg_9_0:refreshView()
	elseif var_9_0 == SglMsgType_pb.PB_TYPE_CARDBOX_INFO then
		if arg_9_0._tavernScene._detailInfoOnce then
			return false
		end

		local var_9_6 = arg_9_1.Extensions[Card_pb.SglCardMsg.card_box_info_resp]

		arg_9_0._packageCards = {}

		for iter_9_3 = 1, #var_9_6 do
			arg_9_0._packageCards[iter_9_3] = {
				_infoId = var_9_6[iter_9_3].info_id,
				_getNum = var_9_6[iter_9_3].get_num,
				_remainNum = var_9_6[iter_9_3].remain_num
			}
		end

		ClientView.getActiveIndicator():hide()
		arg_9_0:showCardBox()
	end

	return false
end

function var_0_0.sendBuyPackage(arg_10_0)
	lc.Audio.playAudio(AUDIO.E_TAVERN_BUY_PACKAGE)

	local var_10_0 = arg_10_0._curRecruitInfo
	local var_10_1 = 5

	for iter_10_0, iter_10_1 in pairs(arg_10_0._packageCards) do
		var_10_1 = var_10_1 - P._playerCard:getCardCount(iter_10_1._infoId)
	end

	local var_10_2 = var_10_0._param[2]

	if not P._propBag:hasProps(Data.PropsId.times_package_ticket, var_10_2) then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._propsInfo[Data.PropsId.times_package_ticket]._nameSid)))
		require("ExchangeResForm").create(Data.PropsId.times_package_ticket):show()

		return false
	elseif var_10_1 <= 0 then
		ToastManager.push(Str(STR.TIMES_NOT_ENOUGH))

		return false
	else
		ClientView.getActiveIndicator():show(Str(STR.RECRUITING))
		ClientData.sendCardLottery(var_10_0._value, false, true)
		P._propBag:changeProps(Data.PropsId.times_package_ticket, -var_10_2)
		arg_10_0:refreshView()
	end
end

function var_0_0.onEnter(arg_11_0)
	arg_11_0:refreshView()

	local var_11_0 = {}

	table.insert(var_11_0, lc.addEventListener(Data.Event.prop_dirty, function(arg_12_0)
		if arg_12_0._data._infoId == Data.PropsId.times_package_ticket then
			arg_11_0:refreshView()
		end
	end))

	arg_11_0._listeners = var_11_0
end

function var_0_0.onExit(arg_13_0)
	return
end

function var_0_0.onCleanUp(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_14_1)
	end

	ClientData.removeMsgListener(arg_14_0)
	lc.TextureCache:removeTextureForKey("res/jpg/times_limit_chest.jpg")
end

return var_0_0
