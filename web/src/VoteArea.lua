local var_0_0 = class("VoteArea", lc.ExtendCCNode)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0)
	var_1_0:init(arg_1_1)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanup()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._actType = arg_3_1
	arg_3_0._actInfo = ClientData.getValidActivityByType(arg_3_0._actType + 1)
	arg_3_0._voteActInfo = ClientData.getValidActivityByType(arg_3_0._actType)
	arg_3_0._voteType = arg_3_0._actInfo._param1[1]
	arg_3_0._stage = arg_3_0._voteType
	arg_3_0._exchange = Data._exchangeInfo[970]

	local var_3_0 = lc.List.createV(arg_3_0:getContentSize(), 0, -3)

	lc.addChildToCenter(arg_3_0, var_3_0)

	arg_3_0._list = var_3_0
end

function var_0_0.refreshList(arg_4_0)
	local var_4_0 = arg_4_0._list

	var_4_0:removeAllItems()

	local var_4_1 = lc.formatJpg(arg_4_0._actInfo._img)

	lc.TextureCache:addImageWithMask(var_4_1)

	local var_4_2 = lc.createImageView(var_4_1)

	var_4_0:pushBackCustomItem(var_4_2)

	if #Data._voteRankInfo > 0 then
		local var_4_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_5_0)
			require("VotePreForm").create():show()
		end, ClientView.CRECT_BUTTON, 200)

		lc.addChildToPos(var_4_2, var_4_3, cc.p(lc.cw(var_4_2) + 230, 130))

		local var_4_4 = ClientView.createTTF(Str(STR.VOTE_PRE), ClientView.FontSize.M1)

		var_4_4:enableOutline(lc.Color3B.black, 2)
		lc.addChildToCenter(var_4_3, var_4_4)
	end

	local var_4_5 = ClientView.createTTF(string.format(Str(STR.VOTE_STAGE), arg_4_0._stage))

	lc.addChildToPos(var_4_2, var_4_5, cc.p(780, 60))

	local var_4_6 = Str(STR.ANNOUNCE_PERIOD)

	if arg_4_0._voteActInfo then
		local var_4_7, var_4_8 = ClientData.getActivityDurationStr(arg_4_0._voteActInfo, true, false)

		var_4_6 = var_4_7 .. "-" .. var_4_8
	end

	local var_4_9 = ClientView.createTTF(var_4_6)

	lc.addChildToPos(var_4_2, var_4_9, cc.p(780, 30))

	local var_4_10 = {}

	for iter_4_0, iter_4_1 in pairs(Data._voteInfo) do
		if iter_4_1._time == arg_4_0._voteType then
			var_4_10[#var_4_10 + 1] = iter_4_1
		end
	end

	table.sort(var_4_10, function(arg_6_0, arg_6_1)
		return arg_6_0._id < arg_6_1._id
	end)

	arg_4_0._items = {}

	for iter_4_2 = 1, #var_4_10 do
		local var_4_11 = arg_4_0:setOrCreateItem(nil, var_4_10[iter_4_2])

		var_4_0:pushBackCustomItem(var_4_11)

		arg_4_0._items[#arg_4_0._items + 1] = var_4_11
	end
end

function var_0_0.setOrCreateItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == nil then
		arg_7_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35,
			_size = cc.size(750, 108)
		})

		local var_7_0 = IconWidget.create({
			_infoId = 10001
		}, 0)

		var_7_0:setScale(0.9)
		lc.addChildToPos(arg_7_1, var_7_0, cc.p(lc.sw(var_7_0) / 2 + 10, lc.ch(arg_7_1) + 5))

		local var_7_1 = ClientView.createTTF("", ClientView.FontSize.M2, lc.Color3B.black)

		var_7_1:setAnchorPoint(0, 0.5)
		lc.addChildToPos(arg_7_1, var_7_1, cc.p(lc.cw(arg_7_1) - 150, lc.ch(arg_7_1)))

		local var_7_2 = ClientView.createTTF("", ClientView.FontSize.M2, lc.Color3B.black)

		var_7_2:setAnchorPoint(0, 0.5)
		lc.addChildToPos(arg_7_1, var_7_2, cc.p(lc.cw(arg_7_1) + 50, lc.ch(arg_7_1)))

		local var_7_3 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_8_0)
			if not ClientData.getValidActivityByType(arg_7_0._actType) then
				return ToastManager.push(Str(STR.VOTE_DEADLINE_TIP))
			end

			local var_8_0 = arg_7_0._exchange
			local var_8_1 = var_8_0._reward
			local var_8_2 = Data._bonusInfo[var_8_1]
			local var_8_3 = var_8_2._rid[1]
			local var_8_4 = P._playerMarket:getExchangeMaxCount(var_8_0)

			if var_8_4 <= 0 then
				return ToastManager.push(Str(STR.EXCHANGE_ITEM_NOT_ENOUGH))
			else
				local function var_8_5(arg_9_0, arg_9_1)
					arg_9_1 = arg_9_1 or 1

					P._playerMarket:exchangeProp(var_8_0, arg_9_1, nil, true)

					if arg_9_0 then
						arg_9_0[var_8_3] = (arg_9_0[var_8_3] or 0) + var_8_2._count[1] * arg_9_1
					else
						local var_9_0 = require("RewardPanel")

						var_9_0.create({
							{
								info_id = var_8_3,
								num = var_8_2._count[1] * arg_9_1
							}
						}, var_9_0.MODE_EXCHANGE):show()
					end
				end

				return require("GetNumberForm").create({
					_titleStr = Str(STR.VOTE_TIP),
					_maxCount = var_8_4
				}, function(arg_10_0, arg_10_1)
					P:vote(arg_7_0._stage, arg_7_1._id, arg_10_0)

					local var_10_0 = {}

					var_8_5(var_10_0, arg_10_0)

					local var_10_1 = {}

					for iter_10_0, iter_10_1 in pairs(var_10_0) do
						var_10_1[#var_10_1 + 1] = {
							info_id = iter_10_0,
							num = iter_10_1
						}
					end

					local var_10_2 = require("RewardPanel")

					var_10_2.create(var_10_1, var_10_2.MODE_EXCHANGE):show()

					for iter_10_2, iter_10_3 in ipairs(arg_7_0._items) do
						arg_7_0:setOrCreateItem(iter_10_3, iter_10_3._info)
					end
				end):show()
			end
		end, ClientView.CRECT_BUTTON_S, 100)
		local var_7_4 = ClientView.createTTF(Str(STR.VOTE), ClientView.FontSize.M2)

		var_7_4:enableOutline(lc.Color3B.black, 1)
		lc.addChildToCenter(var_7_3, var_7_4)
		lc.addChildToPos(arg_7_1, var_7_3, cc.p(lc.w(arg_7_1) - lc.cw(var_7_3) - 10, lc.ch(arg_7_1)))

		function arg_7_1.update(arg_11_0)
			arg_7_1._info = arg_11_0
			arg_7_1._id = arg_11_0._id

			local var_11_0 = arg_11_0._cardId
			local var_11_1 = 0
			local var_11_2 = 0

			for iter_11_0, iter_11_1 in ipairs(P._voteRecord) do
				if iter_11_1._infoId == arg_11_0._id then
					var_11_1 = iter_11_1._num
					var_11_2 = iter_11_0
				end
			end

			var_7_0:resetData({
				_infoId = var_11_0
			}, 0)
			var_7_1:setString(Str(STR.VOTE_NUM) .. Str(STR.COLON) .. ClientData.formatNum(var_11_1, 9999999))
			var_7_2:setString(Str(STR.RANK) .. Str(STR.COLON) .. (var_11_2 == 0 and Str(STR.VOID) or var_11_2))
		end
	end

	arg_7_1.update(arg_7_2)

	return arg_7_1
end

function var_0_0.onEnter(arg_12_0)
	ClientView.getResourceUI():setMode(Data.PropsId.vote_shop_token)

	arg_12_0._listeners = {}

	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.vote_dirty, function(arg_13_0)
		if arg_12_0._indicator then
			arg_12_0._indicator:removeFromParent()

			arg_12_0._indicator = nil
		end

		arg_12_0:refreshList()
	end))

	if P:sendVoteRequest(arg_12_0._stage) then
		arg_12_0._indicator = ClientView.showPanelActiveIndicator(arg_12_0)
	else
		arg_12_0:refreshList()
	end
end

function var_0_0.onExit(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_14_1)
	end
end

function var_0_0.onCleanup(arg_15_0)
	return
end

return var_0_0
