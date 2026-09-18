local var_0_0 = class("InvitePanel", lc.ExtendUIWidget)

var_0_0.TAB = {
	activity = 3,
	my = 1,
	accept = 2
}

local var_0_1 = {
	kupai = "http://www.coolmart.net.cn/components/detail.html?pid=300067",
	tt = "http://app.52tt.com/project/guild/index.html?pageName=index-game-area-page&gid=296346",
	huawei = "http://a.vmall.com/app/C100012785?shareTo=com.tencent.mobileqq&shareFrom=gamebox&accountId=260086000062793105",
	anzhi = "http://fx.anzhi.com/share_2861407.html?azfrom=qqfriend",
	jinli = "https://game.gionee.com/index/detail/?id=9553&isShare=1&intersrc=shareH5&t_bi=&cv=g172al&sf=mobileqq",
	ay = "http://www.ay99.net/",
	lenovo = "http://www.lenovomm.com/appdetail/com.tuoyin.jdzc.lenovo/0#com.tencent.mobileqq",
	cc = "http://m.ccplay.cc/",
	meizu = "http://app.flyme.cn/games/public/detail?package_name=com.leocool.yugioh.mz",
	pptv = "http://game.g.pptv.com/wxwap/detail/?gid=jdzc_m&from=timeline&isappinstalled=1",
	vivo = "http://appstore.vivo.com.cn/appinfo/downloadApkFile?id=1853963",
	sogou = "http://g.sogou.com/game/detail.html?appid=49429",
	nubia = "https://c1-appstore.nubia.com/data/upload/apk/2017/9/30/4a7967bf51599d476020f41ce645379d.apk",
	baidu = "https://mobile.baidu.com/item?docid=22419822&source=s1001",
	sina = "http://mg.games.sina.com.cn/kjava/gamecenter/package/504585/504585_120_100010041000.apk",
	samsung = "http://apps.samsung.com/appquery/appDetail.as?appId=",
	uc = "http://gdl.25pp.com/s/6/6/20171207173454a21ec2_ucsdk_jdzc_.apk?x-oss-process=udf/uc-apk,BiLDjEhXWg==db9d9f7459fc7a11&cc=1281277477&vh=06d8c21b18e5953c29b5dcb03dfd2f9c&sf=150144084",
	papa = "https://sdtuis.papa91.com/ac/v/8AwjMt",
	iqiyi = "http://cdn.data.video.iqiyi.com/cdn/ppsgame/20171010/upload/unite/game/20171010/jdzc_PPS_GAME_6.apk",
	mzw = "http://m.muzhiwan.com/com.tuoyin.jdzc.mzw.html",
	xmw = "https://www.xmwan.com/game/1577.html",
	xiaomi = "http://game.xiaomi.com/app-appdetail--app_id__589477.html",
	huya = "https://mobilegamepackage1.bs2dl-ssl.yy.com/jdzc_1710120.apk",
	ewan = "http://download5.ewan.cn/AppDownload/App/Android/jdzc_10872/120/jdzc_ew120170639.apk",
	douyu = "https://apiv2.douyucdn.cn/H5/Mgame/appDetail?appId=10052&chan2Id=23&recId=1&type=promo",
	downjoy = "http://ng.d.cn/juedouzhicheng/"
}

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:setContentSize(arg_2_1)
	arg_2_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_2_0 = lc.createNode(arg_2_1)

	lc.addChildToCenter(arg_2_0, var_2_0)

	arg_2_0._contentArea = var_2_0

	local var_2_1
	local var_2_2

	if P:getMaxCharacterLevel() >= Data._globalInfo._inviteLevelUpperLimit then
		var_2_2 = {
			{
				_title = Str(STR.MY) .. Str(STR.INVITE),
				_index = var_0_0.TAB.my
			}
		}
	else
		var_2_2 = {
			{
				_title = Str(STR.ACCEPT) .. Str(STR.INVITE),
				_index = var_0_0.TAB.accept
			},
			{
				_title = Str(STR.MY) .. Str(STR.INVITE),
				_index = var_0_0.TAB.my
			}
		}
	end

	local var_2_3 = ClientData.getSubChannelName()

	if (var_0_1[var_2_3] ~= nil and lc.App.wxShare or ClientData.isDEV()) and ClientData.getValidActivityByType(106) then
		var_2_2[#var_2_2 + 1] = {
			_title = Str(STR.ACTIVITY) .. Str(STR.SHARE),
			_index = var_0_0.TAB.activity
		}
	end

	arg_2_0:addTabs(var_2_2, var_2_1)
end

function var_0_0.addTabs(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == nil or #arg_3_1 == 0 then
		return
	end

	if arg_3_0._tabs then
		for iter_3_0 = 1, #arg_3_0._tabs do
			arg_3_0._tabs[iter_3_0]:removeFromParent(true)
		end
	end

	local var_3_0 = 720 / #arg_3_1

	arg_3_0._tabs = {}

	for iter_3_1 = 1, #arg_3_1 do
		local var_3_1 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_4_0)
			arg_3_0:showTab(arg_3_1[iter_3_1], false)
		end, ClientView.CRECT_BUTTON, 240)

		var_3_1._index = arg_3_1[iter_3_1]._index

		lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.cw(arg_3_0) + var_3_0 * (iter_3_1 - (#arg_3_1 + 1) / 2), 46))
		var_3_1:addLabel(arg_3_1[iter_3_1]._title)

		arg_3_0._tabs[arg_3_1[iter_3_1]._index] = var_3_1
	end

	arg_3_0:showTab(arg_3_1[arg_3_2 or 1], true)
end

function var_0_0.showTab(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._tabs[arg_5_1._index]

	if var_5_0 == nil or arg_5_0._focusTab == var_5_0 and not arg_5_2 then
		return false
	end

	arg_5_0._isSelfInvite, arg_5_0._focusTab = arg_5_1._index == var_0_0.TAB.my, var_5_0

	for iter_5_0, iter_5_1 in pairs(arg_5_0._tabs) do
		if iter_5_1 == arg_5_0._focusTab then
			iter_5_1:setColor(lc.Color3B.white)
			iter_5_1._label:setColor(lc.Color3B.white)
		else
			iter_5_1:setColor(cc.c3b(100, 100, 100))
			iter_5_1._label:setColor(cc.c3b(110, 170, 60))
		end
	end

	arg_5_0:refreshContent()

	return true
end

function var_0_0.refreshContent(arg_6_0)
	arg_6_0._contentArea:removeAllChildren()

	if arg_6_0._focusTab._index == var_0_0.TAB.my then
		arg_6_0:initSelf()
	elseif arg_6_0._focusTab._index == var_0_0.TAB.accept then
		arg_6_0:initAccpet()
	elseif arg_6_0._focusTab._index == var_0_0.TAB.activity then
		arg_6_0:initActivity()
	end
end

function var_0_0.initAccpet(arg_7_0)
	local var_7_0 = arg_7_0._contentArea
	local var_7_1 = "activity_invite_1"
	local var_7_2

	if ClientData.isAnotherSkin() then
		var_7_2 = cc.ShaderSprite:createWithFilename(lc.formatJpg(var_7_1 .. "_2"))
	end

	var_7_2 = var_7_2 or lc.createSprite(lc.formatJpg(var_7_1))

	lc.addChildToCenter(var_7_0, var_7_2)

	if P._invitedCode then
		local var_7_3 = arg_7_0._inviteInfo

		if var_7_3 then
			local var_7_4 = ClientView.createTTF(Str(STR.INVITED_WITH_PLAYER), ClientView.FontSize.S1, ClientView.COLOR_TEXT_ORANGE)

			lc.addChildToPos(var_7_0, var_7_4, cc.p(lc.cw(var_7_0) + 110, lc.ch(var_7_0) - 34))

			local var_7_5 = UserWidget.create(var_7_3, UserWidget.Flag.REGION_NAME_UNION)

			lc.addChildToPos(var_7_0, var_7_5, cc.p(lc.x(var_7_4), lc.bottom(var_7_4) - lc.ch(var_7_5) - 50))
			var_7_5._regionArea:setColor(ClientView.COLOR_TEXT_LIGHT)

			if var_7_5._unionArea then
				var_7_5._unionArea._name:setColor(lc.Color3B.yellow)
			end
		else
			arg_7_0._indicator = ClientView.showPanelActiveIndicator(var_7_0)

			ClientData.sendGetInviteInfo(P._invitedCode)
		end
	else
		local var_7_6 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(380, 60), Str(STR.INVITE_CODE), true)

		lc.addChildToPos(var_7_0, var_7_6, cc.p(lc.cw(var_7_0) + 110, lc.ch(var_7_0) - 34))

		arg_7_0._editor = var_7_6

		local var_7_7 = ClientView.createShaderButton("img_btn_recharge_3", function()
			arg_7_0:acceptInvite()
		end)

		var_7_7:addLabel(Str(STR.ACCEPT) .. Str(STR.INVITE))
		lc.addChildToPos(var_7_0, var_7_7, cc.p(lc.x(var_7_6), lc.ch(var_7_0) - 150))
	end
end

function var_0_0.initActivity(arg_9_0)
	local var_9_0 = arg_9_0._contentArea
	local var_9_1 = lc.createSprite("res/jpg/activity_invite_3.jpg")

	lc.addChildToCenter(var_9_0, var_9_1)

	local var_9_2 = {}
	local var_9_3 = lc.createNode()

	lc.addChildToPos(var_9_0, var_9_3, cc.p(lc.cw(var_9_0), 176))

	local var_9_4 = ClientData.getValidActivityByType(106)
	local var_9_5 = var_9_4 and var_9_4._bonusId[1] or nil

	if var_9_5 then
		local var_9_6 = Data._bonusInfo[var_9_5]

		for iter_9_0 = 1, #var_9_6._rid do
			local var_9_7 = IconWidget.create({
				_infoId = var_9_6._rid[iter_9_0],
				_count = var_9_6._count[iter_9_0]
			})

			var_9_7._name:setColor(lc.Color3B.white)
			var_9_7:setScale(0.9)

			var_9_2[#var_9_2 + 1] = var_9_7
		end
	end

	local var_9_8 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_10_0)
		local var_10_0 = ClientData.getSubChannelName()
		local var_10_1 = var_0_1[var_10_0]

		if lc.App.wxShare then
			lc.App:wxShare(true, var_10_1, string.format(Str(var_9_4._nameSid), string.upper(P._inviteCode)), Str(var_9_4._descSid), "share")
		elseif ClientData.isDEV() then
			local var_10_2 = cc.EventCustom:new(Data.Event.application)

			var_10_2:setUserString("WX_SHARE_OK")
			lc.Dispatcher:dispatchEvent(var_10_2)
		end
	end, ClientView.CRECT_BUTTON_S, 120)

	var_9_8._bonusId = var_9_5

	var_9_8:setDisabledShader(ClientView.SHADER_DISABLE)
	var_9_8:addLabel(Str(STR.SHARE))

	var_9_2[#var_9_2 + 1] = var_9_8

	lc.addNodesToCenter(var_9_3, var_9_2, 8)
	lc.offset(var_9_8, 10, 40)

	function var_9_8.updateShareBtn(arg_11_0)
		local var_11_0 = arg_11_0._bonusId
		local var_11_1 = P._playerBonus._bonusShare[var_11_0]

		if var_11_1._isClaimed then
			arg_9_0._claimBtn:setEnabled(false)
			arg_9_0._claimBtn._label:setString(Str(STR.CLAIMED))
		elseif var_11_1._value >= var_11_1._info._val then
			arg_9_0._claimBtn:setEnabled(true)
			arg_9_0._claimBtn._label:setString(Str(STR.CLAIM))
		else
			arg_9_0._claimBtn:setEnabled(false)
			arg_9_0._claimBtn._label:setString(Str(STR.CLAIM))
		end
	end

	arg_9_0._shareBtn = var_9_8

	local var_9_9 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_12_0)
		local var_12_0 = arg_12_0._bonusId
		local var_12_1 = P._playerBonus._bonusShare[var_12_0]

		if not var_12_1._isClaimed and var_12_1._value >= var_12_1._info._val then
			local var_12_2 = ClientData.claimBonus(var_12_1)

			ClientView.showClaimBonusResult(var_12_1, var_12_2)
			arg_9_0._shareBtn:updateShareBtn()
		end
	end, ClientView.CRECT_BUTTON_S, 120)

	var_9_9._bonusId = var_9_5

	var_9_9:setDisabledShader(ClientView.SHADER_DISABLE)
	var_9_9:addLabel(Str(STR.CLAIM))
	lc.addChildToPos(var_9_3, var_9_9, cc.p(lc.x(arg_9_0._shareBtn), lc.y(arg_9_0._shareBtn) - 66))

	arg_9_0._claimBtn = var_9_9

	arg_9_0._shareBtn:updateShareBtn()

	if P._inviteCode == nil then
		ClientData.sendGetInviteCode()
	end
end

function var_0_0.initSelf(arg_13_0)
	local var_13_0 = arg_13_0._contentArea
	local var_13_1 = "activity_invite_2"
	local var_13_2

	if ClientData.isAnotherSkin() then
		var_13_2 = cc.ShaderSprite:createWithFilename(lc.formatJpg(var_13_1 .. "_2"))
	end

	var_13_2 = var_13_2 or lc.createSprite(lc.formatJpg(var_13_1))

	lc.addChildToCenter(var_13_0, var_13_2)

	local var_13_3 = "girl_invite"
	local var_13_4

	if ClientData.isAnotherSkin() then
		lc.TextureCache:addImageWithMask(lc.formatJpg(var_13_3 .. "_2"))

		var_13_4 = cc.ShaderSprite:createWithFilename(lc.formatJpg(var_13_3 .. "_2"))
	end

	var_13_4 = var_13_4 or lc.createSpriteWithMask(lc.formatJpg(var_13_3))

	lc.addChildToPos(var_13_0, var_13_4, cc.p(lc.cw(var_13_0) - 240, lc.ch(var_13_0) - 80), 10)

	if P._inviteCode then
		local var_13_5 = string.upper(P._inviteCode)
		local var_13_6 = ClientView.createTTF(var_13_5, ClientView.FontSize.B2)

		lc.addChildToPos(var_13_0, var_13_6, cc.p(lc.cw(var_13_0) - 250, lc.ch(var_13_0) + 236))

		local var_13_7 = ClientView.createBMFont(ClientView.BMFont.num_48, P._inviteCount)

		lc.addChildToPos(var_13_0, var_13_7, cc.p(lc.cw(var_13_0) - 250, lc.ch(var_13_0) + 164))
		var_13_7:setAnchorPoint(0, 0.5)

		arg_13_0._inviteCount = var_13_7

		local var_13_8 = ClientView.createBMFont(ClientView.BMFont.huali_26, P._inviteIngot)

		lc.addChildToPos(var_13_0, var_13_8, cc.p(lc.cw(var_13_0) - 220, lc.ch(var_13_0) + 112))
		var_13_8:setAnchorPoint(0, 0.5)

		arg_13_0._ingotVal = var_13_8

		local var_13_9 = ClientView.createShaderButton("img_btn_recharge_4", function()
			arg_13_0:showHelp()
		end)

		lc.addChildToPos(var_13_0, var_13_9, cc.p(lc.x(var_13_6), lc.y(var_13_6) + 90))
		var_13_9:addLabel(Str(STR.INVITE_RULE))

		local var_13_10 = lc.List.createV(cc.size(500, 590), 6, 0)

		lc.addChildToPos(var_13_0, var_13_10, cc.p(lc.cw(var_13_0) - lc.cw(var_13_10) + 134, lc.ch(var_13_0) - lc.ch(var_13_10) + 50))

		local var_13_11 = {}

		for iter_13_0 = 1, #P._playerBonus._bonusInvite do
			table.insert(var_13_11, P._playerBonus._bonusInvite[iter_13_0])
		end

		table.sort(var_13_11, function(arg_15_0, arg_15_1)
			return arg_15_0._info._id < arg_15_1._info._id
		end)

		for iter_13_1 = 1, #var_13_11 do
			local var_13_12 = var_13_11[iter_13_1]
			local var_13_13 = string.format(Str(var_13_12._info._nameSid), var_13_12._info._val)
			local var_13_14 = require("BonusWidget").create(lc.w(var_13_10), var_13_12, var_13_13)

			var_13_14:registerCallback(function(arg_16_0)
				arg_13_0:claimBonus(arg_16_0)
			end)
			var_13_10:pushBackCustomItem(var_13_14)
		end
	else
		arg_13_0._indicator = ClientView.showPanelActiveIndicator(var_13_0)

		ClientData.sendGetInviteCode()
	end
end

function var_0_0.acceptInvite(arg_17_0)
	if P:getMaxCharacterLevel() >= Data._globalInfo._inviteLevelUpperLimit then
		ToastManager.push(Str(STR.INVITE_LEVEL_OVER))

		return
	end

	ClientView.getActiveIndicator():show()
	ClientData.sendGetInviteInfo(string.lower(arg_17_0._editor:getText()))
end

function var_0_0.claimBonus(arg_18_0, arg_18_1)
	local var_18_0 = 0

	while arg_18_1:canClaim() do
		ClientData.claimBonus(arg_18_1)

		var_18_0 = var_18_0 + 1
	end

	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1._info._rid) do
		local var_18_2 = {
			_infoId = iter_18_1,
			_count = arg_18_1._info._count[iter_18_0] * var_18_0
		}

		table.insert(var_18_1, var_18_2)
	end

	local var_18_3 = require("RewardPanel")

	var_18_3.create(var_18_1, var_18_3.MODE_CLAIM_ALL):show()
	lc.Audio.playAudio(AUDIO.E_CLAIM)
end

function var_0_0.showHelp(arg_19_0)
	ClientView.showHelpForm(Str(STR.INVITE_RULE), Data.HelpType.invite)
end

function var_0_0.hideIndicator(arg_20_0)
	if arg_20_0._indicator then
		arg_20_0._indicator:removeFromParent()

		arg_20_0._indicator = nil
	end

	ClientView.getActiveIndicator():hide()
end

function var_0_0.onEnter(arg_21_0)
	ClientData.addMsgListener(arg_21_0, function(arg_22_0)
		return arg_21_0:onMsg(arg_22_0)
	end, 0)

	arg_21_0._listeners = {}

	table.insert(arg_21_0._listeners, lc.addEventListener(Data.Event.invite_count_dirty, function(arg_23_0)
		if arg_21_0._isSelfInvite then
			arg_21_0._inviteCount:setString(P._inviteCount)
		end
	end))
	table.insert(arg_21_0._listeners, lc.addEventListener(Data.Event.invite_ingot_dirty, function(arg_24_0)
		if arg_21_0._isSelfInvite then
			arg_21_0._ingotVal:setString(P._inviteIngot)
		end
	end))
	table.insert(arg_21_0._listeners, lc.addEventListener(Data.Event.wx_share, function(arg_25_0)
		if arg_25_0._isOK and arg_21_0._shareBtn then
			local var_25_0 = arg_21_0._shareBtn._bonusId

			P._playerBonus._bonusShare[var_25_0]._value = 1

			ClientData.sendWxShared()
			arg_21_0._shareBtn:updateShareBtn()
		end
	end))
end

function var_0_0.onExit(arg_26_0)
	for iter_26_0 = 1, #arg_26_0._listeners do
		lc.Dispatcher:removeEventListener(arg_26_0._listeners[iter_26_0])
	end

	ClientData.removeMsgListener(arg_26_0)
end

function var_0_0.onMsg(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.type

	if var_27_0 == SglMsgType_pb.PB_TYPE_USER_CHECK_INVITE_CODE then
		arg_27_0:hideIndicator()

		local var_27_1 = arg_27_1.Extensions[User_pb.SglUserMsg.user_check_invite_code_resp]

		arg_27_0._inviteInfo = require("User").create(var_27_1)

		if P._invitedCode then
			if not arg_27_0._isSelfInvite then
				arg_27_0:refreshContent()
			end
		else
			require("PromptForm").ConfirmInvited.create(arg_27_0._inviteInfo, function()
				P._invitedCode = arg_27_0._editor:getText()

				ClientData.sendBindInvite(P._invitedCode)

				local var_28_0 = require("RewardPanel")
				local var_28_1 = P._playerBonus._invitedBonus

				var_28_1._value = var_28_1._info._val

				P._playerBonus:claimBonus(var_28_1._infoId)
				var_28_0.create(var_28_1, var_28_0.MODE_CLAIM):show()
				arg_27_0:refreshContent()
			end):show()
		end

		return true
	elseif var_27_0 == SglMsgType_pb.PB_TYPE_USER_GET_INVITE_CODE then
		arg_27_0:hideIndicator()

		P._inviteCode = arg_27_1.Extensions[User_pb.SglUserMsg.user_get_invite_code_resp]

		if arg_27_0._isSelfInvite then
			arg_27_0:refreshContent()
		end

		if arg_27_0._shareBtn then
			arg_27_0._shareBtn:updateShareBtn()
		end

		return true
	end

	return false
end

return var_0_0
