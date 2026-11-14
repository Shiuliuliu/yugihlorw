local var_0_0 = class("BattleInitiativeSkillsDialog", BasePanel)

var_0_0.LEFT_MARGIN = 36
var_0_0.RIGHT_MARGIN = 36
var_0_0.ACTION_DURATION = 0.3
var_0_0.ITEM_SIZE = cc.size(100, 120)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_WIDGET)

	var_1_0:setContentSize(ClientView.SCR_W, ClientView.SCR_H)
	var_1_0:setTouchEnabled(true)
	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, false)

	arg_2_0._itemTouchHandles = {}
	arg_2_0._skillInfos = arg_2_1
	arg_2_0._row = math.ceil(#arg_2_1 / arg_2_3)
	arg_2_0._col = arg_2_3

	local var_2_0 = ClientView.createFrameBox(cc.size(900, 350))

	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.cw(arg_2_0), 140))

	arg_2_0._form = var_2_0
	local titleBg = lc.createSprite({
		_name = "img_form_title_bg_1",
		_crect = ClientView.CRECT_FORM_TITLE_BG1_CRECT,
		_size = cc.size(560, ClientView.CRECT_FORM_TITLE_BG1_CRECT.height)
	})

	lc.addChildToPos(arg_2_0._form, titleBg, cc.p(lc.w(arg_2_0._form) / 2, lc.h(arg_2_0._form) - lc.h(titleBg) / 2 + 10), 10)

	arg_2_0._titleArea = titleBg

	local var_2_1 = lc.createSprite({
		_name = "img_form_title_light_1",
		_crect = ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT,
		_size = cc.size(200, ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT.height)
	})

	lc.addChildToPos(titleBg, var_2_1, cc.p(lc.w(titleBg) / 2, lc.h(titleBg) / 2 + 4))

	local var_2_2
	local var_2_3 = cc.Label:createWithTTF(arg_2_2, ClientView.TTF_FONT, ClientView.FontSize.M1)

	var_2_3:setColor(ClientView.COLOR_TEXT_TITLE)
	var_2_3:setPosition(lc.w(titleBg) / 2, lc.h(titleBg) / 2 + 4)
	titleBg:addChild(var_2_3)

	arg_2_0._titleLabel = var_2_3

	arg_2_0:initCardList()
	arg_2_0:updateView()
end

function var_0_0.registerItemTouchHandles(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._itemTouchHandles._beginHandle = arg_3_1
	arg_3_0._itemTouchHandles._moveHandle = arg_3_2
	arg_3_0._itemTouchHandles._endHandle = arg_3_3
	arg_3_0._itemTouchHandles._longHandle = arg_3_4
end

-- the dialog on screen, if any
local var_0_1

function var_0_0.show(arg_4_0)
	if var_0_1 and var_0_1 ~= arg_4_0 and not tolua.isnull(var_0_1) and var_0_1:getParent() then
		var_0_1:removeFromParent()
	end

	var_0_1 = arg_4_0

	lc.addChildToCenter(lc._runningScene, arg_4_0, BattleScene.ZOrder.form)
	lc.offset(arg_4_0._form, 0, -350)
	arg_4_0._form:runAction(lc.sequence(lc.ease(lc.moveBy(lc.absTime(var_0_0.ACTION_DURATION), cc.p(0, 350)), "BackO")))
end

function var_0_0.hide(arg_5_0)
	arg_5_0._isHiding = true

	arg_5_0._form:runAction(lc.sequence(lc.moveBy(lc.absTime(var_0_0.ACTION_DURATION), cc.p(0, -350)), function()
		arg_5_0:removeFromParent()
	end))
end

function var_0_0.confirm(arg_7_0)
	if arg_7_0._confirmFunction then
		arg_7_0._confirmFunction(arg_7_0)
	end

	arg_7_0:hide()
end

function var_0_0.initCardList(arg_8_0)
	arg_8_0._allCards = {}

	local var_8_0 = lc.List.createV(cc.size(lc.w(arg_8_0._form) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, 300))

	var_8_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(arg_8_0._form, var_8_0, cc.p(lc.cw(arg_8_0._form), lc.bottom(arg_8_0._titleArea) - lc.ch(var_8_0) + 20))

	arg_8_0._list = var_8_0

	local var_8_1 = lc.arrayToTable(arg_8_0._skillInfos, arg_8_0._col)

	for iter_8_0 = 1, #var_8_1 do
		local var_8_2 = var_8_1[iter_8_0]
		local var_8_3 = arg_8_0:createItem(var_8_2)

		var_8_0:pushBackCustomItem(var_8_3)
	end
end

function var_0_0.createItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = ccui.Widget:create()

	var_9_0:setContentSize(cc.size(lc.w(arg_9_0._list), var_0_0.ITEM_SIZE.height))

	local var_9_1 = lc.w(var_9_0) / arg_9_0._col

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_2 = iter_9_1._owner
		local var_9_3 = IconWidget.create(var_9_2, IconWidget.DisplayFlag.NAME)

		var_9_3._skill = iter_9_1

		var_9_3._name:setColor(ClientView.COLOR_TEXT_WHITE)

		var_9_3._nameColor = ClientView.COLOR_TEXT_WHITE

		var_9_3:registerTouchHandles(arg_9_0._itemTouchHandles)
		lc.addChildToPos(var_9_0, var_9_3, cc.p(var_9_1 * (iter_9_0 - 0.5), lc.ch(var_9_0)))

		if var_9_2._status == BattleData.CardStatus.grave then
			local var_9_4 = lc.createSprite("initiative_grave")

			lc.addChildToPos(var_9_3, var_9_4, cc.p(14, lc.h(var_9_3._frame) + 10))
		elseif var_9_2._status == BattleData.CardStatus.rare then
			local var_9_5 = lc.createSprite("initiative_rare")

			lc.addChildToPos(var_9_3, var_9_5, cc.p(14, lc.h(var_9_3._frame) + 10))
		elseif var_9_2._status == BattleData.CardStatus.hand then
			local var_9_6 = lc.createSprite("initiative_rare")

			lc.addChildToPos(var_9_3, var_9_6, cc.p(14, lc.h(var_9_3._frame) + 10))
		elseif var_9_2._status == BattleData.CardStatus.leave then
			local var_9_7 = lc.createSprite("initiative_grave")

			lc.addChildToPos(var_9_3, var_9_7, cc.p(14, lc.h(var_9_3._frame) + 10))
		end

		local dbSkillNames = {
		[20117] = "Rào Chắn Không Gian",
		[20118] = "Xung Lực Thống Trị",
		[20119] = "Tia Lửa Thống Trị",
		[20120] = "Nghiện Bẫy",
			[20075] = "Triệu Hồi Bản Thể",
			[20076] = "Ý Chí Saiyan - SSJ 3",
			[20077] = "Thần Tốc Liên Trảm",
			[20078] = "Áp Lực Hoang Dã",
			[20079] = "Thần Cảnh Tuyệt Đối",
			[20080] = "Tìm Kiếm Thần Khí",
			[20081] = "Hồi Sinh Chiến Binh",
			[20082] = "Xóa Sổ Bộ Bài Phụ",
			[20083] = "Sóng Thần Lam Sắc",
			[20084] = "Hủy Diệt Toàn Diện",
			[20085] = "Phong Khóa Vực",
			[20086] = "Điều Ước Trái Đất",
			[20087] = "Điều Ước Porunga",
			[20088] = "Dende Xuất Hiện",
			[20089] = "Trị Liệu Thần Kỳ",
			[20090] = "Dò Tìm Ngọc Rồng",
			[20091] = "Bói Toán Dẫn Lối",
			[20092] = "Âm Hồn Triệu Tập",
			[20093] = "Biến Hóa Viện Trợ",
			[20094] = "Bảo Hộ Tiên Đậu",
			[20095] = "Hồi Phục Sinh Lực",
			[20096] = "Hoàng Tử Thần Binh",
			[20097] = "Kiêu Hãnh Saiyan",
			[20098] = "Final Explosion",
			[20099] = "Bản Lĩnh Bất Khuất",
			[20100] = "Bụi Phấn Phân Giải - Stardust Breaker",
			[20101] = "Kiếm Khí Hợp Thể - Final Kamehameha",
			[20102] = "Vũ Điệu Hợp Thể",
			[20104] = "Hợp Thể Potara",
			[20105] = "Công Lý Đen Tối",
			[20106] = "Cuồng Nộ Saiyan",
			[20107] = "Hủy Diệt Bộc Phát",
			[20108] = "Đại Đình Chiến Thần Cấp",
			[20109] = "Nguyện Ước Tối Cao",
			[20110] = "Chiến Binh Công Lý Xuất Trận",
			[20111] = "Triệu Tập Đồng Đội",
			[20112] = "Dò Tìm Ngọc Rồng",
			[20113] = "Nghiên Cứu Di Vật",
			[20114] = "Vận Khí Tụ Lực",
			[20115] = "Tái Sinh Tái Chiến",
			[20116] = "Định Hình Phương Hướng",
			[20121] = "Shin đi bơi",
			[20122] = "Nạp đạn",
			[20131] = "Ăn vạ - Kéo viện binh",
			[20135] = "Báo Thức Mê Cung",
			[20136] = "Đồng Hồ Hồi Quy",
			[20137] = "Lò Sưởi Mê Cung",
			[20138] = "Thiêu Rụi Chiến Lợi",
			[20139] = "Tro Tàn Trỗi Dậy",
			[20140] = "Đèn Chùm Mê Cung",
			[20141] = "Ánh Nến Phản Phép",
			[20142] = "Thắp Lại Ánh Đèn",
			[20143] = "Hầu Gái Dẫn Lối",
			[20144] = "Tiếp Đón Mê Cung",
			[20145] = "Triệu Tập Hầu Gái",
			[20146] = "Bẫy Ngầm Hiện Thân",
			[20147] = "Triệu Tập Arianna",
			[20241] = "Triệu Tập Cây Cối",
			[20242] = "Hồi Sinh Cây Cối",
			[20246] = "Tiến Hóa Dung Hợp",
			[20247] = "Liên Xạ Hai Phát",

			[20148] = "Thu Hồi Mê Cung",
			[20149] = "Kỵ Sĩ Hộ Vệ",
			[20150] = "Khiên Chắn Mê Cung",
			[20151] = "Chiến Ý Mê Cung",
			[20152] = "Song Kiếm Liên Trảm",
			[20153] = "Uy Áp Kỵ Sĩ",
			[20154] = "Thệ Ước Trung Thành",
			[20155] = "Quản Gia Tiếp Đón",
			[20156] = "Chuẩn Bị Cạm Bẫy",
			[20157] = "Quản Gia Tái Xuất",
			[20158] = "Thu Thập Mộ Phần",
			[20159] = "Giáp Quỷ Bất Hoại",
			[20160] = "Tượng Đá Canh Gác",
			[20161] = "Tấm Khiên Mê Cung",
			[20162] = "Uy Lực Bẫy Ngầm",
			[20163] = "Ác Quỷ Phục Kích",
			[20164] = "Truy Tìm Bẫy Mê Cung",
			[20165] = "Hộ Mệnh Vực Thẳm",
			[20166] = "Quý Cô Giá Lâm",
			[20167] = "Quyền Uy Lâu Đài Bạc",
			[20168] = "Hộ Giáp Bạch Ngân",
			[20169] = "Bảo Hộ Cạm Bẫy",
			[20170] = "Phán Quyết Bạch Ngân",
			[20171] = "Thiết Lập Mê Cung",
			[20172] = "Hoàng Tộc Tăng Trí",
			[20173] = "Phong Ấn Ngoại Điện",
			[20174] = "Trừng Phạt Kẻ Xâm Nhập",
			[20175] = "Di Sản Bạch Ngân",
			[20176] = "Nữ Hoàng Lâm Triều",
			[20177] = "Sức Mạnh Lâu Đài Bạc",
			[20178] = "Hộ Vệ Bạch Ngân",
			[20179] = "Kết Giới Bẫy Bạc",
			[20180] = "Bắt Giữ Kẻ Xâm Nhập",
			[20181] = "Bẻ Gãy Kế Hoạch",
			[20182] = "Khôi Phục Cạm Bẫy",
			[20183] = "Tái Sinh Không Gian",
			[20184] = "Triệu Gọi Binh Đoàn",
			[20185] = "Công Chúa Xuất Chinh",
			[20186] = "Hoàng Quyền Tuyệt Đối",
			[20187] = "Bất Khả Xâm Phạm",
			[20188] = "Tam Trọng Kết Giới",
			[20189] = "Kho Báu Hoàng Gia",
			[20190] = "Điều Động Hoàng Gia",
			[20191] = "Tiêu Diệt Dị Giới",
			[20192] = "Di Ngôn Công Chúa",
			[20193] = "Hồi Sinh Công Chúa",
			[20219] = "Thứ Nguyên Chúc Phúc",
			[20222] = "Chiến Tuyến Thứ Nguyên",
			[20223] = "Tiếp Tế Thứ Nguyên",
			[20224] = "Chiến Lực Liqi",
			[20225] = "Triệu Tập Liqi",
		[20230] = "Thứ Nguyên Giáng Lâm",
		[20231] = "Long Kiếm Liên Trảm",
		[20232] = "Thần Tiễn Triệu Tập",
		[20233] = "Tiếp Tế Tinh Linh",
		[20235] = "Khúc Ca Cứu Rỗi",
		[20238] = "Hồi Sinh Định Mệnh",
		[20239] = "Phong Tỏa Không Gian",
		[20240] = "Ký Ức Thời Gian",
		[20250] = "Thứ Nguyên Triệu Hồi",
		[20252] = "Thanh Tẩy Ma Pháp",
			[20195] = "Truy Tìm Phép Bẫy",
			[20198] = "Triệu Tập Thủ Hộ",
			[20199] = "Bố Trí Mê Cung",
			[20204] = "Hồi Quy Cạm Bẫy",
	[20207] = "Đẩy Lùi Xâm Phạm",
			[20208] = "Thu Hồi Tàn Tích",
			[20211] = "Tìm Kiếm Thuộc Hạ",
			[20212] = "Xáo Trộn Mộ Phần",
			[20215] = "Hiệu Triệu Cạm Bẫy",
			[20216] = "Tiêu Diệt Xâm Lược",
			[20217] = "Thu Hồi Phép Bẫy",
			[20218] = "Thao Túng Linh Hồn",
		}
		local var_9_8 = Data._skillInfo[iter_9_1._id]
		local var_9_9 = dbSkillNames[iter_9_1._id] or (var_9_8 and Str(var_9_8._nameSid))
		if not var_9_9 or var_9_9 == "" or tonumber(var_9_9) then
			if var_9_8 and var_9_8._descSid then
				local desc = Str(var_9_8._descSid)
				if desc and desc ~= "" and not tonumber(desc) then
					var_9_9 = string.splitByChar(desc, "\n")[1] or desc
				end
			end
			if not var_9_9 or var_9_9 == "" or tonumber(var_9_9) then
				var_9_9 = Str(iter_9_1._owner._info._nameSid)
			end
		end

		if iter_9_1._id == 3851 then
			var_9_9 = Str(iter_9_1._owner._info._briefNameSid)

			local var_9_10 = ClientView.createBMFont(ClientView.BMFont.huali_20, iter_9_1._owner:getStar())

			var_9_10:setAnchorPoint(1, 0)
			lc.addChildToPos(var_9_0, var_9_10, cc.p(lc.right(var_9_3) - 10, lc.bottom(var_9_3) + 36), 2)

			local var_9_11 = lc.createSprite("card_quality")

			lc.addChildToPos(var_9_0, var_9_11, cc.p(lc.left(var_9_10) - 14, lc.y(var_9_10) + 10), 2)
		elseif iter_9_1._id == 6753 then
			var_9_9 = Str(iter_9_1._owner._info._briefNameSid)

			local var_9_12 = ClientView.createBMFont(ClientView.BMFont.huali_20, iter_9_1._owner._info._joinComponent[1])

			var_9_12:setAnchorPoint(1, 0)
			lc.addChildToPos(var_9_0, var_9_12, cc.p(lc.right(var_9_3) - 10, lc.bottom(var_9_3) + 36), 2)

			local var_9_13 = lc.createSprite("card_quality")

			lc.addChildToPos(var_9_0, var_9_13, cc.p(lc.left(var_9_12) - 14, lc.y(var_9_12) + 10), 2)
		elseif iter_9_1._id == 9298 then
			var_9_9 = Str(iter_9_1._owner._info._briefNameSid)

			local var_9_14 = ClientView.createBMFont(ClientView.BMFont.huali_20, iter_9_1._owner:getLink())

			var_9_14:setAnchorPoint(1, 0)
			lc.addChildToPos(var_9_0, var_9_14, cc.p(lc.right(var_9_3) - 10, lc.bottom(var_9_3) + 36), 2)
		end

		var_9_3._name:setString(var_9_9)
		var_9_3._name:setScale(0.6)
		ClientView.fitLabel(var_9_3._name, lc.w(var_9_3._frame) + 16, 0.45)
		var_9_3._name:setPosition(lc.w(var_9_3) / 2, lc.sh(var_9_3._name) / 2)

		if not var_9_3._skillBadge then
			local var_9_sk_ico = lc.createSprite("img_icon_skill")
			if var_9_sk_ico then
				lc.addChildToPos(var_9_3._frame, var_9_sk_ico, cc.p(20, lc.h(var_9_3._frame) - 20), 2)
				var_9_3._skillBadge = var_9_sk_ico
			end
		end
	end

	return var_9_0
end

function var_0_0.updateView(arg_10_0)
	for iter_10_0 = 1, #arg_10_0._allCards do
		local var_10_0 = arg_10_0._allCards[iter_10_0]

		if arg_10_0:isInSelectedList(iter_10_0) then
			if not var_10_0._glow then
				local var_10_1 = DragonBones.create("xuanzhong")

				var_10_1:gotoAndPlay("effect1")
				var_10_1:setScale(1.4)
				lc.addChildToCenter(var_10_0, var_10_1, -1)

				var_10_0._glow = var_10_1
			end
		elseif var_10_0._glow then
			var_10_0._glow:removeFromParent()

			var_10_0._glow = nil
		end
	end

	if arg_10_0._confirmButton then
		local var_10_2 = arg_10_0:isChoiceSatisfied()

		arg_10_0._confirmButton:setEnabled(var_10_2)
	end
end

return var_0_0
