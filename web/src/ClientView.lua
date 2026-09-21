local var_0_0 = {}

V = var_0_0
var_0_0.SCR_SIZE = lc.Director:getVisibleSize()
var_0_0.SCR_W = var_0_0.SCR_SIZE.width
var_0_0.SCR_CW = var_0_0.SCR_W / 2
var_0_0.SCR_H = var_0_0.SCR_SIZE.height
var_0_0.SCR_CH = var_0_0.SCR_H / 2
var_0_0.SCR_EDGE = math.max(0, var_0_0.SCR_CW - 768)
var_0_0.TTF_FONT = "YuGiOhFont"
var_0_0.FontSize = {
	S2 = 18,
	B2 = 28,
	M2 = 22,
	M1 = 25,
	B1 = 38,
	S1 = 20,
	S3 = 15
}
var_0_0.BMFont = {
	num_43 = "res/fonts/number_43.fnt",
	num_48 = "res/fonts/num_48.fnt",
	huali_32 = "res/fonts/huali_32.fnt",
	huali_20 = "res/fonts/huali_26.fnt",
	num_24 = "res/fonts/yxw_number_csrd_24.fnt",
	level = "res/fonts/level.fnt",
	number_legend = "res/fonts/legend_num.fnt",
	huali_26 = "res/fonts/huali_26.fnt"
}
var_0_0.trophyGradeBones = {
	"qingtong",
	"baiying",
	"huangjin",
	"bojin",
	"xinjia1",
	"chuanshuo",
	"xinjia2"
}
var_0_0.BMFONTS_COMMON = {
	var_0_0.BMFont.huali_26,
	var_0_0.BMFont.huali_32,
	var_0_0.BMFont.num_48,
	var_0_0.BMFont.num_43
}
var_0_0.BMFONTS_CITY = {
	var_0_0.BMFont.number_legend
}
var_0_0.BMFONTS_BATTLE = {}
var_0_0.SHADER_PRESS = cc.ShaderEffect:create("res/shader/highlight.fsh")
var_0_0.SHADER_DISABLE = cc.ShaderEffect:create("res/shader/gray.fsh")
var_0_0.SHADER_GRAY_FRAME = cc.ShaderEffect:create("res/shader/gray_light.fsh")
var_0_0.SHADER_G2B = cc.ShaderEffect:create("res/shader/colorG2B.fsh")
var_0_0.SHADER_G2Y = cc.ShaderEffect:create("res/shader/colorG2Y.fsh")
var_0_0.SHADER_COLORS = {
	cc.ShaderEffect:create("res/shader/colorGreen.fsh"),
	cc.ShaderEffect:create("res/shader/colorBlue.fsh"),
	cc.ShaderEffect:create("res/shader/colorPurple.fsh"),
	cc.ShaderEffect:create("res/shader/colorYellow.fsh"),
	cc.ShaderEffect:create("res/shader/colorRed.fsh")
}
var_0_0.SHADER_TYPES = {
	[Data.CardType.monster] = cc.ShaderEffect:create("res/shader/colorYellow.fsh"),
	[Data.CardType.magic] = cc.ShaderEffect:create("res/shader/colorGreen.fsh"),
	[Data.CardType.trap] = cc.ShaderEffect:create("res/shader/colorPurple.fsh"),
	[Data.CardType.rare] = cc.ShaderEffect:create("res/shader/colorDarkPurple.fsh"),
	[Data.CardType.monster + 100] = cc.ShaderEffect:create("res/shader/colorOrange.fsh"),
	[Data.CardType.monster + 101] = cc.ShaderEffect:create("res/shader/colorLightBlue.fsh"),
	[Data.CardType.rare + 200] = cc.ShaderEffect:create("res/shader/colorLightWhite.fsh"),
	[Data.CardType.rare + 201] = cc.ShaderEffect:create("res/shader/colorBlack.fsh"),
	[Data.CardType.rare + 202] = cc.ShaderEffect:create("res/shader/colorDarkBlue.fsh")
}
var_0_0.SHADER_COLOR_STAGE_SILVER = cc.ShaderEffect:create("res/shader/colorStageSilver.fsh")
var_0_0.SHADER_COLOR_STAGE_BRONZE = cc.ShaderEffect:create("res/shader/colorStageBronze.fsh")
var_0_0.CRECT_COM_BG1 = cc.rect(56, 0, 3, 48)
var_0_0.CRECT_COM_BG2 = cc.rect(8, 0, 122, 30)
var_0_0.CRECT_COM_BG3 = cc.rect(17, 22, 1, 1)
var_0_0.CRECT_COM_BG4 = cc.rect(22, 50, 1, 1)
var_0_0.CRECT_COM_BG5 = cc.rect(17, 22, 1, 1)
var_0_0.CRECT_COM_BG7 = cc.rect(17, 30, 1, 2)
var_0_0.CRECT_COM_BG9 = cc.rect(28, 48, 2, 2)
var_0_0.CRECT_COM_BG10 = cc.rect(18, 20, 2, 1)
var_0_0.CRECT_COM_BG11 = cc.rect(20, 32, 2, 2)
var_0_0.CRECT_COM_BG12 = cc.rect(28, 0, 2, 38)
var_0_0.CRECT_COM_BG13 = cc.rect(0, 35, 256, 1)
var_0_0.CRECT_COM_BG14 = cc.rect(28, 28, 4, 4)
var_0_0.CRECT_COM_BG15 = cc.rect(24, 26, 1, 1)
var_0_0.CRECT_COM_BG16 = cc.rect(70, 75, 1, 1)
var_0_0.CRECT_COM_BG17 = cc.rect(51, 65, 1, 1)
var_0_0.CRECT_COM_BG18 = cc.rect(257, 0, 1, 1)
var_0_0.CRECT_COM_BG20 = cc.rect(6, 6, 1, 1)
var_0_0.CRECT_COM_BG21 = cc.rect(88, 78, 1, 1)
var_0_0.CRECT_COM_BG22 = cc.rect(30, 32, 2, 2)
var_0_0.CRECT_COM_BG23 = cc.rect(4, 4, 2, 2)
var_0_0.CRECT_COM_BG24 = cc.rect(63, 63, 1, 1)
var_0_0.CRECT_COM_BG25 = cc.rect(24, 26, 2, 2)
var_0_0.CRECT_COM_BG26 = cc.rect(11, 0, 2, 28)
var_0_0.CRECT_COM_BG27 = cc.rect(8, 8, 2, 2)
var_0_0.CRECT_COM_BG29 = cc.rect(18, 0, 1, 230)
var_0_0.CRECT_COM_BG30 = cc.rect(16, 16, 2, 1)
var_0_0.CRECT_COM_BG31 = cc.rect(42, 52, 2, 2)
var_0_0.CRECT_COM_BG32 = cc.rect(33, 0, 1, 45)
var_0_0.CRECT_COM_BG33 = cc.rect(20, 0, 2, 152)
var_0_0.CRECT_COM_BG34 = cc.rect(19, 0, 2, 32)
var_0_0.CRECT_COM_BG35 = cc.rect(20, 30, 2, 48)
var_0_0.CRECT_COM_BG36 = cc.rect(7, 55, 1, 1)
var_0_0.CRECT_COM_BG37 = cc.rect(25, 27, 1, 2)
var_0_0.CRECT_COM_BG42 = cc.rect(8, 14, 1, 1)
var_0_0.CRECT_COM_BG43 = cc.rect(88, 0, 2, 97)
var_0_0.CRECT_COM_BG44 = cc.rect(88, 0, 2, 97)
var_0_0.CRECT_COM_BG45 = cc.rect(51, 35, 113, 1)
var_0_0.CRECT_COM_BG46 = cc.rect(0, 0, 70, 117)
var_0_0.CRECT_COM_BG55 = cc.rect(24, 0, 1, 81)
var_0_0.CRECT_COM_BG57 = cc.rect(7, 7, 1, 1)
var_0_0.CRECT_FRAME1 = cc.rect(14, 18, 1, 1)
var_0_0.CRECT_FRAME2 = cc.rect(32, 50, 1, 1)
var_0_0.CRECT_FORM_FRAME = cc.rect(74, 64, 1, 1)
var_0_0.CRECT_FORM_TITLE_BG2 = cc.rect(240, 0, 3, 54)
var_0_0.CRECT_RECT_INTERNAL = cc.rect(44, 93, 1, 1)
var_0_0.CRECT_TIP_BG = cc.rect(40, 40, 1, 1)
var_0_0.CRECT_TOAST_BG = cc.rect(45, 43, 2, 1)
var_0_0.CRECT_UI_FRAME = cc.rect(25, 25, 1, 1)
var_0_0.CRECT_TITLE_AREA_BG = cc.rect(1, 0, 1, 60)
var_0_0.CRECT_TITLE_BG = cc.rect(115, 0, 1, 51)
var_0_0.CRECT_BUTTON = cc.rect(20, 0, 1, 78)
var_0_0.CRECT_BUTTON_S = cc.rect(14, 0, 2, 60)
var_0_0.CRECT_BUTTON_SQUARE = cc.rect(30, 0, 3, 61)
var_0_0.CRECT_BUTTON_CHECK = cc.rect(22, 0, 2, 46)
var_0_0.CRECT_BUTTON_TAB_2 = cc.rect(25, 0, 1, 54)
var_0_0.CRECT_ARROW_3 = cc.rect(0, 32, 40, 1)
var_0_0.CRECT_ARROW_4 = cc.rect(0, 32, 40, 1)
var_0_0.CRECT_PROGRESS_BG = cc.rect(14, 0, 1, 27)
var_0_0.CRECT_PROGRESS_BG2 = cc.rect(14, 0, 1, 12)
var_0_0.CRECT_PROGRESS_FG = cc.rect(13, 0, 1, 23)
var_0_0.CRECT_LABEL_DECORATION = cc.rect(349, 0, 2, 55)
var_0_0.CRECT_FORM_TITLE_BG1_CRECT = cc.rect(188, 0, 1, 63)
var_0_0.CRECT_FORM_TITLE_LIGHT1_CRECT = cc.rect(47, 0, 2, 40)
var_0_0.UI_SCENE_TITLE_HEIGHT = 51
var_0_0.VERTICAL_TAB_WIDTH = 250
var_0_0.AREA_MAX_WIDTH = 1300
var_0_0.PANEL_BTN_WIDTH = 150
var_0_0.PANEL_BOTTOM_HEIGHT = 80
var_0_0.FRAME_INNER_TOP = 28
var_0_0.FRAME_INNER_LEFT = 28
var_0_0.FRAME_INNER_RIGHT = 28
var_0_0.FRAME_INNER_BOTTOM = 28
var_0_0.FRAME_TAB_WIDTH = 120

local var_0_1 = 20
local var_0_2 = 141
local var_0_3 = 262
local var_0_4 = 12
local var_0_5 = 212
local var_0_6 = 378
local var_0_7 = {
	1,
	2,
	1,
	2,
	2,
	1,
	2,
	1
}
local var_0_8 = {
	cc.p(var_0_1, var_0_4),
	cc.p(var_0_2, var_0_4 - 10),
	cc.p(var_0_3, var_0_4),
	cc.p(var_0_1 - 16, var_0_5),
	cc.p(var_0_3 + 16, var_0_5),
	cc.p(var_0_1, var_0_6),
	cc.p(var_0_2, var_0_6 + 12),
	cc.p(var_0_3, var_0_6)
}
local var_0_9 = {
	180,
	180,
	90,
	270,
	90,
	270,
	0,
	0
}

var_0_0.COLOR_BMFONT = cc.c3b(255, 250, 240)
var_0_0.COLOR_TEXT_TITLE = cc.c3b(255, 200, 0)
var_0_0.COLOR_TEXT_TITLE_DESC = cc.c3b(230, 200, 160)
var_0_0.COLOR_BUTTON_TITLE = cc.c3b(252, 234, 170)
var_0_0.COLOR_LABEL_LIGHT = cc.c3b(240, 150, 70)
var_0_0.COLOR_LABEL_DARK = cc.c3b(96, 64, 32)
var_0_0.COLOR_TEXT_LIGHT = var_0_0.COLOR_BMFONT
var_0_0.COLOR_TEXT_DARK = cc.c3b(40, 20, 0)
var_0_0.COLOR_TEXT_WHITE = var_0_0.COLOR_BMFONT
var_0_0.COLOR_TEXT_GREEN = cc.c3b(200, 250, 150)
var_0_0.COLOR_TEXT_GREEN_2 = cc.c3b(40, 210, 40)
var_0_0.COLOR_TEXT_BLUE = cc.c3b(150, 220, 250)
var_0_0.COLOR_TEXT_BLUE_2 = cc.c3b(0, 120, 230)
var_0_0.COLOR_TEXT_PURPLE = cc.c3b(220, 130, 255)
var_0_0.COLOR_TEXT_ORANGE = cc.c3b(255, 200, 60)
var_0_0.COLOR_TEXT_RED = cc.c3b(255, 100, 100)
var_0_0.COLOR_TEXT_GREEN_DARK = cc.c3b(60, 255, 80)
var_0_0.COLOR_TEXT_BLUE_DARK = cc.c3b(0, 0, 128)
var_0_0.COLOR_TEXT_PURPLE_DARK = cc.c3b(160, 0, 160)
var_0_0.COLOR_TEXT_ORANGE_DARK = cc.c3b(150, 120, 20)
var_0_0.COLOR_TEXT_RED_DARK = cc.c3b(180, 10, 10)
var_0_0.COLOR_TEXT_GRAY = cc.c3b(96, 96, 96)
var_0_0.COLOR_TEXT_LIGHT_BLUE = cc.c3b(75, 255, 250)
var_0_0.COLOR_TEXT_VIP = cc.c3b(255, 100, 50)
var_0_0.COLOR_TEXT_INGOT = cc.c3b(255, 255, 128)
var_0_0.COLOR_GLOW = cc.c3b(250, 250, 120)
var_0_0.COLOR_GLOW_BLUE = cc.c3b(180, 250, 250)
var_0_0.COLOR_DARK_BG = cc.c4b(64, 64, 64)
var_0_0.COLOR_UNION_TITLE = cc.c3b(254, 211, 117)
var_0_0.COLOR_LEGEND_NUM = cc.c3b(255, 255, 120)
var_0_0.COLOR_RES_LABEL_BG_LIGHT = cc.c3b(120, 60, 0)
var_0_0.COLOR_RES_LABEL_BG_DARK = cc.c3b(60, 30, 0)
var_0_0.COLOR_SHADOW_BG_BLUE = cc.c4b(5, 85, 100, 255)
var_0_0.COLOR_SHADOW_BG_BROWN = cc.c4b(60, 30, 0, 255)
var_0_0.COLOR_DIVIDING_LINE_DARK = cc.c3b(70, 45, 10)
var_0_0.COLOR_DIVIDING_LINE_LIGHT = cc.c3b(180, 210, 240)
var_0_0.COLORS_TEXT_CLASH_GRADE = {
	var_0_0.COLOR_TEXT_WHITE,
	var_0_0.COLOR_TEXT_WHITE,
	var_0_0.COLOR_TEXT_WHITE,
	var_0_0.COLOR_TEXT_WHITE,
	var_0_0.COLOR_TEXT_WHITE,
	var_0_0.COLOR_TEXT_WHITE
}
var_0_0.MASK_OPACITY_LIGHT = 128
var_0_0.MASK_OPACITY_DARK = 200
var_0_0.CARD_SIZE = cc.size(268, 392)
var_0_0.BATTLE_ROTATION_X = 20
var_0_0.MAX_STAR_COUNT = 15
var_0_0.RICHTEXT_PARAM_DARK_S1 = {
	_normalClr = var_0_0.COLOR_TEXT_DARK,
	_boldClr = var_0_0.COLOR_TEXT_GREEN_DARK,
	_fontSize = var_0_0.FontSize.S1
}
var_0_0.RICHTEXT_PARAM_DARK_S2 = {
	_normalClr = var_0_0.COLOR_TEXT_DARK,
	_boldClr = var_0_0.COLOR_TEXT_GREEN_DARK,
	_fontSize = var_0_0.FontSize.S2
}
var_0_0.RICHTEXT_PARAM_DARK_S3 = {
	_normalClr = var_0_0.COLOR_TEXT_DARK,
	_boldClr = var_0_0.COLOR_TEXT_GREEN_DARK,
	_fontSize = var_0_0.FontSize.S3
}
var_0_0.RICHTEXT_PARAM_LIGHT_S1 = {
	_normalClr = var_0_0.COLOR_TEXT_LIGHT,
	_boldClr = var_0_0.COLOR_TEXT_GREEN,
	_fontSize = var_0_0.FontSize.S1
}
var_0_0.RICHTEXT_PARAM_LIGHT_S2 = {
	_normalClr = var_0_0.COLOR_TEXT_LIGHT,
	_boldClr = var_0_0.COLOR_TEXT_GREEN,
	_fontSize = var_0_0.FontSize.S2
}
var_0_0.RICHTEXT_PARAM_LIGHT_S3 = {
	_normalClr = var_0_0.COLOR_TEXT_LIGHT,
	_boldClr = var_0_0.COLOR_TEXT_GREEN,
	_fontSize = var_0_0.FontSize.S3
}
var_0_0.RICHTEXT_PARAM_DARK_GEEN_S2 = {
	_normalClr = lc.Color3B.black,
	_boldClr = var_0_0.COLOR_TEXT_GREEN_2,
	_fontSize = var_0_0.FontSize.S2
}

require("BasePanel")
require("BaseForm")
require("BaseScene")
require("BaseUIScene")

function var_0_0.init()
	var_0_0._resExchangeForms = {}
	var_0_0._worldSwords = {}

	TextureManager.init()
end

local var_0_10 = cc.rect(91, 0, 1, 88)
local var_0_11 = cc.size(340, 88)

function var_0_0.createCardFrame(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1, var_2_2, var_2_3 = Data.removeAdditional(arg_2_0)
	local var_2_4, var_2_5 = Data.getInfo(arg_2_0)
	local var_2_6 = cc.ShaderSprite:createWithFramename(var_0_0.getCardFrameName(var_2_4._quality, arg_2_0))
	local var_2_7 = lc.createNode(var_2_6:getContentSize())

	var_2_7._showFg = true
	var_2_7._showInBattle = false
	var_2_7._infoId = arg_2_0
	var_2_7._backId = (arg_2_1 and arg_2_1 > 0) and arg_2_1 or 7600
	var_2_7._skinId = arg_2_2
	var_2_7._effectId = arg_2_3

	var_2_7:setCascadeOpacityEnabled(true)
	lc.addChildToCenter(var_2_7, var_2_6, 1)

	var_2_7._frame = var_2_6

	local var_2_8 = cc.ShaderSprite:createWithFramename("card_frame_bg_0")

	lc.addChildToCenter(var_2_7, var_2_8, 0)

	var_2_7._center = var_2_8

	local var_2_9 = cc.ShaderSprite:createWithFramename(var_0_0.getCardBottomName(var_2_5, var_2_4))

	lc.addChildToCenter(var_2_7, var_2_9, 2)

	var_2_7._bottom = var_2_9


	local var_2_10 = cc.Node:create()

	lc.addChildToPos(var_2_7, var_2_10, cc.p(0, 0), 4)

	var_2_7._valueNode = var_2_10

	local var_2_11 = var_0_0.createBMFont(var_0_0.BMFont.huali_32, 0)

	var_2_11._defaultPos = cc.p(lc.w(var_2_7) / 4 + 10, 38)

	lc.addChildToPos(var_2_10, var_2_11, var_2_11._defaultPos)
	var_2_11:setScale(1.2)

	var_2_7._atkValue = var_2_11

	local var_2_12 = var_0_0.createBMFont(var_0_0.BMFont.huali_32, 0)

	var_2_12._defaultPos = cc.p(lc.w(var_2_7) * 3 / 4 - 10, 38)

	lc.addChildToPos(var_2_10, var_2_12, var_2_12._defaultPos)
	var_2_12:setScale(1.2)

	var_2_7._hpValue = var_2_12

	local var_2_13 = var_0_0.createBMFont(var_0_0.BMFont.huali_32, var_2_4._star or 0)

	var_2_13._defaultPos = cc.p(lc.w(var_2_7) - 30, 199)

	lc.addChildToPos(var_2_10, var_2_13, var_2_13._defaultPos)
	var_2_13:setAnchorPoint(cc.p(1, 0.5))
	var_2_13:setScale(2)

	var_2_7._starValue = var_2_13

	var_2_13:setVisible(false)

	local var_2_14 = lc.createSprite("card_quality")

	var_2_14:setScale(1.8)
	lc.addChildToPos(var_2_10, var_2_14, cc.p(lc.x(var_2_13) - lc.w(var_2_13) - lc.cw(var_2_14) - 32, lc.y(var_2_13) - 4))

	var_2_14._x = var_2_14:getPositionX()
	var_2_7._starIcon = var_2_14

	var_2_14:setVisible(false)

	local var_2_15 = lc.createSprite({
		_name = "card_extra",
		_crect = var_0_10,
		_size = var_0_11
	})

	lc.addChildToPos(var_2_10, var_2_15, cc.p(lc.cw(var_2_7), lc.y(var_2_13) - 189))

	var_2_7._extraBg = var_2_15

	var_2_15:setVisible(false)

	local var_2_16 = var_0_0.createTTF("", ClientView.FontSize.B1)

	lc.addChildToCenter(var_2_15, var_2_16)

	var_2_7._extraValue = var_2_16

	local var_2_17 = cc.ShaderSprite:createWithFramename("card_frame_cost")

	lc.addChildToCenter(var_2_7, var_2_17, 2)

	var_2_7._costBg = var_2_17

	local var_2_18 = var_0_0.createBMFont(var_0_0.BMFont.huali_26, "")

	lc.addChildToPos(var_2_7, var_2_18, cc.p(32, lc.h(var_2_7) - 26), 2)
	var_2_18:setScale(1.2)

	var_2_7._costValue = var_2_18

	local var_2_19 = cc.ShaderSprite:createWithFramename("card_nature_01")

	lc.addChildToCenter(var_2_7, var_2_19, 2)

	var_2_7._natureValue = var_2_19

	local var_2_20 = var_0_0.createTTF(Str(var_2_4._nameSid), var_0_0.FontSize.S1)

	lc.addChildToPos(var_2_7, var_2_20, cc.p(lc.w(var_2_7) / 2, lc.h(var_2_7) - 26), 2)

	var_2_7._nameValue = var_2_20

	local var_2_21 = var_0_0.createStarArea(var_2_4._star or 0, var_2_4._id)

	lc.addChildToPos(var_2_7, var_2_21, cc.p(lc.cw(var_2_7), lc.h(var_2_7) - 58), 2)

	var_2_7._starArea = var_2_21

	local var_2_22 = lc.createSprite("card_magictrap_12")

	lc.addChildToCenter(var_2_7, var_2_22, 2)
	lc.offset(var_2_22, 20, 0)

	var_2_7._magicTrapMark = var_2_22

	local var_2_23 = lc.createSprite("card_quality_bg_01")

	var_2_23:setCascadeOpacityEnabled(true)
	lc.addChildToCenter(var_2_7, var_2_23, 2)

	local var_2_24 = lc.createSprite("card_quality_01")

	lc.addChildToCenter(var_2_23, var_2_24, 2)

	var_2_7._qualityBg = var_2_23
	var_2_7._quality = var_2_24

	local var_2_25 = {}

	for iter_2_0 = 1, 8 do
		local var_2_26 = lc.createSprite("card_link_" .. var_0_7[iter_2_0] .. "_off")

		var_2_26:setRotation(var_0_9[iter_2_0])
		lc.addChildToPos(var_2_7, var_2_26, var_0_8[iter_2_0], 2)

		var_2_25[iter_2_0] = var_2_26
	end

	var_2_7._links = var_2_25

	local var_2_27 = lc.File:isPopupNotify()

	lc.File:setPopupNotify(false)

	local var_2_28 = cc.ShaderSprite:createWithFilename(var_0_0.getCardImageName(arg_2_0, arg_2_2))

	lc.File:setPopupNotify(var_2_27)
	var_2_7:addChild(var_2_28, 0)

	var_2_7._image = var_2_28

	function var_2_28.startFloat(arg_3_0)
		local var_3_0 = arg_3_0._defaultPos

		arg_3_0:runAction(lc.rep(lc.sequence(lc.moveTo(0.6, cc.p(var_3_0.x, var_3_0.y + 16)), lc.moveTo(0.6, var_3_0))))
	end

	function var_2_28.stopFloat(arg_4_0)
		arg_4_0:setPosition(arg_4_0._defaultPos)
	end

	function var_2_7.update(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0, var_5_1, var_5_2, var_5_3 = Data.removeAdditional(arg_5_1)

		arg_5_0._infoId = arg_5_1
		arg_5_0._cardId = var_5_0
		arg_5_0._isGold = var_5_2
		arg_5_0._extraSid = var_5_3
		arg_5_0._skinId = arg_5_2
		arg_5_0._card = card

		local var_5_4, var_5_5 = Data.getInfo(arg_5_1)

		if not var_5_4 then
			return
		end

		local var_5_6 = arg_5_2 and Data._skinInfo[arg_5_2]
		local var_5_7 = var_5_6 and tonumber(string.sub(var_5_6._effect, 1, -3)) or 0
		local var_5_8 = arg_5_0._showInBattle and var_5_6 and var_5_7 ~= 0 and true or false
		local var_5_9 = arg_5_3 and Data._skinInfo[arg_5_3]
		local var_5_10 = arg_5_0._showInBattle and var_5_9 and var_5_9._effect ~= "0.0" and true or false
		local var_5_11 = arg_5_0._showFg and (var_5_5 == Data.CardType.monster or var_5_5 == Data.CardType.rare)

		local curBackId = (arg_5_0._backId and arg_5_0._backId > 0) and arg_5_0._backId or 7600
		arg_5_0._frame:setSpriteFrame(arg_5_0._showFg and var_0_0.getCardFrameName(var_5_4._quality, arg_5_1) or ClientView.getCardBackName(curBackId, arg_5_0._showInBattle))

		if not arg_5_0._showFg then
			arg_5_0._frame:setEffect(nil)
		else
			arg_5_0._frame:setEffect(var_0_0.getCardShader(arg_5_1))
		end

		if var_5_2 and not arg_5_0._goldArea then
			local var_5_12 = ccui.Layout:create()

			var_5_12:setContentSize(ClientView.CARD_SIZE.width - 20, ClientView.CARD_SIZE.height - 20)
			var_5_12:setAnchorPoint(0)
			var_5_12:setClippingEnabled(true)
			var_5_12:setCameraMask(arg_5_0:getCameraMask())
			lc.addChildToCenter(arg_5_0, var_5_12, 10)

			arg_5_0._goldArea = var_5_12

			local var_5_13 = {
				cc.p(0, 0),
				cc.p(lc.cw(var_5_12) / 2, 0),
				cc.p(lc.cw(var_5_12), 0),
				cc.p(lc.w(var_5_12) * 3 / 4, 0),
				cc.p(lc.w(var_5_12), 0),
				cc.p(lc.w(var_5_12), lc.ch(var_5_12) / 2),
				cc.p(lc.w(var_5_12), lc.ch(var_5_12)),
				cc.p(lc.w(var_5_12), lc.h(var_5_12) * 3 / 4),
				cc.p(lc.w(var_5_12), lc.h(var_5_12)),
				cc.p(lc.cw(var_5_12) / 2, lc.h(var_5_12)),
				cc.p(lc.cw(var_5_12), lc.h(var_5_12)),
				cc.p(lc.w(var_5_12) * 3 / 4, lc.h(var_5_12)),
				cc.p(0, lc.h(var_5_12)),
				cc.p(0, lc.ch(var_5_12) / 2),
				cc.p(0, lc.ch(var_5_12)),
				cc.p(0, lc.h(var_5_12) * 3 / 4)
			}
			local var_5_14 = {}
			local var_5_15 = cc.p(lc.cw(var_5_12), lc.ch(var_5_12))

			for iter_5_0, iter_5_1 in ipairs(var_5_13) do
				var_5_14[iter_5_0] = lc.getAngle(iter_5_1, var_5_15)
			end

			local var_5_16 = {}
			local var_5_17 = lc.animate("sd", 0.05, -1)

			function var_5_12.breath()
				local var_6_0 = math.random() * 1

				var_5_12:runAction(lc.sequence(var_6_0, function()
					local var_7_0 = {}
					local var_7_1

					for iter_7_0, iter_7_1 in ipairs(var_5_13) do
						if not var_5_16[iter_7_0] then
							var_7_0[#var_7_0 + 1] = iter_7_0
						end
					end

					if #var_7_0 == 0 then
						return var_5_12.breath()
					end

					local var_7_2 = var_7_0[math.random(#var_7_0)]

					var_5_16[var_7_2] = true

					local var_7_3 = lc.createSprite("sd_01")

					var_7_3:setAnchorPoint(0.5, 0.5)

					local var_7_4 = 1
					local var_7_5 = math.random(1, 3)
					local var_7_6 = lc.rep(lc.sequence(0.0625, function()
						local var_8_0 = var_5_17[var_7_4]

						var_7_3:setSpriteFrame(var_8_0)

						var_7_4 = var_7_4 % #var_5_17 + 1
					end), #var_5_17 * var_7_5)

					var_7_3:runAction(var_7_6)
					var_7_3:runAction(lc.sequence(#var_5_17 * var_7_5 / 12, function()
						var_7_3:removeFromParent()

						var_5_16[var_7_2] = false
					end))
					var_7_3:setRotation(var_5_14[var_7_2])
					var_7_3:setScale(math.random() * 1.2 + 0.3)
					lc.addChildToPos(var_5_12, var_7_3, var_5_13[var_7_2])
					var_7_3:setCameraMask(arg_5_0:getCameraMask())
					var_5_12.breath()
				end))

				return var_6_0
			end

			var_5_12.breath()
		elseif not var_5_2 and arg_5_0._goldArea then
			arg_5_0._goldArea:removeFromParent()

			arg_5_0._goldArea = nil
		end

		if arg_5_0._goldArea then
			arg_5_0._goldArea:setVisible(arg_5_0._showFg and not arg_5_0._showInBattle)

			if arg_5_0._goldArea:isVisible() and arg_5_0._goldArea:getNumberOfRunningActions() == 0 then
				arg_5_0._goldArea.breath()
			end
		end

		if var_5_3 and var_5_3 > 0 and not arg_5_0._extraSidSpr then
			arg_5_0._extraSidSpr = lc.createSprite("img_icon_props_s7347")

			arg_5_0._extraSidSpr:setScale(1.4)
			lc.addChildToPos(arg_5_0, arg_5_0._extraSidSpr, cc.p(lc.cw(arg_5_0), lc.ch(arg_5_0) - 120), 3)
		elseif (not var_5_3 or not (var_5_3 > 0)) and arg_5_0._extraSidSpr then
			arg_5_0._extraSidSpr:removeFromParent()

			arg_5_0._extraSidSpr = nil
		end

		arg_5_0._center:setVisible(arg_5_0._showFg)
		arg_5_0._center:setSpriteFrame("card_frame_bg_" .. (var_5_4._bgId or 0))
		arg_5_0._bottom:setVisible(arg_5_0._showFg and not arg_5_0._showInBattle)
		arg_5_0._bottom:setSpriteFrame(var_0_0.getCardBottomName(var_5_5, var_5_4))


		arg_5_0._valueNode:setVisible(var_5_11)
		arg_5_0._valueNode:setRotation3D({
			z = 0,
			y = 0,
			x = arg_5_0._showInBattle and ClientView.BATTLE_ROTATION_X or 0
		})

		if var_5_11 then
			arg_5_0._starValue:setVisible(arg_5_0._showInBattle and (not var_5_4._link or var_5_4._link[1] == 0))
			arg_5_0._starIcon:setVisible(arg_5_0._showInBattle and (not var_5_4._link or var_5_4._link[1] == 0))
			arg_5_0._atkValue:setAnchorPoint(cc.p(arg_5_0._showInBattle and 1 or 0.5, 0.5))
			arg_5_0._hpValue:setAnchorPoint(cc.p(arg_5_0._showInBattle and 1 or 0.5, 0.5))
			arg_5_0._atkValue:setPosition(arg_5_0._showInBattle and cc.p(arg_5_0._starValue._defaultPos.x, arg_5_0._starValue._defaultPos.y - 60) or arg_5_0._atkValue._defaultPos)
			arg_5_0._hpValue:setPosition(arg_5_0._showInBattle and cc.p(arg_5_0._starValue._defaultPos.x, arg_5_0._starValue._defaultPos.y - 120) or arg_5_0._hpValue._defaultPos)
			arg_5_0._atkValue:setScale(arg_5_0._showInBattle and 2 or 1.2)
			arg_5_0._hpValue:setScale(arg_5_0._showInBattle and 2 or 1.2)

			local var_5_18 = var_5_4._option

			arg_5_0._atkValue:setString(var_5_18 ~= nil and band(var_5_18, Data.MonsterOption.hide_atk) > 0 and "?" or ClientData.formatNum(var_5_4._atk[1], 99999))
			arg_5_0._hpValue:setString(var_5_18 ~= nil and band(var_5_18, Data.MonsterOption.hide_def) > 0 and "?" or var_5_4._link and var_5_4._link[1] ~= 0 and #var_5_4._link or ClientData.formatNum(var_5_4._hp[1], 99999))

			if arg_5_0._showInBattle and var_5_3 and var_5_3 > 0 then
				arg_5_0._extraBg:setVisible(true)
				arg_5_0._extraValue:setString(Str(Data._skillInfo[var_5_3]._nameSid))
			else
				arg_5_0._extraBg:setVisible(false)
			end
		end

		arg_5_0._costBg:setVisible(var_5_11 and var_5_5 ~= Data.CardType.rare and not arg_5_0._showInBattle)
		arg_5_0._costBg:setVisible(false)
		arg_5_0._costValue:setVisible(arg_5_0._costBg:isVisible())

		if var_5_11 and var_5_5 ~= Data.CardType.rare and not arg_5_0._showInBattle then
			arg_5_0._costValue:setString(var_5_4._cost)
		end

		arg_5_0._natureValue:setVisible(arg_5_0._showFg and not arg_5_0._showInBattle)

		if arg_5_0._showFg and not arg_5_0._showInBattle then
			if var_5_5 == Data.CardType.monster or var_5_5 == Data.CardType.rare then
				arg_5_0._natureValue:setSpriteFrame("card_nature_0" .. var_5_4._nature)
			else
				arg_5_0._natureValue:setSpriteFrame(var_5_5 == Data.CardType.magic and "card_nature_magic" or "card_nature_trap")
			end
		end

		arg_5_0._nameValue:setVisible(arg_5_0._showFg and not arg_5_0._showInBattle)
		arg_5_0._nameValue:setString(var_5_2 and Str(var_5_4._nameSid) or Str(var_5_4._nameSid))
		arg_5_0._nameValue:setScale(math.min(1, 180 / lc.w(arg_5_0._nameValue)))
		arg_5_0._starArea:setVisible(var_5_11 and not arg_5_0._showInBattle)

		if var_5_11 and not arg_5_0._showInBattle then
			arg_5_0._starArea:update(var_5_4._star, arg_5_1)
		end

		local var_5_19 = ClientView.getMagicTrapTypeFrameName(arg_5_1)

		arg_5_0._magicTrapMark:setVisible(arg_5_0._showFg and var_5_19 ~= "")

		if arg_5_0._magicTrapMark:isVisible() then
			arg_5_0._magicTrapMark:setSpriteFrame(var_5_19)
		end

		arg_5_0._qualityBg:setVisible(arg_5_0._showFg and not arg_5_0._showInBattle)
		arg_5_0._qualityBg:setSpriteFrame("card_quality_bg_0" .. var_5_4._quality)
		arg_5_0._quality:setSpriteFrame("card_quality_0" .. var_5_4._quality)

		for iter_5_2 = 1, 8 do
			arg_5_0._links[iter_5_2]:setVisible(var_5_11 and var_5_4._link and var_5_4._link[1] ~= 0 or false)
			arg_5_0._links[iter_5_2]:setSpriteFrame("card_link_" .. var_0_7[iter_5_2] .. "_off")
		end

		if var_5_4._link then
			for iter_5_3 = 1, #var_5_4._link do
				local var_5_20 = var_5_4._link[iter_5_3]

				if var_5_20 ~= 0 then
					local var_5_21 = var_5_20 >= 6 and var_5_20 - 1 or var_5_20

					arg_5_0._links[var_5_21]:setSpriteFrame("card_link_" .. var_0_7[var_5_21] .. "_on")
				end
			end
		end

		arg_5_0._image:setOpacity(arg_5_0._showFg and not var_5_8 and 255 or 0)
		arg_5_0._image:stopAllActions()

		if arg_5_0._bones ~= nil then
			arg_5_0._bones:removeFromParent()

			arg_5_0._bones = nil
		end

		if arg_5_0._skinEffectBones then
			arg_5_0._skinEffectBones:removeFromParent()

			arg_5_0._skinEffectBones = nil
		end

		if arg_5_0._showFg then
			local var_5_22 = lc.File:isPopupNotify()

			lc.File:setPopupNotify(false)

			local var_5_23 = lc.TextureCache:addImage(var_0_0.getCardImageName(arg_5_1, arg_5_2))
			if var_5_23 then
				arg_5_0._image:setTexture(var_5_23)
			end
			lc.File:setPopupNotify(var_5_22)
			arg_5_0._image:setLocalZOrder(arg_5_0._showInBattle and 3 or 0)
			arg_5_0._image:setScale(arg_5_0._showInBattle and ClientView.getCardBattleScale(arg_5_1) or 1)
			arg_5_0._image:setRotation3D({
				z = 0,
				y = 0,
				x = arg_5_0._showInBattle and ClientView.BATTLE_ROTATION_X or 0
			})

			local var_5_24 = cc.p(lc.cw(arg_5_0), lc.ch(arg_5_0) + 4)

			arg_5_0._image:setAnchorPoint(cc.p(0.5, arg_5_0._showInBattle and 0.2 or 0.5))

			arg_5_0._image._defaultPos = var_5_24

			arg_5_0._image:setPosition(var_5_24)
		end

		if arg_5_0._showFg and arg_5_0._showInBattle then
			arg_5_0._image:startFloat()

			if var_5_8 then
				arg_5_0._bones = DragonBones.create(var_5_7)

				arg_5_0._bones:gotoAndPlay("effect")
				arg_5_0._bones:setScale(1.3)
				lc.addChildToCenter(arg_5_0._image, arg_5_0._bones)

				function arg_5_0._bones.startFloat()
					return
				end
			end

			if var_5_10 then
				arg_5_0._skinEffectBones = DragonBones.create(var_5_9._effect)

				arg_5_0._skinEffectBones:gotoAndPlay("effect")

				local var_5_25 = false

				if var_5_9._effect == "emozhanchang11" then
					var_5_25 = true
				end

				lc.addChildToPos(arg_5_0._image, arg_5_0._skinEffectBones, cc.p(lc.cw(arg_5_0._image), 0), var_5_25 and -1 or 1)
			end

			if ClientData._cfg and ClientData._cfg.testEffects then
				if ClientData._cfg.testEffects == true then
					local var_5_26 = {
						"busizhanchang11",
						"emozhanchang11",
						"jixiezhanchang11",
						"longzuzhanchang11",
						"mofashizhanchang11",
						"niandonglizhanchang11",
						"niaoshouzhanchang11",
						"tianshizhanchang11",
						"yanshizhanchang11",
						"yanzuzhanchang11",
						"shuizhanchang11"
					}

					Data._zhanchangIndex = Data._zhanchangIndex or 0
					Data._zhanchangIndex = (Data._zhanchangIndex + 1) % #var_5_26 + 1
					arg_5_0._skinEffectBones = DragonBones.create(var_5_26[Data._zhanchangIndex])

					arg_5_0._skinEffectBones:gotoAndPlay("effect")
					lc.addChildToPos(arg_5_0._image, arg_5_0._skinEffectBones, cc.p(lc.cw(arg_5_0._image), 0), -1)
				elseif ClientData._cfg.testEffects.onBoard then
					arg_5_0._skinEffectBones = DragonBones.create(ClientData._cfg.testEffects.onBoard)

					arg_5_0._skinEffectBones:gotoAndPlay("effect")

					local var_5_27 = false

					if ClientData._cfg.testEffects.onBoard == "emozhanchang11" then
						var_5_27 = true
					end

					lc.addChildToPos(arg_5_0._image, arg_5_0._skinEffectBones, cc.p(lc.cw(arg_5_0._image), 0), var_5_27 and -1 or 1)
				end
			end
		else
			arg_5_0._image:stopFloat()
		end
	end

	function var_2_7.setEffect(arg_11_0, arg_11_1)
		arg_11_0._center:setEffect(arg_11_1)
		arg_11_0._image:setEffect(arg_11_1)
		arg_11_0._bottom:setEffect(effectE)
		arg_11_0._costBg:setEffect(arg_11_1)
		arg_11_0._natureValue:setEffect(arg_11_1)
		arg_11_0._starArea:setEffect(arg_11_1)
	end

	function var_2_7.setStatus(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0._showFg ~= arg_12_1 or arg_12_0._showInBattle ~= arg_12_2 then
			arg_12_0._showFg = arg_12_1
			arg_12_0._showInBattle = arg_12_2

			arg_12_0:update(arg_12_0._infoId, arg_12_0._skinId, arg_12_0._effectId)
		end
	end

	var_2_7:update(arg_2_0, arg_2_2, arg_2_3)

	return var_2_7
end

function var_0_0.createCardShadow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = lc.createSprite(var_0_0.getCardShadowFrameName(card))
	var_13_0:setVisible(false)

	function var_13_0.update(arg_14_0, arg_14_1)
		arg_14_0:setSpriteFrame(var_0_0.getCardShadowFrameName(arg_14_1))
		arg_14_0:setScale(4 * (arg_13_1 or 1))

		if arg_14_1 then
			arg_13_2, arg_13_3 = arg_13_2 or var_0_0.CARD_SIZE.width / 2, arg_13_3 or var_0_0.CARD_SIZE.height / 2

			arg_14_0:setPosition(arg_13_2 + 8, arg_13_3 - 8)
		end
	end

	var_13_0:update(arg_13_0)

	return var_13_0
end

function var_0_0.createUnionInfoArea(arg_15_0, arg_15_1)
	local var_15_0 = lc.createNode()
	local var_15_1 = lc.createSprite("avatar_badge_s_1")

	var_15_0._badge = var_15_1

	local var_15_2 = cc.Label:createWithTTF(arg_15_0 and arg_15_0._unionName or "", var_0_0.TTF_FONT, var_0_0.FontSize.S2)

	var_15_2:setAnchorPoint(arg_15_1 and 1 or 0, 0.5)
	var_15_2:setColor(var_0_0.COLOR_TEXT_DARK)

	var_15_0._name = var_15_2

	local var_15_3 = lc.w(var_15_1) + 6 + lc.w(var_15_2)
	local var_15_4 = lc.h(var_15_1)

	var_15_0:setContentSize(var_15_3, var_15_4)

	if arg_15_1 then
		lc.addChildToPos(var_15_0, var_15_2, cc.p(lc.w(var_15_2), var_15_4 / 2))
		lc.addChildToPos(var_15_0, var_15_1, cc.p(lc.right(var_15_2) + 6 + lc.w(var_15_1) / 2, lc.y(var_15_2)))
	else
		lc.addChildToPos(var_15_0, var_15_1, cc.p(lc.w(var_15_1) / 2, var_15_4 / 2))
		lc.addChildToPos(var_15_0, var_15_2, cc.p(lc.right(var_15_1) + 6, lc.y(var_15_1)))
	end

	local var_15_5 = cc.Label:createWithTTF(arg_15_0 and arg_15_0._unionWord or "", var_0_0.TTF_FONT, 18)

	var_15_5:setColor(lc.Color3B.yellow)
	lc.addChildToPos(var_15_0, var_15_5, cc.p(lc.x(var_15_1), lc.y(var_15_1) + 2))

	var_15_0._word = var_15_5

	function var_15_0.setName(arg_16_0, arg_16_1)
		arg_16_0._name:setString(arg_16_1)
	end

	return var_15_0
end

function var_0_0.createVerticalTabListArea(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = cc.size(var_0_0.VERTICAL_TAB_WIDTH, arg_17_0)
	local var_17_1 = lc.createNode(var_17_0)
	local var_17_2 = cc.size(var_17_0.width, arg_17_0)
	local var_17_3 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_27", var_0_0.CRECT_COM_BG27)

	var_17_3:setContentSize(cc.size(var_17_0.width + (arg_17_3 or 0), var_17_0.height))
	var_17_3:setAnchorPoint(1, 0)
	lc.addChildToPos(var_17_1, var_17_3, cc.p(var_17_0.width, 0))

	local var_17_4 = lc.createSprite("img_divide_line_6")

	var_17_4:setScale(1, lc.h(var_17_3) / lc.h(var_17_4))
	lc.addChildToPos(var_17_1, var_17_4, cc.p(lc.right(var_17_3) - 4, var_17_0.height / 2))

	local var_17_5 = lc.List.createV(var_17_2, 20, 8)

	var_17_5:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_17_1, var_17_5)
	lc.offset(var_17_5, 12, 0)

	var_17_1._list = var_17_5
	var_17_1._callback = arg_17_2

	function var_17_1.showTab(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0, var_18_1, var_18_2 = var_17_5:getItems()

		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			if iter_18_1._index == arg_18_1 then
				var_18_1 = iter_18_1
				var_18_2 = iter_18_0

				break
			end
		end

		if var_18_1.checkValid and not var_18_1.checkValid() then
			return
		end

		local var_18_3

		if var_18_1._tabs then
			var_18_1._icon:stopAllActions()

			if var_18_2 == arg_18_0._expandedTabIndex then
				if arg_18_0._focusedTab and arg_18_0._focusedTab._expandedIndex == var_18_2 then
					arg_18_0._focusedTab = nil
				end

				local var_18_4 = var_18_0[arg_18_0._expandedTabIndex]

				for iter_18_2 = 1, #var_18_4._tabs do
					var_17_5:removeItem(arg_18_0._expandedTabIndex)
				end

				arg_18_0._expandedTabIndex = -1

				var_18_1._icon:runAction(lc.rotateTo(0.1, -90))
			else
				if arg_18_0._focusedTab and arg_18_0._focusedTab._index ~= nil and arg_18_0._focusedTab._isSub then
					arg_18_0._focusedTab = nil
				end

				if arg_18_0._expandedTabIndex ~= -1 then
					local var_18_5 = var_18_0[arg_18_0._expandedTabIndex]

					for iter_18_3 = 1, #var_18_5._tabs do
						var_17_5:removeItem(arg_18_0._expandedTabIndex)
					end

					arg_18_0._expandedTabIndex = -1
				end

				local var_18_6, var_18_7, var_18_8 = var_17_5:getItems()

				for iter_18_4, iter_18_5 in ipairs(var_18_6) do
					if iter_18_5._index == arg_18_1 then
						var_18_7 = iter_18_5
						var_18_8 = iter_18_4

						break
					end
				end

				for iter_18_6, iter_18_7 in ipairs(var_18_7._tabs) do
					local var_18_9 = arg_18_0:createTab(iter_18_7, iter_18_7._subIndex, cc.size(180, 70))

					var_17_5:insertCustomItem(var_18_9, var_18_8)
				end

				arg_18_0._expandedTabIndex = var_18_8

				var_18_7._icon:runAction(lc.rotateTo(0.1, 0))
			end

			var_18_3 = true

			if arg_18_0._subTabExpandCallback then
				arg_18_0._subTabExpandCallback(var_18_1)
			end
		else
			local var_18_10 = arg_18_0._focusedTab == var_18_1

			if not var_18_10 then
				local var_18_11 = arg_18_0._focusedTab

				if var_18_11 then
					var_18_11:loadTextureNormal("img_btn_tab_bg_unfocus_3", ccui.TextureResType.plistType)
					var_18_11:setColor(var_18_11._isSub and cc.c3b(180, 250, 255) or lc.Color3B.white)

					if var_18_11._isSub then
						var_18_11._expandedIndex = nil
					end

					if var_18_11._scaleSize then
						var_18_11:setContentSize(var_18_11._scaleSize)
					end
				end

				arg_18_0._focusedTab = var_18_1

				if var_18_1._isSub then
					var_18_1._expandedIndex = arg_18_0._expandedTabIndex
				end

				var_18_1:loadTextureNormal("img_btn_tab_bg_focus_3", ccui.TextureResType.plistType)

				if var_18_1._scaleSize then
					var_18_1:setContentSize(var_18_1._scaleSize)
				end
			end

			if arg_18_0._callback then
				arg_18_0._callback(var_18_1, var_18_10, arg_18_2)
			end
		end

		if var_18_3 then
			arg_18_0:checkListBounce()
		end

		if not arg_18_2 then
			local var_18_12 = var_17_5:getInnerContainerSize().height
			local var_18_13 = math.max(var_18_12 - lc.bottom(var_18_1) - lc.h(var_17_5) + var_17_5:getItemsMargin(), 0)

			var_17_5:gotoPos(var_18_13)
		end
	end

	function var_17_1.createTab(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
		local var_19_0 = var_0_0.createShaderButton("img_btn_tab_bg_unfocus_3")

		if arg_19_3 then
			var_19_0:ignoreContentAdaptWithSize(false)
			var_19_0:setContentSize(arg_19_3)

			var_19_0._scaleSize = arg_19_3
		end

		local var_19_1
		local var_19_2

		if type(arg_19_1) == "string" then
			var_19_1 = arg_19_1
			var_19_0._index = arg_19_2
		else
			var_19_1 = arg_19_1._str
			var_19_2 = arg_19_1._icon
			var_19_0._index = arg_19_1._index or arg_19_2
			var_19_0._userData = arg_19_1._userData
			var_19_0._tabs = arg_19_1._tabs
			var_19_0._isSub = arg_19_1._isSub
			var_19_0.checkValid = arg_19_1.checkValid
		end

		var_19_0:setName(var_19_1)
		var_19_0:addLabel(var_19_1, var_19_0._isSub and var_0_0.COLOR_TEXT_LIGHT or var_0_0.COLOR_TEXT_LIGHT)
		lc.offset(var_19_0._label, -14, 0)
		var_19_0:setColor(var_19_0._isSub and cc.c3b(180, 250, 255) or lc.Color3B.white)

		function var_19_0._callback()
			var_17_1:showTab(var_19_0._index, true)
		end

		if var_19_2 then
			var_19_0:addIcon(var_19_2)
		end

		if var_19_0._tabs then
			var_19_0:addIcon("img_arrow_down_2")
			var_19_0._icon:setColor(lc.Color3B.yellow)
			var_19_0._icon:setRotation(-90)
		end

		return var_19_0
	end

	function var_17_1.resetTabs(arg_21_0, arg_21_1)
		var_17_5:removeAllItems()

		arg_21_0._focusedTab = nil
		arg_21_0._expandedTabIndex = -1

		for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
			local var_21_0 = arg_21_0:createTab(iter_21_1, iter_21_0)

			var_17_5:pushBackCustomItem(var_21_0)
		end

		arg_21_0:checkListBounce()
	end

	function var_17_1.checkListBounce(arg_22_0)
		var_17_5:forceDoLayout()

		local var_22_0 = var_17_5:getInnerContainerSize().height

		var_17_5:setBounceEnabled(var_22_0 > var_17_2.height)
	end

	function var_17_1.focusAtPos(arg_23_0, arg_23_1)
		local var_23_0 = var_17_5:getItems()[arg_23_1]

		if var_23_0 then
			arg_23_0:showTab(var_23_0._index)
		end
	end

	if arg_17_1 then
		var_17_1:resetTabs(arg_17_1)
	end

	return var_17_1
end

function var_0_0.createVerticalIconTabListArea(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = cc.size(var_0_0.VERTICAL_TAB_WIDTH, arg_24_0)
	local var_24_1 = lc.createNode(var_24_0)
	local var_24_2 = cc.size(var_24_0.width, arg_24_0)
	local var_24_3 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_27", var_0_0.CRECT_COM_BG27)

	var_24_3:setContentSize(cc.size(var_24_0.width + (arg_24_3 or 0), var_24_0.height))
	var_24_3:setAnchorPoint(1, 0)
	lc.addChildToPos(var_24_1, var_24_3, cc.p(var_24_0.width, 0))

	local var_24_4 = lc.createSprite("img_divide_line_6")

	var_24_4:setScale(1, lc.h(var_24_3) / lc.h(var_24_4))
	lc.addChildToPos(var_24_1, var_24_4, cc.p(lc.right(var_24_3) - 4, var_24_0.height / 2))

	local var_24_5 = lc.List.createV(var_24_2, 0, -30)

	var_24_5:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_24_1, var_24_5)
	lc.offset(var_24_5, 0, 0)

	var_24_1._list = var_24_5
	var_24_1._callback = arg_24_2

	function var_24_1.showTab(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0, var_25_1, var_25_2 = var_24_5:getItems()

		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			if iter_25_1._index == arg_25_1 then
				var_25_1 = iter_25_1

				local var_25_3 = iter_25_0

				break
			end
		end

		if var_25_1.checkValid and not var_25_1.checkValid() then
			return
		end

		local var_25_4 = arg_25_0._focusedTab == var_25_1

		if not var_25_4 then
			local var_25_5 = arg_25_0._focusedTab

			if var_25_5 then
				var_25_5:loadTextureNormal("img_btn_tab_bg_unfocus_4", ccui.TextureResType.plistType)
				var_25_5._arrow:setVisible(false)
				var_25_5._fg:setScale(0.9)
			end

			arg_25_0._focusedTab = var_25_1

			var_25_1:loadTextureNormal("img_btn_tab_bg_focus_4", ccui.TextureResType.plistType)
			var_25_1._arrow:setVisible(true)
			var_25_1._fg:setScale(1)
		end

		if arg_25_0._callback then
			arg_25_0._callback(var_25_1, var_25_4, arg_25_2)
		end

		if not arg_25_2 then
			local var_25_6 = var_24_5:getInnerContainerSize().height
			local var_25_7 = math.max(var_25_6 - lc.bottom(var_25_1) - lc.h(var_24_5) + var_24_5:getItemsMargin(), 0)

			var_24_5:gotoPos(var_25_7)
		end
	end

	function var_24_1.createTab(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = var_0_0.createShaderButton("img_btn_tab_bg_unfocus_4")

		icon = arg_26_1._icon
		var_26_0._index = arg_26_1._index or arg_26_2
		var_26_0._userData = arg_26_1._userData
		var_26_0._tabs = arg_26_1._tabs
		var_26_0.checkValid = arg_26_1.checkValid

		local var_26_1 = lc.createSpriteWithMask(icon)

		lc.addChildToCenter(var_26_0, var_26_1)
		var_26_1:setScale(0.9)

		var_26_0._fg = var_26_1

		local var_26_2 = lc.createSprite("img_btn_tab_bg_focus_4_top")

		lc.addChildToCenter(var_26_1, var_26_2)
		var_26_2:setVisible(false)

		var_26_0._arrow = var_26_2

		function var_26_0._callback()
			var_24_1:showTab(var_26_0._index, true)
		end

		return var_26_0
	end

	function var_24_1.resetTabs(arg_28_0, arg_28_1)
		var_24_5:removeAllItems()

		arg_28_0._focusedTab = nil
		arg_28_0._expandedTabIndex = -1

		for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
			local var_28_0 = arg_28_0:createTab(iter_28_1, iter_28_0)

			var_24_5:pushBackCustomItem(var_28_0)
		end
	end

	function var_24_1.focusAtPos(arg_29_0, arg_29_1)
		local var_29_0 = var_24_5:getItems()[arg_29_1]

		if var_29_0 then
			arg_29_0:showTab(var_29_0._index)
		end
	end

	if arg_24_1 then
		var_24_1:resetTabs(arg_24_1)
	end

	return var_24_1
end

function var_0_0.getCardFrameName(arg_30_0, arg_30_1)
	local var_30_0, var_30_1, var_30_2 = Data.removeAdditional(arg_30_1)

	if not var_30_2 then
		return "card_frame_quality_0" .. arg_30_0
	else
		return "card_frame_quality_" .. var_0_0.getCardFrameIndex(arg_30_1)
	end
end

function var_0_0.getCardBackName(arg_31_0, arg_31_1)
	local var_31_0 = (arg_31_1 and "card_back_square" or "card_back") .. "_" .. (arg_31_0 and arg_31_0 - 7600 or 0)
	local var_31_1 = var_31_0 .. "_" .. ClientData.getSubChannelName()

	if lc.FrameCache:getSpriteFrame(var_31_1) then
		var_31_0 = var_31_1
	end

	return var_31_0
end

function var_0_0.getCardBottomName(arg_32_0, arg_32_1)
	if arg_32_0 == Data.CardType.monster or arg_32_0 == Data.CardType.rare then
		return arg_32_1._link and arg_32_1._link[1] ~= 0 and "card_frame_bottom_link" or "card_frame_bottom_monster"
	elseif arg_32_0 == Data.CardType.magic then
		return "card_frame_bottom_magic"
	elseif arg_32_0 == Data.CardType.trap then
		return "card_frame_bottom_trap"
	end
end

function var_0_0.getCardLevelName(arg_33_0)
	return "card_frame_level_0" .. arg_33_0
end

function var_0_0.getCardImageName(arg_34_0, arg_34_1)
	local var_34_0, var_34_1, var_34_2 = Data.removeAdditional(arg_34_0)

	arg_34_0 = var_34_0

	local var_34_3 = arg_34_1 and arg_34_1 > 0 and arg_34_1 or ClientData.getPicIdByInfoId(arg_34_0)
	local var_34_4 = ""
	local var_34_5 = Data.getType(tonumber(var_34_3))

	if var_34_5 == Data.CardType.monster or var_34_5 == Data.CardType.monster_skin then
		var_34_4 = "res/thumb_monster/%s.lcres"
	elseif var_34_5 == Data.CardType.magic then
		var_34_4 = "res/thumb_magic/%s.lcres"
	elseif var_34_5 == Data.CardType.trap then
		var_34_4 = "res/thumb_trap/%s.lcres"
	elseif var_34_5 == Data.CardType.rare or var_34_5 == Data.CardType.polymerization_skin then
		var_34_4 = "res/thumb_rare/%s.lcres"
	end

	if ClientData.isAnotherCardImageSkin() or (var_34_0 == 10305 or var_34_0 == 10306) and not ClientData.isYYB() then
		local var_34_6 = var_34_3 .. "_3"
		local var_34_7 = var_34_6 .. ((var_34_5 == Data.CardType.magic or var_34_5 == Data.CardType.trap) and ".jpg" or ".jpm")
		local var_34_8 = string.format(var_34_4, var_34_6)

		TextureManager.loadTexture(var_34_7, var_34_8)

		if lc.TextureCache:getTextureForKey(var_34_7) then
			var_34_3 = var_34_6
		end
	end

	local var_34_9 = ""
	local var_34_10 = string.format(var_34_4, var_34_3)
	local var_34_11 = var_34_3 .. ((var_34_5 == Data.CardType.magic or var_34_5 == Data.CardType.trap) and ".jpg" or ".jpm")

	TextureManager.loadTexture(var_34_11, var_34_10)

	-- Web H5 loads asynchronously, do not fall back to 10001 dragon
	return var_34_11
end

function var_0_0.getCardIconName(arg_35_0)
	local var_35_0 = Data.removeAdditional(arg_35_0)
	local var_35_1 = string.format("card_ico_%d", ClientData.getPicIdByInfoId(var_35_0))

	if ClientData.isAnotherCardImageSkin() and lc.FrameCache:getSpriteFrame(var_35_1 .. "_3") then
		var_35_1 = var_35_1 .. "_3"
	end

	if lc.FrameCache:getSpriteFrame(var_35_1) == nil then
		local var_35_2 = Data.getType(arg_35_0)
		local defaultName
		if var_35_2 == Data.CardType.monster then
			defaultName = "card_ico_monster_default"
		elseif var_35_2 == Data.CardType.magic then
			defaultName = "card_ico_magic_default"
		elseif var_35_2 == Data.CardType.trap then
			defaultName = "card_ico_trap_default"
		elseif var_35_2 == Data.CardType.rare then
			defaultName = "card_ico_rare_default"
		elseif var_35_2 == Data.CardType.props or var_35_2 == Data.CardType.item_skill then
			defaultName = "card_ico_prop_default"
		end
		if defaultName and lc.FrameCache:getSpriteFrame(defaultName) then
			var_35_1 = defaultName
		end
	end

	return var_35_1
end

function var_0_0.getCardShadowFrameName(arg_36_0)
	return "card_shadow"
end

function var_0_0.getCardFrameIndex(arg_37_0)
	local var_37_0, var_37_1, var_37_2 = Data.removeAdditional(arg_37_0)

	arg_37_0 = var_37_0

	local var_37_3, var_37_4 = Data.getInfo(arg_37_0)
	local var_37_5 = var_37_4

	if var_37_4 == Data.CardType.monster then
		if band(var_37_3._option, Data.MonsterOption.is_ceremony) ~= 0 then
			return var_37_4 + 101
		elseif band(var_37_3._option, Data.MonsterOption.is_normal) == 0 then
			return var_37_4 + 100
		else
			return var_37_4
		end
	elseif var_37_4 == Data.CardType.rare then
		if band(var_37_3._option, Data.MonsterOption.is_sync) ~= 0 then
			return var_37_4 + 200
		elseif band(var_37_3._option, Data.MonsterOption.is_xyz) ~= 0 then
			return var_37_4 + 201
		elseif band(var_37_3._option, Data.MonsterOption.is_link) ~= 0 then
			return var_37_4 + 202
		end
	end

	return var_37_5
end

function var_0_0.getCardShader(arg_38_0)
	if Data.isGold(arg_38_0) then
		return nil
	else
		return var_0_0.SHADER_TYPES[var_0_0.getCardFrameIndex(arg_38_0)]
	end
end

function var_0_0.getMagicTrapTypeFrameName(arg_39_0)
	local var_39_0, var_39_1, var_39_2 = Data.removeAdditional(arg_39_0)

	arg_39_0 = var_39_0

	local var_39_3, var_39_4 = Data.getInfo(arg_39_0)

	if var_39_4 == Data.CardType.magic then
		if band(var_39_3._option, Data.MagicOption.is_equipment) > 0 then
			return "card_magictrap_15"
		elseif band(var_39_3._option, Data.MagicOption.is_sustainable) > 0 then
			return "card_magictrap_13"
		elseif band(var_39_3._option, Data.MagicOption.is_field) > 0 then
			return "card_magictrap_14"
		end
	elseif var_39_4 == Data.CardType.trap then
		if band(var_39_3._option, Data.TrapOption.is_counter) > 0 then
			return "card_magictrap_12"
		elseif band(var_39_3._option, Data.TrapOption.is_sustainable) > 0 then
			return "card_magictrap_13"
		end
	end

	return ""
end

function var_0_0.getCardBattleScale(arg_40_0)
	local var_40_0, var_40_1, var_40_2 = Data.removeAdditional(arg_40_0)

	arg_40_0 = var_40_0

	return arg_40_0 == 10606 and 2.1 or 1.7
end

function var_0_0.popScene(arg_41_0)
	GuideManager.stopGuide()

	if arg_41_0 then
		lc.Director:popToRootScene()
	else
		lc.Director:popScene()
	end
end

function var_0_0.popSceneTo(arg_42_0)
	local var_42_0 = BaseScene._sceneList
	local var_42_1

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if iter_42_1._sceneId == arg_42_0 then
			var_42_1 = iter_42_0

			break
		end
	end

	if var_42_1 then
		GuideManager.stopGuide()
		lc.Director:popToSceneStackLevel(var_42_1)
	end
end

function var_0_0.isInBattleScene()
	local var_43_0 = lc._runningScene

	if var_43_0 then
		return var_43_0._sceneId == ClientData.SceneId.battle
	end

	return false
end

function var_0_0.isInBattleServerScene()
	local var_44_0 = lc._runningScene

	if var_44_0 then
		return var_44_0._sceneId == ClientData.SceneId.battle or var_44_0._sceneId == ClientData.SceneId.in_room or var_44_0._sceneId == ClientData.SceneId.survival_hall or var_44_0._sceneId == ClientData.SceneId.survival_ex_hall
	end

	return false
end

function var_0_0.hasWorldScene()
	local var_45_0 = BaseScene._sceneList[2]

	return var_45_0 and var_45_0._sceneId == ClientData.SceneId.world
end

function var_0_0.blockTouch(arg_46_0)
	local var_46_0 = var_0_0._blockTouchLayer

	if var_46_0 == nil then
		var_46_0 = var_0_0.createTouchLayer()

		var_46_0:setTouchEnabled(false)
		var_46_0:retain()

		var_0_0._blockTouchLayer = var_46_0
	end

	if var_46_0:getParent() then
		var_46_0:removeFromParent()
	end

	var_46_0:setTouchEnabled(true)
	var_46_0:registerScriptHandler(function(arg_47_0)
		if arg_47_0 == "exit" or arg_47_0 == "cleanup" then
			var_46_0:setTouchEnabled(false)
		end
	end)
	arg_46_0:addChild(var_46_0)
end

function var_0_0.createTouchLayer()
	local var_48_0 = cc.Layer:create()

	var_48_0:setTouchEnabled(true)
	var_48_0:registerScriptTouchHandler(function(arg_49_0, arg_49_1, arg_49_2)
		if arg_49_0 == "began" then
			if var_48_0 == var_0_0._blockTouchLayer then
				local var_49_0, var_49_1 = var_48_0:getParent()

				if var_49_0 and var_49_0._titleLabel and var_49_0._titleLabel.getString then
					local var_49_2 = var_49_0._titleLabel:getString()
				end
			end

			if var_48_0:isTouchEnabled() then
				if var_48_0._touchHandler then
					return var_48_0._touchHandler(arg_49_0, arg_49_1, arg_49_2)
				else
					return 1
				end
			else
				return 0
			end
		end
	end, false, -2, true)

	return var_48_0
end

function var_0_0.createBoldRichText(arg_50_0, arg_50_1, arg_50_2)
	arg_50_1 = arg_50_1 or {}

	local var_50_0 = ccui.RichTextEx:create()

	var_0_0.appendBoldRichText(var_50_0, arg_50_0, arg_50_1)

	arg_50_2 = arg_50_1._width or arg_50_2

	if arg_50_2 then
		var_50_0:setMaxWidth(arg_50_2)
	end

	var_50_0:setTouchEnabled(false)
	var_50_0:formatText()
	var_50_0:setCascadeOpacityEnabled(true)

	return var_50_0
end

function var_0_0.appendBoldRichText(arg_51_0, arg_51_1, arg_51_2)
	arg_51_2 = arg_51_2 or {}

	local var_51_0 = arg_51_2._normalClr or var_0_0.COLOR_TEXT_LIGHT
	local var_51_1 = arg_51_2._fontSize or var_0_0.FontSize.S2
	local var_51_2 = 1
	local var_51_3 = string.len(arg_51_1)

	if var_51_3 == 0 then
		arg_51_0:insertElement(ccui.RichItemNewLine:create(0))
	else
		while var_51_2 <= var_51_3 do
			local var_51_4, var_51_5 = string.find(arg_51_1, arg_51_2._beginTag or "|", var_51_2)

			if var_51_4 == nil then
				arg_51_0:insertElement(ccui.RichItemLabel:create(0, var_51_0, 255, string.sub(arg_51_1, var_51_2, var_51_3), var_0_0.TTF_FONT, var_51_1))

				var_51_2 = var_51_3 + 1
			else
				arg_51_0:insertElement(ccui.RichItemLabel:create(0, var_51_0, 255, string.sub(arg_51_1, var_51_2, var_51_4 - 1), var_0_0.TTF_FONT, var_51_1))

				if arg_51_1[var_51_4 + 1] == "\\" then
					var_51_5 = string.find(arg_51_1, "\\", var_51_4 + 2)

					local var_51_6 = string.sub(arg_51_1, var_51_4 + 2, var_51_5 - 1)

					if var_51_6[1] == "#" then
						local var_51_7 = tonumber("0x" .. string.sub(var_51_6, 2, 3))
						local var_51_8 = tonumber("0x" .. string.sub(var_51_6, 4, 5))
						local var_51_9 = tonumber("0x" .. string.sub(var_51_6, 6, 7))

						boldClr = cc.c3b(var_51_7, var_51_8, var_51_9)
					else
						local var_51_10 = string.splitByChar(var_51_6, ".")

						if #var_51_10 == 1 then
							boldClr = lc.Color3B[var_51_10[1]]
						else
							boldClr = cc.c3b(var_51_10[1], var_51_10[2], var_51_10[3])
						end
					end
				else
					boldClr = arg_51_2._boldClr or var_0_0.COLOR_TEXT_PURPLE
				end

				var_51_2 = var_51_5 + 1

				local var_51_11, var_51_12 = string.find(arg_51_1, arg_51_2._endTag or "|", var_51_2)

				if var_51_11 == nil then
					var_51_11, var_51_12 = var_51_3 + 1, var_51_3
				end

				arg_51_0:insertElement(ccui.RichItemLabel:create(0, boldClr, 255, string.sub(arg_51_1, var_51_2, var_51_11 - 1), var_0_0.TTF_FONT, var_51_1))

				var_51_2 = var_51_12 + 1
			end
		end
	end
end

function var_0_0.createBoldRichTextMultiLine(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = ccui.RichTextEx:create()

	arg_52_2 = arg_52_1._width or arg_52_2

	if arg_52_2 then
		var_52_0:setMaxWidth(arg_52_2)
	end

	local var_52_1 = string.splitByChar(arg_52_0, "\n")

	for iter_52_0, iter_52_1 in ipairs(var_52_1) do
		var_0_0.appendBoldRichText(var_52_0, iter_52_1, arg_52_1)

		if iter_52_0 < #var_52_1 then
			var_52_0:insertElement(ccui.RichItemNewLine:create(0))
		end
	end

	var_52_0:formatText()

	return var_52_0
end

function var_0_0.updateBoldRichTextMultiLine(arg_53_0, arg_53_1, arg_53_2)
	arg_53_0:removeAllElements()

	local var_53_0 = string.split(arg_53_1, "\n")

	for iter_53_0, iter_53_1 in ipairs(var_53_0) do
		var_0_0.appendBoldRichText(arg_53_0, iter_53_1, arg_53_2)

		if iter_53_0 < #var_53_0 then
			arg_53_0:insertElement(ccui.RichItemNewLine:create(0))
		end
	end

	arg_53_0:formatText()
end

function var_0_0.createBoldRichTextWithIcons(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = ccui.RichTextEx:create()

	arg_54_2 = arg_54_1._width or arg_54_2

	if arg_54_2 then
		var_54_0:setMaxWidth(arg_54_2)
	end

	local var_54_1 = #arg_54_0
	local var_54_2 = 0

	while var_54_2 < var_54_1 do
		local var_54_3 = string.find(arg_54_0, "%[", var_54_2 + 1)

		if var_54_3 then
			if var_54_3 > var_54_2 + 1 then
				var_0_0.appendBoldRichText(var_54_0, string.sub(arg_54_0, var_54_2 + 1, var_54_3 - 1), arg_54_1)
			end

			var_54_2 = var_54_3

			local var_54_4 = string.find(arg_54_0, "%]", var_54_2 + 1)

			var_54_0:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, lc.createSprite(string.sub(arg_54_0, var_54_2 + 1, var_54_4 - 1))))

			var_54_2 = var_54_4
		elseif var_54_1 > var_54_2 + 1 then
			var_0_0.appendBoldRichText(var_54_0, string.sub(arg_54_0, var_54_2 + 1, var_54_1), arg_54_1)

			var_54_2 = var_54_1
		end
	end

	var_54_0:setTouchEnabled(false)
	var_54_0:formatText()

	return var_54_0
end

function var_0_0.createTouchSpriteWithMask(arg_55_0, arg_55_1)
	local var_55_0 = lc.createSpriteWithMask(arg_55_0)
	local var_55_1 = ccui.Widget:create()

	var_55_1:setContentSize(var_55_0:getContentSize())
	var_55_1:setTouchEnabled(true)
	var_55_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_55_1:addTouchEventListener(function(arg_56_0, arg_56_1)
		if arg_56_1 == ccui.TouchEventType.ended then
			arg_55_1(arg_56_0)
		end
	end)
	lc.addChildToCenter(var_55_1, var_55_0)

	var_55_1._sprite = var_55_0

	return var_55_1
end

function var_0_0.createTouchSpriteWithShader(arg_57_0, arg_57_1)
	local var_57_0 = cc.ShaderSprite:createWithFramename(arg_57_0)
	local var_57_1 = ccui.Widget:create()
	var_57_1:setContentSize(var_57_0:getContentSize())
	var_57_1:setTouchEnabled(true)
	var_57_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_57_1:addTouchEventListener(function(arg_58_0, arg_58_1)
		if arg_58_1 == ccui.TouchEventType.ended then
			if AUDIO and AUDIO.E_BUTTON_DEFAULT and lc and lc.Audio and lc.Audio.playAudio then
				pcall(function() lc.Audio.playAudio(AUDIO.E_BUTTON_DEFAULT) end)
			end
			arg_57_1(arg_58_0)
		end
	end)
	lc.addChildToCenter(var_57_1, var_57_0)
	var_57_1._sprite = var_57_0

	return var_57_1
end

local AVAILABLE_BTN_SIZES = {
	{60, 50}, {60, 60}, {80, 40}, {80, 60}, {82, 60},
	{100, 40}, {100, 60}, {100, 78}, {110, 44}, {110, 60}, {110, 78},
	{120, 40}, {120, 60}, {120, 70}, {120, 78},
	{140, 44}, {140, 60}, {140, 70}, {140, 78}, {146, 70},
	{150, 60}, {150, 78}, {152, 78}, {160, 60}, {160, 78}, {170, 78},
	{180, 50}, {180, 56}, {180, 60}, {180, 70}, {180, 78},
	{200, 60}, {200, 78}, {210, 60}, {210, 78},
	{220, 60}, {220, 70}, {220, 78}, {240, 78},
	{250, 56}, {250, 60}, {250, 78}, {260, 60}, {260, 64}, {260, 78}, {300, 78}
}

local function getCustomButtonFile(btnName, targetW, targetH)
	if not btnName or type(btnName) ~= "string" then return nil end
	local isConfirm = (btnName == "img_btn_1" or btnName == "img_btn_1_s")
	local isCancel = (btnName == "img_btn_2" or btnName == "img_btn_2_s")
	local isRed = (btnName == "img_btn_3" or btnName == "img_btn_3_s")
	if not isConfirm and not isCancel and not isRed then return nil end

	local isSmall = string.find(btnName, "_s") ~= nil
	targetW = math.floor(tonumber(targetW) or (isSmall and 120 or 180))
	targetH = math.floor(tonumber(targetH) or (isSmall and 60 or 78))
	if targetW < 30 then targetW = isSmall and 120 or 180 end
	if targetH < 20 then targetH = isSmall and 60 or 78 end

	local kind = isRed and "red" or (isCancel and "cancel" or "confirm")

	local bestW, bestH = isSmall and 120 or 180, isSmall and 60 or 78
	local minDiff = 999999
	for i = 1, #AVAILABLE_BTN_SIZES do
		local sz = AVAILABLE_BTN_SIZES[i]
		local dw = math.abs(sz[1] - targetW)
		local dh = math.abs(sz[2] - targetH)
		local diff = dw * 2 + dh * 3
		if diff < minDiff then
			minDiff = diff
			bestW = sz[1]
			bestH = sz[2]
		end
	end

	return string.format("res/new/buttons/%s_%dx%d.png", kind, bestW, bestH), bestW, bestH
end

function var_0_0.createShaderButton(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	arg_59_0 = arg_59_0 or "img_blank"

	local customFile = getCustomButtonFile(arg_59_0)
	if customFile then
		arg_59_0 = customFile
	end

	local var_59_0 = arg_59_0 == "img_blank"
	local var_59_1 = string.find(arg_59_0, "%.")
	local var_59_2 = ccui.ShaderButton:create(arg_59_0, var_59_1 and ccui.TextureResType.localType or ccui.TextureResType.plistType)

	if var_59_0 then
		var_59_2:setScale9Enabled(true)
		var_59_2:setCapInsets(cc.rect(0, 0, 2, 2))
	end

	if arg_59_2 then
		var_59_2:setPositionX(arg_59_2)
	end

	if arg_59_3 then
		var_59_2:setPositionY(arg_59_3)
	end

	var_59_2:setZoomScale(0.05)

	if not var_59_1 then
		var_59_2:setPressedShader(var_0_0.SHADER_PRESS)
	end

	var_59_2:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

	function var_59_2.setDisplayFrame(arg_60_0, arg_60_1)
		local var_60_0 = arg_60_0:getContentSize()
		local customF = getCustomButtonFile(arg_60_1, var_60_0.width, var_60_0.height)
		if customF then
			arg_60_0:setScale9Enabled(false)
			arg_60_0:loadTextureNormal(customF, ccui.TextureResType.localType)
			arg_60_0:setContentSize(var_60_0)
			return
		end

		arg_60_0:loadTextureNormal(arg_60_1, ccui.TextureResType.plistType)
		arg_60_0:setContentSize(var_60_0)
	end

	function var_59_2.addLabel(arg_61_0, arg_61_1, arg_61_2)
		local var_61_0 = var_0_0.createBMFont(var_0_0.BMFont.huali_26, arg_61_1)

		if arg_61_2 then
			var_61_0:setColor(arg_61_2)
		end

		lc.addChildToPos(arg_61_0, var_61_0, cc.p(lc.w(arg_61_0) / 2, lc.h(arg_61_0) / 2 + 1))

		arg_61_0._label = var_61_0

		if arg_61_0._icon then
			lc.offset(var_61_0, 16)
			arg_61_0._icon:setPositionX(30)
		end

		var_0_0.fitLabel(var_61_0, lc.w(arg_61_0) - (arg_61_0._icon and 56 or 20))
	end

	function var_59_2.addIcon(arg_62_0, arg_62_1)
		local var_62_0 = lc.createSprite(arg_62_1)

		lc.addChildToPos(arg_62_0, var_62_0, cc.p(lc.w(arg_62_0) / 2, lc.h(arg_62_0) / 2 + 1))

		arg_62_0._icon = var_62_0

		if arg_62_0._label then
			lc.offset(arg_62_0._label, 16)
			var_62_0:setPositionX(30)
			var_0_0.fitLabel(arg_62_0._label, lc.w(arg_62_0) - 56)
		end
	end

	function var_59_2.removeIcon(arg_63_0)
		if arg_63_0._icon then
			arg_63_0._icon:removeFromParent()

			arg_63_0._icon = nil

			if arg_63_0._label then
				arg_63_0._label:setPositionX(lc.w(arg_63_0) / 2)
			end
		end
	end

	function var_59_2.supportLongPress(arg_64_0, arg_64_1)
		local function var_64_0(arg_65_0)
			lc.Audio.playAudio(AUDIO.E_BUTTON_DEFAULT)

			if arg_64_0._callback then
				arg_64_0._callback(arg_64_0, arg_65_0)
			end
		end

		if arg_64_1 then
			arg_64_0:addTouchEventListener(function(arg_66_0, arg_66_1)
				if arg_66_1 == ccui.TouchEventType.began then
					local var_66_0 = 0.5

					arg_64_0._longPressTime = 0
					arg_64_0._isLongPressing = nil
					arg_64_0._longPressID = lc.Scheduler:scheduleScriptFunc(function(arg_67_0)
						arg_64_0._longPressTime = arg_64_0._longPressTime + arg_67_0

						if arg_64_0._isLongPressing then
							var_64_0(math.min(10, math.floor(arg_64_0._longPressTime - var_66_0)))
						elseif arg_64_0._longPressTime >= var_66_0 then
							arg_64_0._isLongPressing = true

							var_64_0(0)
						end
					end, 0.1, false)
				elseif arg_66_1 == ccui.TouchEventType.ended or arg_66_1 == ccui.TouchEventType.canceled then
					if arg_64_0._longPressID then
						lc.Scheduler:unscheduleScriptEntry(arg_64_0._longPressID)

						arg_64_0._longPressID = nil
					end

					if arg_66_1 == ccui.TouchEventType.ended and not arg_64_0._isLongPressing then
						var_64_0(0)
					end
				end
			end)
		else
			arg_64_0:addTouchEventListener(function(arg_68_0, arg_68_1)
				if arg_68_1 == ccui.TouchEventType.ended then
					var_64_0()
				end
			end)
		end
	end

	var_59_2._callback = arg_59_1

	var_59_2:supportLongPress(false)

	return var_59_2
end

function var_0_0.createScale9ShaderButton(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	local isSmall = string.find(arg_69_0 or "", "_s") ~= nil
	local w = arg_69_3 or (arg_69_2 and arg_69_2.width) or (isSmall and 120 or 180)
	local h = arg_69_4 or (arg_69_2 and arg_69_2.height) or (isSmall and 60 or 78)

	local customFile, bw, bh = getCustomButtonFile(arg_69_0, w, h)
	if customFile then
		local var_69_0 = var_0_0.createShaderButton(customFile, arg_69_1)
		var_69_0:setScale9Enabled(false)
		var_69_0:setContentSize(w, h)

		local origLoad = var_69_0.loadTextureNormal
		function var_69_0.loadTextureNormal(self, texName, texType)
			local newFile = getCustomButtonFile(texName, w, h)
			if newFile then
				self:setScale9Enabled(false)
				origLoad(self, newFile, ccui.TextureResType.localType)
				return
			end
			origLoad(self, texName, texType)
		end

		return var_69_0
	end

	local var_69_0 = var_0_0.createShaderButton(arg_69_0, arg_69_1)

	var_69_0:setScale9Enabled(true)
	var_69_0:setCapInsets(arg_69_2)
	var_69_0:setContentSize(arg_69_3 or 0, arg_69_4 or (arg_69_2 and arg_69_2.height or 0))

	return var_69_0
end

function var_0_0.createChargeButton(arg_70_0, arg_70_1)
	local var_70_0 = var_0_0.createScale9ShaderButton("img_btn_3_s", function()
		if arg_70_1 then
			arg_70_1:hide()
		end

		lc.pushScene(require("RechargeScene").create())
	end, var_0_0.CRECT_BUTTON_S, arg_70_0)

	var_70_0:addLabel(Str(STR.RECHARGE))
	var_70_0._label:setPositionX(arg_70_0 / 2 + 16)

	local var_70_1 = cc.DragonBonesNode:createWithDecrypt("res/effects/tili.lcres", "tili", "tili")

	var_70_1:gotoAndPlay("effect3")
	lc.addChildToPos(var_70_0, var_70_1, cc.p(26, lc.y(var_70_0._label)))

	return var_70_0
end

function var_0_0.createResConsumeButtonArea(arg_72_0, arg_72_1, arg_72_2, arg_72_3, arg_72_4, arg_72_5)
	local var_72_0 = ccui.Widget:create()

	var_72_0:setAnchorPoint(0.5, 0.5)

	local var_72_1
	local var_72_2
	local var_72_3

	if type(arg_72_0) == "number" then
		var_72_3 = true
		var_72_1 = arg_72_0 - 20
		var_72_2 = arg_72_0
	else
		var_72_3 = false
		var_72_1 = arg_72_0[1]
		var_72_2 = arg_72_0[2]
	end

	local var_72_4 = var_0_0.createResIconLabel(var_72_1, arg_72_1, arg_72_2 or lc.Color3B.black)

	if arg_72_3 then
		var_72_4._label:setString(arg_72_3)
	end

	local var_72_5 = var_0_0.createScale9ShaderButton(arg_72_5 or "img_btn_1", nil, var_0_0.CRECT_BUTTON, var_72_2)

	if arg_72_4 then
		var_72_5:addLabel(arg_72_4)
	end

	if var_72_3 then
		local var_72_6 = lc.h(var_72_4)
		local var_72_7 = var_72_6 + lc.h(var_72_5) + 10

		var_72_0:setContentSize(arg_72_0, var_72_7)
		lc.addChildToPos(var_72_0, var_72_4, cc.p(var_72_2 / 2 + math.floor(lc.w(var_72_4._ico) / 4) - 4, var_72_7 - var_72_6 / 2))
		lc.addChildToPos(var_72_0, var_72_5, cc.p(var_72_2 / 2, lc.h(var_72_5) / 2))
	else
		var_72_0:setContentSize(var_72_1 + var_72_2, lc.h(var_72_5))
		lc.addChildToPos(var_72_0, var_72_4, cc.p(var_72_1 / 2, lc.h(var_72_0) / 2))
		lc.addChildToPos(var_72_0, var_72_5, cc.p(lc.w(var_72_0) - var_72_2 / 2, lc.y(var_72_4)))
	end

	var_72_0._resArea = var_72_4
	var_72_0._resLabel = var_72_4._label
	var_72_0._btn = var_72_5

	return var_72_0
end

function var_0_0.createResConsumeButton(arg_73_0, arg_73_1, arg_73_2, arg_73_3, arg_73_4, arg_73_5)
	local var_73_0 = string.sub(arg_73_5, -2) == "_s"
	local var_73_1 = var_0_0.createScale9ShaderButton(arg_73_5 or "img_btn_1", nil, var_73_0 and var_0_0.CRECT_BUTTON_S or var_0_0.CRECT_BUTTON, arg_73_0)

	var_73_1:addLabel(arg_73_4)

	local var_73_2 = var_0_0.createResIconLabel(arg_73_1, arg_73_2, lc.Color3B.black)

	var_73_2:setCascadeOpacityEnabled(false)
	var_73_2:setOpacity(0)
	if var_73_2._ico then
		var_73_2._ico:setCascadeOpacityEnabled(false)
		var_73_2._ico:setOpacity(255)
		var_73_2._ico:setVisible(true)
	end
	if var_73_2._label then
		var_73_2._label:setCascadeOpacityEnabled(false)
		var_73_2._label:setOpacity(255)
		var_73_2._label:setVisible(true)
	end
	var_73_2:setVisible(true)

	var_73_2._label:setString(arg_73_3)
	lc.offset(var_73_1._label, -arg_73_1 / 2, 0)
	lc.addChildToPos(var_73_1, var_73_2, cc.p(arg_73_0 - lc.w(var_73_2) / 2, lc.y(var_73_1._label)))

	var_73_1._resArea = var_73_2
	var_73_1._resLabel = var_73_2._label

	return var_73_1
end

function var_0_0.createKeyValueLabel(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4)
	local var_74_0 = cc.Label:createWithTTF(arg_74_0 .. ": ", var_0_0.TTF_FONT, arg_74_2)

	var_74_0:setColor(arg_74_3 and var_0_0.COLOR_LABEL_LIGHT or var_0_0.COLOR_LABEL_LIGHT)
	var_74_0:setAnchorPoint(0, 0.5)

	if arg_74_1 then
		local var_74_1 = cc.Label:createWithTTF(arg_74_1, var_0_0.TTF_FONT, arg_74_2)

		var_74_1:setColor(arg_74_3 and var_0_0.COLOR_TEXT_LIGHT or var_0_0.COLOR_TEXT_LIGHT)
		var_74_1:setAnchorPoint(0, 0.5)

		var_74_0._value = var_74_1
		var_74_1._key = var_74_0
	end

	if arg_74_4 then
		var_74_0._icon = cc.Sprite:createWithSpriteFrameName(arg_74_4)
	end

	function var_74_0.addToParent(arg_75_0, arg_75_1, arg_75_2, arg_75_3, arg_75_4)
		arg_75_1:addChild(arg_75_0)

		if arg_75_0._icon then
			arg_75_1:addChild(arg_75_0._icon)
		end

		if arg_75_0._value then
			arg_75_1:addChild(arg_75_0._value)
		end

		arg_75_0:setPosition(arg_75_2.x, arg_75_2.y)
	end

	local var_74_2 = var_74_0.setPosition

	function var_74_0.setPosition(arg_76_0, arg_76_1, arg_76_2)
		if type(arg_76_1) == "table" then
			arg_76_2 = arg_76_1.y
			arg_76_1 = arg_76_1.x
		end

		var_74_2(arg_76_0, arg_76_1, arg_76_2)

		if arg_76_0._icon then
			arg_76_0._icon:setPosition(lc.right(arg_76_0) + lc.w(arg_76_0._icon) / 2 + 2, arg_76_2)

			if arg_76_0._value then
				arg_76_0._value:setPosition(lc.right(arg_76_0._icon) + 8, arg_76_2)
			end
		elseif arg_76_0._value then
			arg_76_0._value:setPosition(lc.right(arg_76_0), arg_76_2)
		end
	end

	local var_74_3 = var_74_0.removeFromParent

	function var_74_0.removeFromParent(arg_77_0, arg_77_1)
		if arg_77_0._value then
			arg_77_0._value:removeFromParent()
		end

		if arg_77_0._icon then
			arg_77_0._icon:removeFromParent()
		end

		var_74_3(arg_77_0, arg_77_1)
	end

	function var_74_0.getTotalWidth(arg_78_0)
		return lc.w(arg_78_0) + (arg_74_4 and lc.w(arg_78_0._icon) + 10 or 0) + (arg_78_0._value and lc.w(arg_78_0._value) or 0)
	end

	function var_74_0.getTotalHeight(arg_79_0)
		return lc.h(var_74_0._icon)
	end

	return var_74_0, var_74_0._value, var_74_0._icon
end

function var_0_0.createLevelArea(arg_80_0)
	local var_80_0 = lc.createSprite("avatar_level_bg")

	var_80_0:setCascadeOpacityEnabled(true)

	local var_80_1 = cc.Label:createWithTTF(string.format("%d", arg_80_0), var_0_0.TTF_FONT, var_0_0.FontSize.S3)

	var_80_1:setPosition(lc.w(var_80_0) / 2, lc.h(var_80_0) / 2 + 2)
	var_80_0:addChild(var_80_1)

	var_80_0._level = var_80_1

	return var_80_0
end

function var_0_0.createLevelExpBar(arg_81_0, arg_81_1, arg_81_2, arg_81_3)
	local var_81_0 = var_0_0.createLabelProgressBar(arg_81_3 or 200)

	if arg_81_2 and arg_81_2 > 0 then
		var_81_0._bar:setPercent(arg_81_1 * 100 / arg_81_2)
	end

	var_81_0:setLabel(arg_81_1, arg_81_2)

	local var_81_1 = var_0_0.createLevelAreaNew(arg_81_0)

	lc.addChildToPos(var_81_0, var_81_1, cc.p(8, lc.h(var_81_0) / 2))

	var_81_0._level = var_81_1._level

	return var_81_0
end

function var_0_0.createLevelAreaNew(arg_82_0)
	local var_82_0 = lc.createSprite("avatar_level_bg")

	var_82_0:setCascadeOpacityEnabled(true)

	local var_82_1 = cc.Label:createWithTTF(string.format("%d", arg_82_0), var_0_0.TTF_FONT, var_0_0.FontSize.S1)

	var_82_1:setColor(var_0_0.COLOR_TEXT_LIGHT)
	var_82_1:setPosition(lc.w(var_82_0) / 2, lc.h(var_82_0) / 2)
	var_82_0:addChild(var_82_1)

	var_82_0._level = var_82_1

	function var_82_0.setString(arg_83_0, arg_83_1)
		arg_83_0._level:setString(arg_83_1)
	end

	return var_82_0
end

function var_0_0.createLevelNameArea(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = arg_84_2 or false
	local var_84_1 = lc.createSprite("avatar_name_bg")

	var_84_1:setFlippedX(var_84_0)

	local var_84_2 = lc.w(var_84_1)
	local var_84_3 = lc.h(var_84_1)
	local var_84_4 = lc.createNode(cc.size(var_84_2, var_84_3), nil, cc.p(var_84_0 and 1 or 0, 0.5))

	lc.addChildToCenter(var_84_4, var_84_1)

	var_84_4._bg = var_84_1

	local var_84_5 = cc.Label:createWithTTF(arg_84_1, var_0_0.TTF_FONT, var_0_0.FontSize.M1)

	var_84_5:setScale(0.8)
	var_84_5:setAnchorPoint(var_84_0 and 1 or 0, 0.5)
	lc.addChildToPos(var_84_4, var_84_5, cc.p(var_84_0 and var_84_2 - 20 or 20, var_84_3 - 32))

	var_84_4._name = var_84_5

	local var_84_6 = var_0_0.createLevelAreaNew(arg_84_0)

	lc.addChildToPos(var_84_4, var_84_6, cc.p(var_84_0 and 44 or var_84_2 - 44, lc.y(var_84_5)))

	var_84_4._level = var_84_6

	function var_84_4.setName(arg_85_0, arg_85_1)
		arg_85_0._name:setString(arg_85_1)
		arg_85_0._name:setScale(math.min(172 / lc.w(arg_85_0._name), 0.8))
	end

	return var_84_4
end

function var_0_0.createEditBox(arg_86_0, arg_86_1, arg_86_2, arg_86_3, arg_86_4, arg_86_5)
	local var_86_0 = ccui.EditBox:create(arg_86_2, ccui.Scale9Sprite:createWithSpriteFrameName(arg_86_0, arg_86_1))

	if arg_86_4 then
		var_86_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
		var_86_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	else
		var_86_0:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
		var_86_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DEFAULT)
	end

	var_86_0:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
	var_86_0:setFont(var_0_0.TTF_FONT, var_0_0.FontSize.S1)
	var_86_0:setFontColor(lc.Color4B.white)

	if arg_86_5 then
		var_86_0:setMaxLength(arg_86_5)
	end

	if arg_86_3 then
		var_86_0:setPlaceHolder(arg_86_3)
		var_86_0:setPlaceholderFont(var_0_0.TTF_FONT, var_0_0.FontSize.S2)
		var_86_0:setPlaceholderFontColor(lc.Color3B.gray)
	end

	function var_86_0.isValidName(arg_87_0, arg_87_1)
		arg_87_1 = arg_87_1 or ClientData.MAX_NAME_DISPLAY_LEN

		local var_87_0 = string.trim(arg_87_0:getText())

		if var_87_0 == "" then
			return false
		end

		local var_87_1 = var_0_0.createTTF(var_87_0, var_0_0.FontSize.S1)

		return arg_87_1 >= lc.w(var_87_1)
	end

	return var_86_0
end

function var_0_0.createSword(arg_88_0)
	local var_88_0 = cc.Node:create()

	var_88_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_88_0:setCascadeOpacityEnabled(true)

	local var_88_1 = "img_sword"

	if arg_88_0 ~= nil and arg_88_0 > 0 then
		var_88_1 = var_88_1 .. arg_88_0
	end

	local var_88_2 = cc.Sprite:createWithSpriteFrameName(var_88_1)
	local var_88_3 = cc.Sprite:createWithSpriteFrameName(var_88_1)
	local var_88_4 = 200
	local var_88_5 = lc.h(var_88_2)

	var_88_0:setContentSize(cc.size(var_88_4, var_88_5))
	var_88_2:setFlippedX(true)
	var_88_2:setAnchorPoint(0.5, 0)
	var_88_3:setAnchorPoint(0.5, 0)
	var_88_2:setPosition(0, 0)
	var_88_3:setPosition(var_88_4, 0)
	var_88_0:addChild(var_88_2, 1)
	var_88_0:addChild(var_88_3, 1)

	var_88_0._sprite1 = var_88_2
	var_88_0._sprite2 = var_88_3

	local function var_88_6(arg_89_0, arg_89_1, arg_89_2, arg_89_3, arg_89_4)
		local var_89_0 = cc.Spawn:create(cc.MoveTo:create(0.3, arg_89_1), cc.RotateTo:create(0.3, arg_89_3))
		local var_89_1 = cc.Spawn:create(cc.MoveTo:create(0.3, arg_89_0), cc.RotateTo:create(0.3, arg_89_2))
		local var_89_2 = cc.CallFunc:create(function()
			if var_88_0:getOpacity() == 255 then
				local var_90_0 = Particle.create("par_city_chapter")

				var_90_0:setPosition(var_88_4 / 2, var_88_5 / 2)
				var_88_0:addChild(var_90_0)
			end
		end)

		if arg_89_4 then
			return cc.Sequence:create(var_89_0, var_89_2, cc.DelayTime:create(0.1), var_89_1)
		else
			return cc.Sequence:create(var_89_0, cc.DelayTime:create(0.1), var_89_1)
		end
	end

	var_88_2:runAction(cc.RepeatForever:create(var_88_6(cc.p(lc.x(var_88_2), lc.y(var_88_2)), cc.p(lc.x(var_88_2) + 50, lc.y(var_88_2)), var_88_2:getRotation(), var_88_2:getRotation() + 45, true)))
	var_88_3:runAction(cc.RepeatForever:create(var_88_6(cc.p(lc.x(var_88_3), lc.y(var_88_3)), cc.p(lc.x(var_88_3) - 50, lc.y(var_88_3)), var_88_3:getRotation(), var_88_3:getRotation() - 45, false)))

	return var_88_0
end

-- The bitmap fonts carry ASCII and Chinese and nothing in between: not one
-- accented Latin letter. cocos draws nothing at all for a character its font
-- has no glyph for, so a Vietnamese string set in one of them comes out with
-- every marked letter missing - "Kết thúc" reads "Kt thc". These are the
-- pixel sizes each was cut at, so the outline font can stand in at the size
-- the layout was built around.
var_0_0.BMFontSize = {
	["res/fonts/huali_26.fnt"] = 26,
	["res/fonts/huali_32.fnt"] = 32,
	["res/fonts/num_48.fnt"] = 48,
	["res/fonts/number_43.fnt"] = 43,
	["res/fonts/yxw_number_csrd_24.fnt"] = 24
}

--- Does this text hold a letter the bitmap fonts cannot draw?
-- Everything Vietnamese adds to ASCII sits either in the two-byte range -
-- Latin-1 and the breve, horn and D-bar letters - or in Latin Extended
-- Additional, U+1E00 to U+1EFF. Chinese is three-byte and far above that, so
-- it still goes to the bitmap font it was cut for.
function var_0_0.needsOutlineFont(arg_90_9)
	local var_90_9 = tostring(arg_90_9)
	local iter_90_9 = 1

	while iter_90_9 <= #var_90_9 do
		local byte_90_9 = var_90_9:byte(iter_90_9)

		if byte_90_9 < 128 then
			iter_90_9 = iter_90_9 + 1
		elseif byte_90_9 < 224 then
			return true
		elseif byte_90_9 < 240 then
			local code_90_9 = (byte_90_9 - 224) * 4096 + ((var_90_9:byte(iter_90_9 + 1) or 128) - 128) * 64 + ((var_90_9:byte(iter_90_9 + 2) or 128) - 128)

			if code_90_9 >= 7680 and code_90_9 <= 7935 then
				return true
			end

			iter_90_9 = iter_90_9 + 3
		else
			iter_90_9 = iter_90_9 + 4
		end
	end

	return false
end

--- Keep a caption inside the width it was drawn for.
-- Vietnamese runs half again as long as the Chinese it replaces - "结束" is
-- "Kết thúc lượt" - so a caption that fitted its button in the original spills
-- off the artwork here. Shrinking is the honest answer: the words all stay,
-- on one line, in the box someone drew for them. Clipping would lose words
-- and wrapping would push them out of a height the artwork fixes.
function var_0_0.fitLabel(arg_90_8, arg_90_7, arg_90_6)
	if arg_90_8 == nil or arg_90_7 == nil or arg_90_7 <= 0 then
		return arg_90_8
	end

	local var_90_5 = arg_90_8:getScaleX()
	local var_90_8 = lc.w(arg_90_8) * var_90_5

	if var_90_8 > arg_90_7 then
		-- the floor is relative: a caption already set at 0.6 is not shrunk to
		-- 0.6 of the em, it is shrunk to 0.6 of the size it was drawn at
		arg_90_8:setScale(math.max((arg_90_6 or 0.35) * var_90_5,
			var_90_5 * arg_90_7 / var_90_8))
	end

	return arg_90_8
end

--- Turn a bitmap-font label into an outline-font one, in place.
-- Wrapped in pcall because it is the one thing here that depends on a binding
-- this build may not expose; if it is missing the label simply stays as it
-- was, which is no worse than before.
function var_0_0.useOutlineFont(arg_90_4, arg_90_3)
	return pcall(function()
		arg_90_4:setSystemFontName(var_0_0.TTF_FONT)
		arg_90_4:setSystemFontSize(arg_90_3 or var_0_0.FontSize.S2)
	end)
end

function var_0_0.createBMFont(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
	local var_91_0
	local var_91_1 = var_0_0.BMFontSize[arg_91_0] or var_0_0.FontSize.S2

	if var_0_0.needsOutlineFont(arg_91_1) then
		if arg_91_2 and arg_91_3 then
			var_91_0 = cc.Label:createWithTTF(tostring(arg_91_1), var_0_0.TTF_FONT, var_91_1, cc.size(arg_91_3, 0), arg_91_2)
		else
			var_91_0 = cc.Label:createWithTTF(tostring(arg_91_1), var_0_0.TTF_FONT, var_91_1)
		end
	else
		if arg_91_2 and arg_91_3 then
			var_91_0 = cc.Label:createWithBMFont(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
		else
			var_91_0 = cc.Label:createWithBMFont(arg_91_0, arg_91_1)
		end

		-- Most of these labels are built empty - createBMFont(font, "") - and
		-- given their words later, so deciding the font only from the text
		-- handed in at creation misses nearly every caption in the game and
		-- leaves it drawn in a bitmap font that has no accented letters at
		-- all. Watch what arrives instead: "Hãy" comes out "Hy" otherwise.
		local var_91_2 = var_91_0.setString

		function var_91_0.setString(arg_90_2, arg_90_1)
			if not arg_90_2._vnOutlineFont and var_0_0.needsOutlineFont(arg_90_1) then
				arg_90_2._vnOutlineFont = var_0_0.useOutlineFont(arg_90_2, var_91_1)
			end

			return var_91_2(arg_90_2, arg_90_1)
		end
	end

	var_91_0:setColor(var_0_0.COLOR_BMFONT)

	return var_91_0
end

function var_0_0.createTTF(arg_92_0, arg_92_1, arg_92_2, ...)
	local var_92_0 = cc.Label:createWithTTF(arg_92_0, var_0_0.TTF_FONT, arg_92_1 or var_0_0.FontSize.S2, ...)

	var_92_0:setColor(arg_92_2 or var_0_0.COLOR_TEXT_LIGHT)

	return var_92_0
end

function var_0_0.createVerticalTitle(arg_93_0, arg_93_1)
	local var_93_0 = arg_93_0:len() / 3
	local var_93_1 = 28
	local var_93_2 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = var_0_0.CRECT_COM_BG2,
		_size = cc.size(var_93_0 * var_93_1 + 20, 40)
	})

	var_93_2:setRotation(90)
	var_93_2:setColor(arg_93_1 or lc.Color3B.black)
	var_93_2:setOpacity(180)

	local var_93_3 = lc.createNode(cc.size(lc.h(var_93_2), lc.w(var_93_2)))

	lc.addChildToCenter(var_93_3, var_93_2)

	local var_93_4 = var_0_0.createBMFont(var_0_0.BMFont.huali_26, arg_93_0, cc.TEXT_ALIGNMENT_CENTER, var_93_1)

	var_93_4:setLineHeight(var_93_1)
	lc.addChildToCenter(var_93_3, var_93_4)

	var_93_3._title = var_93_4

	return var_93_3
end

function var_0_0.addFixityName(arg_94_0, arg_94_1, arg_94_2, arg_94_3, arg_94_4)
	arg_94_1 = arg_94_1:gsub("%s", "")

	local var_94_0 = arg_94_1:len() / 3
	local var_94_1 = var_94_0 > 3 and 32 or 38
	local var_94_2 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_2", var_0_0.CRECT_COM_BG2)

	var_94_2:setContentSize(var_94_0 * var_94_1 + 50, 48)
	var_94_2:setRotation(90)
	var_94_2:setColor(arg_94_3 or lc.Color3B.black)
	var_94_2:setOpacity(120)
	lc.addChildToPos(arg_94_0, var_94_2, arg_94_4 and arg_94_4 or cc.p(0, lc.h(arg_94_0) / 2), 1)

	local var_94_3 = var_0_0.createBMFont(var_0_0.BMFont.huali_32, arg_94_1, cc.TEXT_ALIGNMENT_CENTER, 30)

	var_94_3:setColor(arg_94_2 and arg_94_2 or var_0_0.COLOR_BMFONT)
	var_94_3:setLineHeight(var_94_1)
	lc.addChildToPos(arg_94_0, var_94_3, cc.p(lc.x(var_94_2), lc.y(var_94_2) + 6), 1)

	var_94_3._bg = var_94_2
	arg_94_0._name = var_94_3

	return var_94_3
end

function var_0_0.createFrameBox(arg_95_0)
	local var_95_0 = ClientData.isAppStoreReviewing() and lc.FrameCache:getSpriteFrame("img_com_bg_21_r") ~= nil and "img_com_bg_21_r" or "img_com_bg_21"
	local var_95_1 = ClientData.isAppStoreReviewing() and lc.FrameCache:getSpriteFrame("img_com_bg_23_r") ~= nil and "img_com_bg_23_r" or "img_com_bg_23"
	local var_95_2 = lc.createSprite({
		_name = var_95_0,
		_crect = ClientView.CRECT_COM_BG21,
		_size = arg_95_0
	})
	local var_95_3 = lc.createSprite({
		_name = var_95_1,
		_crect = ClientView.CRECT_COM_BG23,
		_size = cc.size(lc.w(var_95_2) - 40, lc.h(var_95_2) - 40)
	})

	lc.addChildToCenter(var_95_2, var_95_3, -2)

	var_95_2._bg = var_95_3

	return var_95_2
end

function var_0_0.createTitleArea(arg_96_0, arg_96_1, arg_96_2, arg_96_3)
	local var_96_0 = ccui.Widget:create()

	var_96_0:setContentSize(ClientView.SCR_W, var_0_0.CRECT_TITLE_AREA_BG.height)
	var_96_0:setPosition(ClientView.SCR_CW, ClientView.SCR_H - lc.h(var_96_0) / 2)
	var_96_0:setTouchEnabled(true)

	local var_96_1 = lc.createSprite({
		_name = "img_ui_scene_title_bg",
		_crect = var_0_0.CRECT_TITLE_AREA_BG,
		_size = var_96_0:getContentSize()
	})

	lc.addChildToCenter(var_96_0, var_96_1)

	local var_96_2 = lc.createSprite("img_ui_scene_name_bg")

	var_96_2:setScale(8, 1)
	lc.addChildToPos(var_96_0, var_96_2, cc.p(276, lc.h(var_96_0) / 2))

	local var_96_3 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_96_0)

	lc.addChildToPos(var_96_0, var_96_3, cc.p(var_96_2:getPosition()))
	lc.offset(var_96_3, -10, 0)

	var_96_0._title = var_96_3

	local var_96_4 = ClientView.createShaderButton(ClientData.isAppStoreReviewing() and ClientData.getAppStoreReviewingType() == 3 and "city_3_btn_rule" or "img_btn_rule", arg_96_2)

	lc.addChildToPos(var_96_0, var_96_4, cc.p(lc.right(var_96_3) + lc.ch(var_96_4) + 10, lc.ch(var_96_0) - 2))
	var_96_4:setTouchRect(cc.rect(-16, -16, lc.w(var_96_4) + 32, lc.h(var_96_4) + 32))

	var_96_0._btnHelp = var_96_4

	var_96_4:setVisible(arg_96_3 == true)

	local var_96_5 = lc.createSprite(ClientData.isAppStoreReviewing() and ClientData.getAppStoreReviewingType() == 3 and "city_3_btn_back_bg" or "img_ui_scene_back_bg")

	var_96_5:setAnchorPoint(0, 0)
	lc.addChildToPos(var_96_0, var_96_5, cc.p(0, 0))

	local var_96_6 = ClientView.createShaderButton(ClientData.isAppStoreReviewing() and ClientData.getAppStoreReviewingType() == 3 and "city_3_btn_back" or "img_ui_scene_back", arg_96_1)

	var_96_6:setPosition(80, lc.h(var_96_0) / 2 + 2)

	var_96_6._touchRect = cc.rect(-40, -20, lc.w(var_96_6) + 80, lc.h(var_96_6) + 40)

	var_96_6:setTouchRect(var_96_6._touchRect)
	var_96_6:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_96_0:addChild(var_96_6)

	var_96_0._btnBack = var_96_6

	return var_96_0
end

function var_0_0.createIconLabelArea(arg_97_0, arg_97_1, arg_97_2, arg_97_3, arg_97_4)
	local var_97_0 = lc.frameSize("img_com_bg_1").height
	local var_97_1 = cc.size(arg_97_2, var_97_0)
	local var_97_2 = var_0_0.CRECT_COM_BG1

	var_97_2.y = 0
	var_97_2.height = var_97_0

	local var_97_3

	if arg_97_3 then
		var_97_3 = var_0_0.createShaderButton(nil, arg_97_3)
	else
		var_97_3 = ccui.Widget:create()
	end

	var_97_3:setContentSize(var_97_1)

	local var_97_4 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_1", var_97_2)

	var_97_4:setContentSize(var_97_1)
	var_97_4:setPosition(var_97_1.width / 2, var_97_1.height / 2)
	var_97_3:addChild(var_97_4)

	var_97_3._valBg = var_97_4

	local var_97_5 = lc.createSprite(arg_97_0)

	var_97_5:setPosition(lc.w(var_97_5) / 2 + 4, lc.h(var_97_3) / 2 + 2)
	var_97_3:addChild(var_97_5)

	var_97_3._icon = var_97_5

	local var_97_6

	if arg_97_4 then
		var_97_6 = lc.createSprite(arg_97_4)

		var_97_6:setPosition(lc.w(var_97_3) - 26 - lc.w(var_97_6) / 2, lc.h(var_97_3) / 2)
		var_97_6:setColor(cc.c3b(255, 230, 30))
		var_97_3:addChild(var_97_6)

		var_97_3._btnAdd = var_97_6
	end

	arg_97_1 = arg_97_1 or "0"

	local var_97_7 = var_0_0.createBMFont(var_0_0.BMFont.huali_26, arg_97_1)

	var_97_7:setPosition(math.floor(((var_97_6 and lc.left(var_97_6) or var_97_1.width - 5) - lc.right(var_97_5)) / 2) + lc.right(var_97_5), var_97_1.height / 2 + 1)
	var_97_3:addChild(var_97_7)

	var_97_3._label = var_97_7

	return var_97_3
end

function var_0_0.createItemCountArea(arg_98_0, arg_98_1, arg_98_2, arg_98_3)
	arg_98_3 = arg_98_3 or P:getItemCount(arg_98_0) or 0

	local var_98_0 = var_0_0.createIconLabelArea(arg_98_1, tostring(arg_98_3), arg_98_2, function()
		require("DescForm").create({
			_showOwnCount = true,
			_infoId = arg_98_0
		}):show()
	end)

	var_98_0._infoId = arg_98_0

	return var_98_0
end

function var_0_0.createResIconLabel(arg_100_0, arg_100_1, arg_100_2)
	local var_100_0 = var_0_0.CRECT_COM_BG2.height
	local var_100_1 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_2", var_0_0.CRECT_COM_BG2)

	var_100_1:setContentSize(arg_100_0, var_100_0)
	var_100_1:setOpacity(120)
	var_100_1:setColor(arg_100_2 or lc.Color3B.black)

	if arg_100_1 then
		local var_100_2 = cc.Sprite:createWithSpriteFrameName(arg_100_1)

		var_100_2:setPosition(0, var_100_0 / 2)
		var_100_1:addChild(var_100_2)

		var_100_1._ico = var_100_2
	end

	local var_100_3 = var_0_0.createBMFont(var_0_0.BMFont.huali_26, "")

	var_100_3:setPosition(arg_100_0 / 2, var_100_0 / 2)
	var_100_1:addChild(var_100_3)

	var_100_1._label = var_100_3

	return var_100_1
end

function var_0_0.createLabelButton(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = var_0_0.createShaderButton(arg_101_0, arg_101_2)

	var_101_0:setTouchRect(cc.rect(-10, -10, lc.w(var_101_0) + 20, lc.h(var_101_0) + 20))

	local var_101_1 = var_0_0.createBMFont(var_0_0.BMFont.huali_26, arg_101_1.str)

	lc.addChildToPos(var_101_0, var_101_1, cc.p(lc.w(var_101_0) / 2, arg_101_1.offY and arg_101_1.offY or 0))

	if arg_101_1.clr then
		var_101_1:setColor(arg_101_1.clr)
	end

	if arg_101_3 then
		var_101_0:setPosition(arg_101_3)
	end

	-- The city's top row spaces its icons one icon width plus four apart, so
	-- a caption is allowed the whole of its own slot less a small gutter. The
	-- fixed 96 that used to stand here was wider than the 87 the icons
	-- actually sit apart, which is why every Vietnamese caption ran into its
	-- neighbour.
	-- 0.45 rather than 0.55 as the floor: "Đại sảnh danh vọng" is the longest
	-- caption in the row and at 0.55 it still overran its slot into the next
	-- icon's caption. Anything that already fits is left alone.
	var_0_0.fitLabel(var_101_1, lc.w(var_101_0) - 2, 0.45)

	var_101_0.label = arg_101_1
	var_101_0._labelStr = var_101_1

	return var_101_0
end

function var_0_0.createPaperBg(arg_102_0, arg_102_1)
	local var_102_0 = lc.createImageView({
		_name = "img_com_bg_21",
		_crect = var_0_0.CRECT_COM_BG22
	})
	local var_102_1 = var_102_0.setContentSize

	function var_102_0.setContentSize(arg_103_0, arg_103_1, arg_103_2)
		if type(arg_103_1) == "table" then
			arg_103_2 = arg_103_1.height
			arg_103_1 = arg_103_1.width
		end

		var_102_1(arg_103_0, arg_103_1, arg_103_2)
	end

	var_102_0:setContentSize(arg_102_0)

	return var_102_0
end

function var_0_0.createShadowColorBg(arg_104_0, arg_104_1)
	local var_104_0 = cc.LayerColor:create(arg_104_1 or var_0_0.COLOR_SHADOW_BG_BLUE, arg_104_0.width, arg_104_0.height)

	var_104_0:ignoreAnchorPointForPosition(false)

	local var_104_1 = lc.createSprite({
		_name = "img_com_bg_14",
		_crect = var_0_0.CRECT_COM_BG14,
		_size = arg_104_0
	})

	lc.addChildToCenter(var_104_0, var_104_1, 1)

	local var_104_2 = var_104_0.setContentSize

	function var_104_0.setContentSize(arg_105_0, arg_105_1, arg_105_2)
		var_104_2(arg_105_0, arg_105_1, arg_105_2)
		var_104_1:setContentSize(arg_105_1, arg_105_2)
		var_104_1:setPosition(arg_105_1 / 2, arg_105_2 / 2)
	end

	var_104_0._shadow = var_104_1

	return var_104_0
end

function var_0_0.createFramedShadowColorBg(arg_106_0, arg_106_1)
	local var_106_0 = lc.createSprite({
		_name = "img_com_bg_30",
		_crect = var_0_0.CRECT_COM_BG30
	})
	local var_106_1 = var_106_0.setContentSize

	function var_106_0.setContentSize(arg_107_0, arg_107_1, arg_107_2)
		var_106_1(arg_107_0, arg_107_1, arg_107_2)
	end

	var_106_0:setContentSize(arg_106_0.width, arg_106_0.height)

	return var_106_0
end

function var_0_0.createRedFlagBg(arg_108_0)
	local var_108_0 = lc.createNode()
	local var_108_1 = lc.createSprite({
		_name = "img_com_bg_18",
		_crect = var_0_0.CRECT_COM_BG18
	})
	local var_108_2 = lc.w(var_108_1)

	var_108_1:setFlippedX(true)
	var_108_0:addChild(var_108_1)

	local var_108_3 = lc.createSprite({
		_name = "img_com_bg_18",
		_crect = var_0_0.CRECT_COM_BG18
	})

	var_108_0:addChild(var_108_3)

	local var_108_4 = var_108_0.setContentSize

	function var_108_0.setContentSize(arg_109_0, arg_109_1, arg_109_2)
		var_108_4(arg_109_0, arg_109_1, arg_109_2)
		var_108_3:setContentSize(arg_109_1 - var_108_2, arg_109_2)
		var_108_3:setPosition(lc.w(var_108_3) / 2, arg_109_2 / 2)
		var_108_1:setContentSize(var_108_2, arg_109_2)
		var_108_1:setPosition(arg_109_1 - var_108_2 / 2, arg_109_2 / 2)
	end

	var_108_0:setContentSize(arg_108_0.width, arg_108_0.height)

	return var_108_0
end

function var_0_0.createMaterialArea(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = ccui.Layout:create()

	var_110_0:setAnchorPoint(0.5, 0.5)
	var_110_0:setContentSize(ClientView.SCR_W, 200)

	local var_110_1 = {}

	var_110_0._slots = var_110_1

	local var_110_2 = 170
	local var_110_3 = 100
	local var_110_4 = 14
	local var_110_5 = math.max(1, #arg_110_0)
	local var_110_6 = (lc.w(var_110_0) - var_110_5 * var_110_3 - (var_110_5 - 1) * var_110_4) / 2 + var_110_3 / 2
	local var_110_7 = 196
	local var_110_8

	for iter_110_0 = 1, var_110_5 do
		local var_110_9 = lc.createSprite("img_slot")

		lc.addChildToPos(var_110_0, var_110_9, cc.p(var_110_6, var_110_7))

		var_110_1[#var_110_1 + 1] = var_110_9
		var_110_6 = var_110_6 + var_110_3 + var_110_4

		local var_110_10 = lc.createSprite("img_com_bg_19")

		var_110_10:setScaleX(0.6)
		lc.addChildToPos(var_110_9, var_110_10, cc.p(lc.w(var_110_9) / 2, -lc.h(var_110_10) / 2 + 12), -1)

		var_110_9._bg = var_110_10
	end

	for iter_110_1 = 1, #arg_110_0 do
		local var_110_11 = var_110_1[iter_110_1]
		local var_110_12 = arg_110_0[iter_110_1]

		if var_110_12._need > 0 then
			local var_110_13 = var_0_0.createBMFont(var_0_0.BMFont.huali_20, string.format("%d", var_110_12._need))

			var_110_13:setScale(0.8 / var_110_11._bg:getScaleX(), 0.8)
			lc.addChildToCenter(var_110_11._bg, var_110_13)

			if arg_110_2 and var_110_12._icon._data._count < var_110_12._need then
				var_110_13:setColor(lc.Color3B.red)
			end

			lc.addChildToCenter(var_110_11, var_110_12._icon)
		end
	end

	return var_110_0
end

function var_0_0.createHorizontalContentTab(arg_111_0, arg_111_1, arg_111_2, arg_111_3)
	local var_111_0 = arg_111_3 and lc.createNode(arg_111_0) or ClientView.createFrameBox(arg_111_0)

	if #arg_111_1 > 0 then
		local var_111_1 = arg_111_1[1]._left or 80
		local var_111_2 = arg_111_1[1]._gap or 10

		var_111_0._tabs = {}

		for iter_111_0 = 1, #arg_111_1 do
			local var_111_3 = arg_111_1[iter_111_0]
			local var_111_4 = var_111_3._width or 140
			local var_111_5 = var_0_0.createScale9ShaderButton(iter_111_0 == 1 and "img_btn_tab_bg_unfocus_2" or "img_btn_tab_bg_unfocus_2", function(arg_112_0)
				var_111_0:showTab(iter_111_0, false, true)
			end, cc.rect(40, 0, 40, 80), var_111_4)

			lc.addChildToPos(var_111_0, var_111_5, cc.p(var_111_1 + lc.w(var_111_5) / 2, lc.h(var_111_0) - ClientView.FRAME_INNER_TOP + lc.h(var_111_5) / 2))

			var_111_5._label = var_0_0.createBMFont(var_0_0.BMFont.huali_26, var_111_3._labelStr)

			lc.addChildToPos(var_111_5, var_111_5._label, cc.p(lc.w(var_111_5) / 2 - 2, lc.h(var_111_5) / 2))

			var_111_5._handler = var_111_3._handler
			var_111_5._checkHandler = var_111_3._checkHandler

			var_111_5:setZoomScale(0)
			table.insert(var_111_0._tabs, var_111_5)

			var_111_1 = var_111_1 + lc.w(var_111_5) + var_111_2
		end

		function var_111_0.showTab(arg_113_0, arg_113_1, arg_113_2, arg_113_3)
			if arg_113_0._focusTabIndex == arg_113_1 and not arg_113_2 then
				return
			end

			local var_113_0 = math.min(arg_113_1, #arg_113_0._tabs)
			local var_113_1 = arg_113_0._tabs[var_113_0]

			if var_113_1._checkHandler and not var_113_1._checkHandler(var_113_0, arg_113_3) then
				return
			end

			if arg_113_0._focusTabIndex ~= nil then
				local var_113_2 = arg_113_0._tabs[arg_113_0._focusTabIndex]

				var_113_2:loadTextureNormal("img_btn_tab_bg_unfocus_2", ccui.TextureResType.plistType)

				local var_113_3 = arg_111_1[arg_113_0._focusTabIndex]._width or 140

				var_113_2:setContentSize(var_113_3, 80)
				var_113_2:setEnabled(true)
			end

			arg_113_0._focusTabIndex = var_113_0

			var_113_1:loadTextureNormal("img_btn_tab_bg_focus_2", ccui.TextureResType.plistType)

			local var_113_4 = arg_111_1[arg_113_0._focusTabIndex]._width or 140

			var_113_1:setContentSize(var_113_4, 80)
			var_113_1:setEnabled(false)

			if var_113_1._handler then
				var_113_1._handler(var_113_0)
			end
		end
	end

	var_111_0._content = lc.createNode(var_111_0:getContentSize())

	lc.addChildToCenter(var_111_0, var_111_0._content)

	return var_111_0
end

function var_0_0.createCardListBg(arg_114_0)
	local var_114_0 = lc.createNode(arg_114_0)
	local var_114_1 = ccui.Scale9Sprite:createWithSpriteFrameName("img_divide_line_4", cc.rect(1, 0, 1, 24))

	var_114_1:setContentSize(arg_114_0.width, 24)
	lc.addChildToPos(var_114_0, var_114_1, cc.p(lc.w(var_114_0) / 2, lc.h(var_114_0) - lc.h(var_114_1) / 2))

	local var_114_2 = ccui.Scale9Sprite:createWithSpriteFrameName("img_divide_line_4", cc.rect(1, 0, 1, 24))

	var_114_2:setContentSize(arg_114_0.width, 24)
	lc.addChildToPos(var_114_0, var_114_2, cc.p(lc.w(var_114_0) / 2, lc.h(var_114_2) / 2))

	return var_114_0
end

function var_0_0.createProgressBar(arg_115_0, arg_115_1)
	local var_115_0 = var_0_0.CRECT_PROGRESS_BG.height
	local var_115_1 = lc.createSprite({
		_name = "img_progress_bg",
		_crect = var_0_0.CRECT_PROGRESS_BG,
		_size = cc.size(arg_115_0, var_115_0)
	})
	local var_115_2 = ccui.LoadingBar:create()

	var_115_2:loadTexture("img_progress_fg", ccui.TextureResType.plistType)
	var_115_2:setDirection(ccui.LoadingBarDirection.LEFT)
	var_115_2:setPosition(arg_115_0 / 2, var_115_0 / 2)
	var_115_2:setScale9Enabled(true)
	var_115_2:setCapInsets(var_0_0.CRECT_PROGRESS_FG)
	var_115_2:setContentSize(arg_115_0 - 6, var_0_0.CRECT_PROGRESS_FG.height)
	var_115_2:setColor(arg_115_1 or lc.Color3B.yellow)
	var_115_1:addChild(var_115_2)
	var_115_2:setPercent(0)

	var_115_1._bar = var_115_2

	return var_115_1
end

function var_0_0.createLabelProgressBar(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
	local var_116_0 = var_0_0.createProgressBar(arg_116_0, arg_116_3)
	local var_116_1 = lc.w(var_116_0)
	local var_116_2 = lc.h(var_116_0)
	local var_116_3 = var_0_0.createBMFont(arg_116_1 or var_0_0.BMFont.huali_26, "")

	var_116_3:setScale(0.9)
	var_116_3:setPosition(var_116_1 / 2, var_116_2 / 2)

	if arg_116_2 then
		var_116_3:setColor(arg_116_2)
	end

	var_116_0:addChild(var_116_3)

	var_116_0._label = var_116_3

	function var_116_0.setLabel(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
		if arg_117_2 then
			if arg_117_3 then
				arg_117_0._label:setString(ClientData.formatNum(arg_117_1, 99999) .. "/" .. ClientData.formatNum(arg_117_2, 99999))
			else
				arg_117_0._label:setString(string.format("%d/%d", arg_117_1, arg_117_2))
			end
		else
			arg_117_0._label:setString(tostring(arg_117_1))
		end
	end

	return var_116_0
end

function var_0_0.createCheckLabelArea(arg_118_0, arg_118_1, arg_118_2)
	local var_118_0 = ccui.Widget:create()

	var_118_0:setAnchorPoint(0.5, 0.5)

	var_118_0._isCheck = arg_118_2 or false
	var_118_0._callback = arg_118_1

	local var_118_1 = cc.Label:createWithTTF(arg_118_0, var_0_0.TTF_FONT, var_0_0.FontSize.S1)
	local var_118_2 = var_0_0.createShaderButton("img_btn_check_bg", function(arg_119_0)
		var_118_0._isCheck = not var_118_0._isCheck

		arg_119_0._checkSprite:setVisible(var_118_0._isCheck)

		if var_118_0._callback then
			var_118_0._callback(var_118_0._isCheck)
		end
	end)

	var_118_2:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_118_2:setTouchRect(cc.rect(-10, -10, lc.w(var_118_2) + 20, lc.h(var_118_2) + 20))

	var_118_2._checkSprite = lc.createSprite("img_icon_check")

	var_118_2._checkSprite:setVisible(var_118_0._isCheck)
	lc.addChildToCenter(var_118_2, var_118_2._checkSprite)
	var_118_0:setContentSize(lc.w(var_118_2) + lc.w(var_118_1) + 6, math.max(lc.h(var_118_2), lc.h(var_118_1)))
	lc.addChildToPos(var_118_0, var_118_2, cc.p(lc.w(var_118_2) / 2, lc.h(var_118_0) / 2))
	lc.addChildToPos(var_118_0, var_118_1, cc.p(lc.w(var_118_0) - lc.w(var_118_1) / 2, lc.h(var_118_0) / 2))

	function var_118_0.setCheck(arg_120_0, arg_120_1)
		arg_120_0._isCheck = arg_120_1

		arg_120_0._btn._checkSprite:setVisible(arg_120_1)

		if arg_120_0._callback then
			arg_120_0._callback(arg_120_1)
		end
	end

	var_118_0._label = var_118_1
	var_118_0._btn = var_118_2

	return var_118_0
end

function var_0_0.createLineSprite(arg_121_0, arg_121_1)
	local var_121_0 = lc.frameSize(arg_121_0).height
	local var_121_1 = cc.rect(1, 0, 1, var_121_0)
	local var_121_2 = ccui.Scale9Sprite:createWithSpriteFrameName(arg_121_0, var_121_1)

	var_121_2:setContentSize(arg_121_1, var_121_0)

	return var_121_2
end

function var_0_0.createDividingLine(arg_122_0, arg_122_1)
	local var_122_0 = lc.createSprite("img_divide_line_8")

	if arg_122_0 then
		var_122_0:setScaleX(arg_122_0 / lc.w(var_122_0))
	end

	if arg_122_1 then
		var_122_0:setColor(arg_122_1)
	end

	return var_122_0
end

function var_0_0.createEvolutionArea(arg_123_0, arg_123_1)
	local var_123_0 = "card_quality"
	local var_123_1 = lc.frameSize(var_123_0)
	local var_123_2 = -7
	local var_123_3 = cc.size(lc.makeEven(var_123_1.width * arg_123_1 + var_123_2 * (arg_123_1 - 1)), var_123_1.height)
	local var_123_4 = lc.createNode(var_123_3)

	var_123_4:setCascadeOpacityEnabled(true)

	local var_123_5 = var_123_1.width / 2

	for iter_123_0 = 1, arg_123_1 do
		local var_123_6 = cc.Sprite:createWithSpriteFrameName(var_123_0)

		lc.addChildToPos(var_123_4, var_123_6, cc.p(var_123_5, var_123_1.height / 2))

		var_123_5 = var_123_5 + var_123_1.width + var_123_2
	end

	return var_123_4
end

function var_0_0.createStarArea(arg_124_0, arg_124_1)
	local var_124_0 = cc.size(240, 26)
	local var_124_1 = lc.createNode(var_124_0)

	var_124_1:setCascadeOpacityEnabled(true)

	local var_124_2 = {}

	for iter_124_0 = 1, var_0_0.MAX_STAR_COUNT do
		local var_124_3 = "card_quality"
		local var_124_4 = Data.getInfo(arg_124_1)

		if band(var_124_4._option, Data.MonsterOption.is_adjust) ~= 0 then
			var_124_3 = "card_quality2"
		elseif band(var_124_4._option, Data.MonsterOption.is_xyz) ~= 0 then
			var_124_3 = "card_quality3"
		end

		local var_124_5 = cc.ShaderSprite:createWithFramename(var_124_3)

		lc.addChildToCenter(var_124_1, var_124_5)

		var_124_2[iter_124_0] = var_124_5
	end

	var_124_1._icons = var_124_2

	function var_124_1.update(arg_125_0, arg_125_1, arg_125_2)
		local var_125_0 = "card_quality"
		local var_125_1 = Data.getInfo(arg_125_2)

		if band(var_125_1._option, Data.MonsterOption.is_adjust) ~= 0 then
			var_125_0 = "card_quality2"
		elseif band(var_125_1._option, Data.MonsterOption.is_xyz) ~= 0 then
			var_125_0 = "card_quality3"
		end

		local var_125_2 = lc.frameSize(var_125_0)
		local var_125_3 = var_124_0.width - var_125_2.width / 2
		local var_125_4 = -1

		if var_125_2.width * arg_125_1 + var_125_4 * (arg_125_1 - 1) > var_124_0.width then
			var_125_4 = (var_124_0.width - var_125_2.width * arg_125_1) / (arg_125_1 - 1)
		end

		for iter_125_0 = 1, var_0_0.MAX_STAR_COUNT do
			local var_125_5 = arg_125_0._icons[iter_125_0]

			var_125_5:setSpriteFrame(var_125_0)
			var_125_5:setVisible(iter_125_0 <= arg_125_1)
			var_125_5:setPosition(cc.p(var_125_3, var_124_0.height / 2))

			var_125_3 = var_125_3 - var_125_2.width - var_125_4
		end
	end

	function var_124_1.setEffect(arg_126_0, arg_126_1)
		for iter_126_0 = var_0_0.MAX_STAR_COUNT, 1, -1 do
			arg_126_0._icons[iter_126_0]:setEffect(arg_126_1)
		end
	end

	var_124_1:update(arg_124_0, arg_124_1)

	return var_124_1
end

function var_0_0.createArrowButton(arg_127_0, arg_127_1, arg_127_2)
	local var_127_0 = lc.createSprite("img_arrow_2")
	local var_127_1 = arg_127_1.width
	local var_127_2 = arg_127_1.height
	local var_127_3 = var_0_0.createShaderButton(nil, arg_127_2)

	var_127_3:setContentSize(var_127_1, var_127_2)
	var_127_3:setTouchRect(cc.rect(0, -20, var_127_1, var_127_2 + 40))
	var_127_0:setFlippedX(not arg_127_0)

	local var_127_4 = arg_127_0 and -6 or 6
	local var_127_5 = lc.absTime(0.8)

	var_127_0:runAction(lc.rep(lc.sequence(lc.moveBy(var_127_5, var_127_4, 0), lc.moveBy(var_127_5, -var_127_4, 0))))
	lc.addChildToPos(var_127_3, var_127_0, cc.p(var_127_1 / 2 - var_127_4 / 2, var_127_2 / 2))

	var_127_3._arrow = var_127_0

	return var_127_3
end

function var_0_0.createUpgradableDesc(arg_128_0, arg_128_1, arg_128_2, arg_128_3, arg_128_4)
	local var_128_0 = arg_128_4 and arg_128_4._fontSize or var_0_0.FontSize.S2
	local var_128_1 = arg_128_4 and arg_128_4._curColor or var_0_0.COLOR_TEXT_LIGHT
	local var_128_2 = Str(arg_128_0._descSid)
	local var_128_3 = string.gsub(var_128_2, "#", "")

	if arg_128_0._val[1] > 0 then
		local var_128_4 = arg_128_4 and arg_128_4._nextColor or var_0_0.COLOR_TEXT_GREEN

		var_128_3 = string.gsub(var_128_3, "%[%d+%]", "|")

		local var_128_5 = ccui.RichTextEx:create()

		var_128_5:setCascadeOpacityEnabled(true)
		var_128_5:setMaxWidth(arg_128_3)

		local var_128_6 = string.splitByChar(var_128_3, "|")
		local var_128_7 = 2

		if var_128_3[1] == "|" then
			table.insert(var_128_6, 1, "")
		elseif var_128_3[#var_128_3] == "|" then
			table.insert(var_128_6, "")
		end

		var_128_5:insertElement(ccui.RichItemLabel:create(0, var_128_1, 255, var_128_6[1], var_0_0.TTF_FONT, var_128_0))

		while var_128_7 <= #var_128_6 do
			if arg_128_2 and arg_128_1 < arg_128_2 then
				var_128_5:insertElement(ccui.RichItemLabel:create(0, var_128_1, 255, string.format("%d ", arg_128_0._val[arg_128_1]), var_0_0.TTF_FONT, var_128_0))

				local var_128_8 = lc.createSprite("img_arrow_right")

				var_128_8:setScale(0.5)
				var_128_8:setColor(var_128_4)

				local var_128_9 = lc.createNode(cc.size(lc.makeEven(lc.sw(var_128_8)), var_128_0 + 2))

				lc.addChildToCenter(var_128_9, var_128_8)
				var_128_5:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, var_128_9))
				var_128_5:insertElement(ccui.RichItemLabel:create(0, var_128_4, 255, string.format(" %d", arg_128_0._val[arg_128_2]), var_0_0.TTF_FONT, var_128_0))
			else
				var_128_5:insertElement(ccui.RichItemLabel:create(0, var_128_4, 255, tonumber(arg_128_0._val[arg_128_1]), var_0_0.TTF_FONT, var_128_0))
			end

			var_128_5:insertElement(ccui.RichItemLabel:create(0, var_128_1, 255, var_128_6[var_128_7], var_0_0.TTF_FONT, var_128_0))

			var_128_7 = var_128_7 + 1
		end

		var_128_5:formatText()

		return var_128_5
	else
		return (var_0_0.createTTF(var_128_3, var_128_0, var_128_1, cc.size(arg_128_3, 0)))
	end
end

function var_0_0.createSkillDesc(arg_129_0, arg_129_1, arg_129_2, arg_129_3, arg_129_4)
	local var_129_0 = type(arg_129_0) == "table" and arg_129_0 or Data._skillInfo[arg_129_0]

	return var_0_0.createUpgradableDesc(var_129_0, arg_129_1, arg_129_2, arg_129_3, arg_129_4)
end

function var_0_0.createUnionTechDesc(arg_130_0, arg_130_1, arg_130_2, arg_130_3, arg_130_4)
	local var_130_0 = type(arg_130_0) == "table" and arg_130_0 or Data._unionTechInfo[arg_130_0]

	return var_0_0.createUpgradableDesc(var_130_0, arg_130_1, arg_130_2, arg_130_3, arg_130_4)
end

function var_0_0.createBattleSkillItem(arg_131_0, arg_131_1, arg_131_2)
	local var_131_0 = cc.size(350, (arg_131_1._id == 9480 or arg_131_1._id == 9481) and 340 or 220)
	local var_131_1 = ccui.Layout:create()

	var_131_1:setContentSize(var_131_0)
	var_131_1:setAnchorPoint(0.5, 0.5)
	var_131_1:setPosition(arg_131_2)
	var_131_1:setCascadeOpacityEnabled(true)
	var_131_1:setTouchEnabled(true)

	local var_131_2 = lc.createSprite({
		_name = "card_dialog_1",
		_crect = cc.rect(14, 100, 1, 80),
		_size = var_131_0
	})

	var_131_1._bg = var_131_2

	lc.addChildToCenter(var_131_1, var_131_2)

	local var_131_3 = cc.p(var_131_1:getContentSize().width / 2, var_131_1:getContentSize().height / 2)
	local var_131_4 = Data.getSkillType(arg_131_1._id)
	local var_131_5 = cc.Sprite:createWithSpriteFrameName("img_icon_skill_" .. var_131_4)

	var_131_5:setPosition(var_131_3.x - 128, var_131_0.height - 42)
	var_131_1:addChild(var_131_5)

	local var_131_6 = Data._skillInfo[arg_131_1._id]._val[math.min(arg_131_1._level, #Data._skillInfo[arg_131_1._id]._val)]
	local var_131_7 = cc.c3b(255, 0, 0)
	local var_131_8 = Str(Data._skillInfo[arg_131_1._id]._nameSid)
	local var_131_9 = cc.Label:createWithTTF(var_131_8, ClientView.TTF_FONT, 26)

	var_131_9:setColor(var_131_7)
	var_131_9:setAnchorPoint(0, 0.5)
	var_131_9:setPosition(var_131_3.x - 94, var_131_0.height - 42)
	var_131_1:addChild(var_131_9)

	local var_131_10 = arg_131_1._isLocked and cc.c3b(80, 49, 49) or ClientView.COLOR_TEXT_DARK
	local var_131_11 = Str(Data._skillInfo[arg_131_1._id]._descSid)

	if arg_131_1._level > 0 then
		local var_131_12, var_131_13, var_131_14 = string.find(var_131_11, "%[(.-)%]")

		if var_131_12 ~= nil and var_131_13 ~= nil and var_131_14 ~= nil then
			var_131_11 = string.gsub(var_131_11, "%[" .. var_131_14 .. "%]", var_131_6)
		end
	end

	local var_131_15, var_131_16, var_131_17 = string.find(var_131_11, "%#(.-)%#")

	if var_131_15 ~= nil and var_131_16 ~= nil and var_131_17 ~= nil then
		var_131_11 = string.gsub(var_131_11, "%#" .. var_131_17 .. "%#", var_131_17)
	end

	local var_131_18 = cc.Label:createWithTTF(var_131_11, ClientView.TTF_FONT, 26, cc.size(312, 0), cc.TEXT_ALIGNMENT_LEFT)

	var_131_18:setAnchorPoint(0, 1)
	var_131_18:setScale(0.8)
	var_131_18:setColor(var_131_10)
	var_131_18:setPosition(18, lc.bottom(var_131_5) - 4)
	var_131_1:addChild(var_131_18)

	return var_131_1
end

function var_0_0.createLegendNumArea(arg_132_0)
	local var_132_0 = lc.createSprite("img_legend_num_bg")

	var_132_0:setCascadeOpacityEnabled(true)

	local var_132_1 = var_0_0.createBMFont(var_0_0.BMFont.number_legend, Str(STR[string.format("NUM_%d", arg_132_0)]))

	var_132_1:setColor(var_0_0.COLOR_LEGEND_NUM)
	lc.addChildToCenter(var_132_0, var_132_1)

	var_132_0._num = var_132_1

	return var_132_0
end

function var_0_0.createNameLabel(arg_133_0, arg_133_1, arg_133_2, arg_133_3)
	if arg_133_3 ~= nil then
		local var_133_0 = var_0_0.createShaderButton(nil, arg_133_3)
		local var_133_1 = cc.Label:createWithTTF(arg_133_0, var_0_0.TTF_FONT, var_0_0.FontSize.S2)

		var_133_1:setColor(arg_133_1)
		var_133_0:setContentSize(var_133_1:getContentSize())
		lc.addChildToCenter(var_133_0, var_133_1)
		var_133_0:setZoomScale(0)

		if arg_133_2 == nil or arg_133_2 == cc.TEXT_ALIGNMENT_LEFT then
			var_133_0:setAnchorPoint(0, 0.5)
		elseif arg_133_2 == cc.TEXT_ALIGNMENT_CENTER then
			var_133_0:setAnchorPoint(0.5, 0.5)
		else
			var_133_0:setAnchorPoint(1, 0.5)
		end

		return var_133_0
	else
		local var_133_2 = cc.Label:createWithTTF(arg_133_0, var_0_0.TTF_FONT, var_0_0.FontSize.S2, cc.size(220, 30), arg_133_2 or cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

		var_133_2:setColor(arg_133_1)

		return var_133_2
	end
end

function var_0_0.createStatusLabel(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0 = lc.createSprite("img_status_rect")

	var_134_0:setColor(arg_134_1)

	if arg_134_2 then
		var_134_0:setRotation(arg_134_2)
	end

	local var_134_1 = var_0_0.createTTF(arg_134_0, var_0_0.FontSize.S1, arg_134_1)

	lc.addChildToCenter(var_134_0, var_134_1)

	var_134_0._label = var_134_1

	return var_134_0
end

function var_0_0.createCheckinTitle(arg_135_0, arg_135_1)
	return (var_0_0.createBMFont(var_0_0.BMFont.huali_32, arg_135_0))
end

function var_0_0.createUnionMemberItem(arg_136_0, arg_136_1, arg_136_2)
	local var_136_0 = ccui.Widget:create()

	var_136_0:setContentSize(arg_136_1, 120)
	var_136_0:setTouchEnabled(true)
	var_136_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_136_0:addTouchEventListener(function(arg_137_0, arg_137_1)
		if arg_137_1 == ccui.TouchEventType.ended and var_136_0._member._id ~= P._id then
			if arg_136_2 then
				var_0_0.operateMember(var_136_0._member, var_136_0)
			else
				var_0_0.operateUser(var_136_0._member, var_136_0)
			end
		end
	end)

	local var_136_1 = lc.createSprite({
		_name = "img_com_bg_35",
		_crect = var_0_0.CRECT_COM_BG35,
		_size = var_136_0:getContentSize()
	})

	lc.addChildToCenter(var_136_0, var_136_1, -1)

	var_136_0._bg = var_136_1

	local var_136_2 = UserWidget.create(arg_136_0, UserWidget.Flag.LEVEL_NAME)

	var_136_2:setScale(0.9)
	lc.addChildToPos(var_136_0, var_136_2, cc.p(lc.w(var_136_2) / 2 + 10, lc.h(var_136_0) / 2 + 4))

	var_136_0._userArea = var_136_2

	local var_136_3 = lc.createSprite("img_union_leader")

	var_136_3:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_136_2, var_136_3, cc.p(lc.right(var_136_2._nameArea) + 10, lc.y(var_136_2) + 4))

	var_136_0._job = var_136_3

	local var_136_4 = lc.createSprite("img_badge")

	var_136_4:setVisible(false)
	lc.addChildToPos(var_136_2, var_136_4, cc.p(lc.right(var_136_3) + 80, lc.h(var_136_2) - lc.ch(var_136_4) + 11))

	var_136_0._badgeIcon = var_136_4

	local var_136_5 = cc.p(lc.right(var_136_3) + 80, lc.bottom(var_136_4) - 15)
	local var_136_6 = ClientView.createTTF("80" .. Str(STR.LEVEL_S), ClientView.FontSize.S1)

	var_136_6:setVisible(false)
	lc.addChildToPos(var_136_2, var_136_6, var_136_5)

	var_136_0._badgeTxt = var_136_6

	local var_136_7 = ClientView.createTTF("(+0exp)", ClientView.FontSize.S1, ClientView.COLOR_TEXT_GREEN_2)

	var_136_7:setVisible(false)
	lc.addChildToPos(var_136_2, var_136_7, cc.p(lc.right(var_136_6) + lc.cw(var_136_7), lc.bottom(var_136_4) - 15))

	var_136_0._expDonateTxt = var_136_7

	local var_136_8 = var_0_0.createKeyValueLabel(Str(STR.LAST_LOGIN_TIME), "", var_0_0.FontSize.S2, false)

	var_136_8:setColor(ClientView.COLOR_TEXT_DARK)
	var_136_8._value:setColor(ClientView.COLOR_TEXT_DARK)
	var_136_8:addToParent(var_136_0, cc.p(lc.left(var_136_2) + 94, lc.y(var_136_2) - 30))

	var_136_0._lastLogin = var_136_8

	local var_136_9 = ClientView.createIconLabelArea("img_icon_res6_s", arg_136_0._trophy, 140)

	lc.addChildToPos(var_136_0, var_136_9, cc.p(lc.w(var_136_0) - 24 - lc.w(var_136_9) / 2, lc.ch(var_136_0)))

	var_136_0._starArea = var_136_9

	function var_136_0.update(arg_138_0, arg_138_1)
		var_136_0._member = arg_138_1

		var_136_0._bg:setColor(arg_138_1._id == P._id and var_0_0.COLOR_TEXT_GREEN or lc.Color3B.white)
		var_136_0._userArea:setUser(arg_138_1)

		if arg_138_1._unionJob == Data.UnionJob.leader or arg_138_1._unionJob == Data.UnionJob.elder then
			var_136_0._job:setVisible(true)
			var_136_0._job:setSpriteFrame(arg_138_1._unionJob == Data.UnionJob.leader and "img_union_leader" or "img_union_elder")
		else
			var_136_0._job:setVisible(false)
		end

		local var_138_0 = "img_badge"

		if arg_138_1._isBuybadge then
			var_138_0 = "img_gold_badge_1"
		end

		var_136_0._badgeIcon:setSpriteFrame(var_138_0)
		var_136_0._badgeTxt:setString(arg_138_1._badgeLevel .. Str(STR.LEVEL_S))

		if arg_138_1._badgeLevel > 0 then
			var_136_0._expDonateTxt:setString("(+" .. arg_138_1._expDonate .. "xp)")
			var_136_0._badgeTxt:setPosition(cc.p(var_136_5.x - lc.cw(var_136_0._badgeTxt), var_136_5.y))
			var_136_0._expDonateTxt:setPosition(cc.p(var_136_5.x + lc.cw(var_136_0._expDonateTxt), var_136_5.y))
		else
			var_136_0._expDonateTxt:setString("")
			var_136_0._badgeTxt:setPosition(var_136_5)
		end

		var_136_0._lastLogin._value:setString(ClientData.getTimeAgo(arg_138_1._lastLogin, 7))
		var_136_0._starArea._label:setString(arg_138_1._trophy)
	end

	return var_136_0
end

function var_0_0.createUnionGroupMemItem(arg_139_0, arg_139_1, arg_139_2, arg_139_3)
	if arg_139_2 == nil then
		arg_139_2 = true
	end

	if arg_139_3 == nil then
		arg_139_3 = true
	end

	local var_139_0 = ccui.Widget:create()

	var_139_0:setContentSize(100, arg_139_3 and 160 or 120)
	var_139_0:setTouchEnabled(true)
	var_139_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_139_0:addTouchEventListener(function(arg_140_0, arg_140_1)
		if arg_140_1 == ccui.TouchEventType.ended and var_139_0._member and var_139_0._member._id ~= P._id then
			var_0_0.operateGroupMember(var_139_0)
		end
	end)

	local var_139_1 = lc.createSprite("group_mem_bg")

	lc.addChildToPos(var_139_0, var_139_1, cc.p(lc.cw(var_139_0), lc.h(var_139_0) - lc.ch(var_139_1)))

	local var_139_2 = UserWidget.create(arg_139_1, 0.5)

	lc.addChildToCenter(var_139_1, var_139_2)

	local var_139_3 = ClientView.createShaderButton(nil, function(arg_141_0)
		if var_139_0._addFunc then
			var_139_0:_addFunc(var_139_0)
		end
	end)
	local var_139_4 = lc.createSprite("img_icon_add_big")

	var_139_4:setScale(0.4)
	var_139_3:setContentSize(var_139_1:getContentSize())
	lc.addChildToCenter(var_139_3, var_139_4)
	lc.addChildToCenter(var_139_1, var_139_3)

	local var_139_5 = ClientView.createTTF("", ClientView.FontSize.S3)

	lc.addChildToPos(var_139_0, var_139_5, cc.p(lc.cw(var_139_0), lc.bottom(var_139_1) - 20))

	var_139_0._nameLabel = var_139_5

	local var_139_6 = ClientView.createIconLabelArea("img_icon_res15_s", "", 150)

	var_139_6:setScale(0.6)
	var_139_6:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_139_0, var_139_6, cc.p(lc.cw(var_139_0), lc.bottom(var_139_1) - 50))

	function var_139_0.update(arg_142_0, arg_142_1, arg_142_2, arg_142_3, arg_142_4)
		arg_142_0._member = arg_142_2
		arg_142_0._groupId = arg_142_1

		var_139_5:setVisible(true)

		if arg_142_2 then
			var_139_2:setVisible(true)
			var_139_2:setUser(arg_142_2)
			var_139_3:setVisible(false)
			var_139_5:setString(arg_142_2._name)
			var_139_6._label:setString(arg_142_2._massWarScore or "0")
			var_139_6:setVisible(arg_142_4 == true)
		else
			var_139_5:setString(Str(STR.CAN_S) .. Str(STR.JOIN))

			if not arg_142_3 then
				var_139_5:setVisible(false)
			end

			var_139_2:setVisible(false)
			var_139_3:setVisible(true)
			var_139_6:setVisible(false)
		end

		if not arg_142_3 then
			var_139_3:setVisible(false)
		end
	end

	var_139_0:update(arg_139_0, arg_139_1, arg_139_2, arg_139_3)

	return var_139_0
end

function var_0_0.createSnowArea(arg_143_0, arg_143_1)
	local var_143_0 = 4
	local var_143_1 = arg_143_1 or 40
	local var_143_2 = 20
	local var_143_3 = 1
	local var_143_4 = 3
	local var_143_5 = lc.createNode(arg_143_0)

	local function var_143_6(arg_144_0, arg_144_1)
		local var_144_0 = lc.moveBy(arg_143_0.height * 2 / arg_144_1, 0, -arg_143_0.height * 2)

		var_144_0:setTag(var_143_3)
		arg_144_0:runAction(var_144_0)
	end

	local var_143_7 = {}

	for iter_143_0 = 1, var_143_0 do
		local var_143_8 = var_143_4 * var_143_2 * (iter_143_0 + 1) / 8
		local var_143_9 = lc.createNode(arg_143_0)

		lc.addChildToPos(var_143_5, var_143_9, cc.p(arg_143_0.width / 2 + var_143_8, arg_143_0.height / 2), 0, iter_143_0)
		var_143_9:runAction(lc.rep(lc.sequence(lc.ease(lc.moveTo(var_143_4, arg_143_0.width / 2 - 2 * var_143_8, arg_143_0.height / 2), "SineIO", 0.9), lc.ease(lc.moveTo(var_143_4, arg_143_0.width / 2 + 2 * var_143_8, arg_143_0.height / 2), "SineIO", 0.9))))

		local var_143_10 = var_143_1 / (iter_143_0 + 1)

		for iter_143_1 = 1, var_143_10 do
			local var_143_11 = var_143_2 + math.random(0, 50)
			local var_143_12 = lc.createSprite("img_snow")

			var_143_12:setScale(1 + 0.5 * iter_143_0)
			var_143_12:setPosition(math.random(arg_143_0.width), math.random(arg_143_0.height))
			var_143_9:addChild(var_143_12)

			var_143_12._group = iter_143_0

			var_143_6(var_143_12, var_143_11 * (iter_143_0 + 1))
			table.insert(var_143_7, var_143_12)
		end
	end

	var_143_5:scheduleUpdateWithPriorityLua(function()
		for iter_145_0, iter_145_1 in ipairs(var_143_7) do
			local var_145_0 = lc.y(iter_145_1)

			if var_145_0 < 0 then
				local var_145_1 = var_143_2 + math.random(0, 50)

				iter_145_1:stopActionByTag(var_143_3)
				iter_145_1:setPosition(math.random(arg_143_0.width), arg_143_0.height - math.floor(-var_145_0) % arg_143_0.height)
				var_143_6(iter_145_1, var_145_1 * (iter_145_1._group + 1))
			end
		end
	end, 0)

	return var_143_5
end

function var_0_0.createClashFieldArea(arg_146_0, arg_146_1, arg_146_2)
	local var_146_0 = lc.createImageView({
		_name = "img_com_bg_21",
		_crect = ClientView.CRECT_COM_BG21,
		_size = cc.size(500, 320)
	})
	local var_146_1 = string.format("res/bat_scene/bat_scene_%d_bg.jpg", 10 + arg_146_0)

	var_146_0:registerScriptHandler(function(arg_147_0)
		if arg_147_0 == "cleanup" then
			lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(var_146_1))
		end
	end)

	local var_146_2 = lc.createSprite(var_146_1)

	var_146_2:setScale(0.34)

	local var_146_3 = cc.ClippingNode:create()

	var_146_3:setContentSize(var_146_0:getContentSize())

	local var_146_4 = cc.LayerColor:create(lc.Color4B.white, lc.w(var_146_0) - 30, lc.h(var_146_0))

	var_146_4:setPosition(14, 0)
	var_146_3:setStencil(var_146_4)
	lc.addChildToCenter(var_146_3, var_146_2)
	lc.addChildToCenter(var_146_0, var_146_3, -1)

	var_146_0._bg = var_146_2

	local var_146_5 = DragonBones.create(ClientView.trophyGradeBones[arg_146_0])

	var_146_5:gotoAndPlay("effect")
	lc.addChildToCenter(var_146_0, var_146_5)

	var_146_0._bones = var_146_5

	local var_146_6 = lc.createSprite("img_title_bg_1")

	var_146_6:setScale(0.8)
	lc.addChildToPos(var_146_0, var_146_6, cc.p(lc.w(var_146_0) / 2, lc.h(var_146_0) - lc.h(var_146_6) / 2 - ClientView.FRAME_INNER_TOP + 8))

	local var_146_7 = Str(Data._ladderInfo[arg_146_0]._nameSid)
	local var_146_8 = var_0_0.COLORS_TEXT_CLASH_GRADE[arg_146_0]
	local var_146_9 = ClientView.createTTF(var_146_7 .. " " .. Str(STR.FIND_CLASH_FIELD), ClientView.FontSize.S2, var_146_8)

	lc.addChildToPos(var_146_0, var_146_9, cc.p(lc.w(var_146_0) / 2, lc.h(var_146_0) - 46))

	if arg_146_2 then
		local var_146_10 = ClientView.createResIconLabel(180, "img_icon_res6_s")

		lc.addChildToPos(var_146_0, var_146_10, cc.p(lc.w(var_146_0) / 2 + 12, math.floor(lc.h(var_146_10) / 2 + 40)))

		if arg_146_0 == Data.FindClashGrade.legend then
			var_146_10._label:setString(string.format("%d +", Data._ladderInfo[arg_146_0]._trophy))
		else
			local var_146_11 = arg_146_0 == Data.FindClashGrade.bronze and 0 or Data._ladderInfo[arg_146_0]._trophy

			var_146_10._label:setString(string.format("%d - %d", var_146_11, Data._ladderInfo[arg_146_0 + 1]._trophy - 1))
		end

		var_146_0._trophy = var_146_10._label
	end

	if arg_146_1 then
		var_146_0:setTouchEnabled(true)
		var_146_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		var_146_0:addTouchEventListener(function(arg_148_0, arg_148_1)
			if arg_148_1 == ccui.TouchEventType.ended then
				arg_146_1()
			end
		end)
	end

	return var_146_0
end

function var_0_0.createClashFieldChest(arg_149_0, arg_149_1, arg_149_2, arg_149_3)
	local var_149_0 = {
		"mubaoxiang",
		"tongbaoxiang",
		"yinbaoxiang",
		"jinbaoxiang",
		"heizuanbaoxiang"
	}
	local var_149_1 = ClientView.createShaderButton(nil, function(arg_150_0)
		local var_150_0 = P._propBag._props[arg_150_0._infoId]

		if var_150_0._num > 0 and not var_150_0._isOpened and not arg_149_3 then
			ClientView.getActiveIndicator():show(Str(STR.OPENING), nil, arg_150_0)
			ClientData.sendOpenBox(arg_150_0._infoId, 1)
		else
			require("ClashChestForm").create(arg_149_0, arg_149_1, arg_149_2):show()
		end
	end)

	var_149_1:setContentSize(cc.size(100, 100))

	local var_149_2 = DragonBones.create(var_149_0[arg_149_1])

	var_149_2:setScale(0.4)
	var_149_2:gotoAndPlay("effect4")
	lc.addChildToCenter(var_149_1, var_149_2)

	var_149_1._bones = var_149_2

	function var_149_1.update(arg_151_0, arg_151_1)
		arg_151_0._infoId = Data.PropsId.clash_chest + 10 * (arg_151_1 - 1) + arg_149_1

		local var_151_0 = P._propBag._props[arg_151_0._infoId]

		if var_151_0._num == 0 or arg_149_3 then
			var_149_2:gotoAndPlay("effect4")
		elseif var_151_0._isOpened then
			var_149_2:gotoAndPlay("effect5")
		else
			var_149_2:gotoAndPlay("effect2")
		end
	end

	var_149_1:update(arg_149_0)

	return var_149_1
end

function var_0_0.createClashTargetChest(arg_152_0, arg_152_1)
	local var_152_0 = {
		"mubaoxiang",
		"mubaoxiang2",
		"tongbaoxiang",
		"yinbaoxiang",
		"jinbaoxiang",
		"heizuanbaoxiang"
	}
	local var_152_1 = ClientView.createShaderButton(nil, function(arg_153_0)
		local var_153_0 = P:getClashTargetStep()
		local var_153_1 = P._playerBonus._bonusClashTarget[var_153_0]

		if var_153_1 and var_153_1:canClaim() then
			if ClientData.claimBonus(var_153_1) == Data.ErrorType.ok then
				local var_153_2 = require("RewardPanel")

				var_153_2.create(var_153_1, var_153_2.MODE_CLAIM):show()

				if arg_153_0._openCallback then
					arg_153_0._openCallback()
				end
			end
		else
			require("ClashTargetChestForm").create(var_153_0):show()
		end
	end)

	var_152_1._openCallback = arg_152_1

	var_152_1:setContentSize(100, 100)

	local var_152_2 = P._playerBonus._bonusClashTarget[arg_152_0]
	local var_152_3 = DragonBones.create(var_152_0[arg_152_0])

	var_152_3:setScale(0.4)
	var_152_3:gotoAndPlay(var_152_2:canClaim() and "effect2" or var_152_2._isClaimed and "effect5" or "effect4")
	lc.addChildToCenter(var_152_1, var_152_3)

	var_152_1._bones = var_152_3

	function var_152_1.update()
		var_152_3:gotoAndPlay(var_152_2:canClaim() and "effect2" or var_152_2._isClaimed and "effect5" or "effect4")
	end

	return var_152_1
end

function var_0_0.showPanelActiveIndicator(arg_155_0, arg_155_1)
	local var_155_0 = arg_155_1 and cc.size(arg_155_1.width, arg_155_1.height) or arg_155_0:getContentSize()
	local var_155_1 = arg_155_1 and cc.p(arg_155_1.x, arg_155_1.y) or cc.p(0, 0)
	local var_155_2 = lc.createMaskLayer(0, lc.Color3B.red, var_155_0)

	lc.addChildToPos(arg_155_0, var_155_2, var_155_1)

	local var_155_3 = lc.createSprite("img_panel_active_indicator")

	var_155_3:runAction(lc.rep(lc.rotateBy(2, 360)))
	lc.addChildToCenter(var_155_2, var_155_3)

	return var_155_2
end

function var_0_0.showResChangeText(arg_156_0, arg_156_1, arg_156_2, arg_156_3, arg_156_4, arg_156_5)
	local var_156_0 = string.format("img_icon_res%d_s", arg_156_1)

	if lc.FrameCache:getSpriteFrame(var_156_0) == nil then
		var_156_0 = ClientData.getPropIconName(arg_156_1)
	end

	local var_156_1 = lc.createSprite(var_156_0)
	local var_156_2 = var_0_0.createBMFont(var_0_0.BMFont.huali_26, arg_156_2 > 0 and string.format("+ %d", arg_156_2) or string.format("- %d", -arg_156_2))
	local var_156_3 = lc.w(var_156_1) + lc.w(var_156_2) + 20

	var_156_1:setPosition(lc.w(arg_156_0) / 2 - var_156_3 / 2 + lc.w(var_156_1) / 2 + (arg_156_3 or 0), lc.h(arg_156_0) / 2 + (arg_156_4 or 0))
	var_156_1:runAction(lc.spawn({
		1.5,
		lc.fadeOut(0.5),
		lc.remove()
	}, lc.moveBy(1.5, 0, 50)))
	var_156_2:setColor(arg_156_1 == Data.ResType.ingot and var_0_0.COLOR_TEXT_INGOT or var_0_0.COLOR_TEXT_WHITE)
	var_156_2:setPosition(lc.w(arg_156_0) / 2 + var_156_3 / 2 - lc.w(var_156_2) / 2 + (arg_156_3 or 0), lc.y(var_156_1))
	var_156_2:runAction(lc.spawn({
		1.5,
		lc.fadeOut(0.5),
		lc.remove()
	}, lc.moveBy(1.5, 0, 50)))

	if arg_156_5 then
		var_156_1:setScale(arg_156_5)
		var_156_2:setScale(arg_156_5)
	end

	arg_156_0:addChild(var_156_1, ClientData.ZOrder.toast)
	arg_156_0:addChild(var_156_2, ClientData.ZOrder.toast)
end

function var_0_0.showHelpForm(arg_157_0, arg_157_1)
	local var_157_0 = Data.getHelpStrsByType(arg_157_1)

	require("HelpForm").create(arg_157_0, var_157_0):show()
end

function var_0_0.showSweepForm(arg_158_0)
	local var_158_0 = arg_158_0.result
	local var_158_1 = arg_158_0.timestamp
	local var_158_2 = {}
	local var_158_3 = {}
	local var_158_4 = {}
	local var_158_5 = {}
	local var_158_6 = 0

	for iter_158_0, iter_158_1 in ipairs(var_158_0) do
		for iter_158_2, iter_158_3 in ipairs(iter_158_1.resource) do
			if iter_158_3.info_id == Data.ResType.exp then
				var_158_6 = var_158_6 + iter_158_3.num
			else
				table.insert(var_158_2, iter_158_3.info_id)
				table.insert(var_158_3, iter_158_3.level)
				table.insert(var_158_4, iter_158_3.num)
				table.insert(var_158_5, iter_158_3.is_fragment)
			end
		end
	end

	P:addResources(var_158_2, var_158_3, var_158_4, var_158_5)

	local var_158_7 = P._level

	P:changeExp(var_158_6, var_158_1 / 1000)
	require("SweepForm").create(var_158_0, var_158_7):show()
end

function var_0_0.showVipExpEffect(arg_159_0, arg_159_1)
	local var_159_0 = Particle.create("vipjd2")
	local var_159_1 = Particle.create("vipjd3")

	if arg_159_1 then
		var_159_0:setScaleX(arg_159_1)
		var_159_1:setScaleX(arg_159_1)
	end

	lc.addChildToCenter(arg_159_0, var_159_0)
	lc.addChildToCenter(arg_159_0, var_159_1)
end

function var_0_0.addUISceneCommonFrames(arg_160_0, arg_160_1)
	local var_160_0 = 10
	local var_160_1 = var_0_0.createLineSprite("img_divide_line_4", lc.w(arg_160_0))
	local var_160_2 = arg_160_1 - lc.h(var_160_1) / 2

	lc.addChildToPos(arg_160_0, var_160_1, cc.p(lc.w(arg_160_0) / 2, var_160_2), var_160_0)

	arg_160_0._frameTopLine = var_160_1

	local var_160_3 = lc.createSprite("img_com_bg_8")

	var_160_3:setScaleX(lc.w(arg_160_0) / lc.w(var_160_3) + 0.1)
	lc.addChildToPos(arg_160_0, var_160_3, cc.p(lc.w(arg_160_0) / 2, var_160_2 - lc.h(var_160_3) / 2))

	arg_160_0._frameTopBg = var_160_3

	local var_160_4 = var_0_0.createLineSprite("img_divide_line_4", lc.w(arg_160_0))

	var_160_4:setRotation(180)
	lc.addChildToPos(arg_160_0, var_160_4, cc.p(lc.w(arg_160_0) / 2, 4), var_160_0)

	local var_160_5 = lc.createSprite("img_com_bg_8")

	var_160_5:setScaleX(lc.w(arg_160_0) / lc.w(var_160_5) + 0.1)
	var_160_5:setScaleY(2)
	lc.addChildToPos(arg_160_0, var_160_5, cc.p(lc.w(arg_160_0) / 2, lc.h(var_160_5) / 2 + 6))

	arg_160_0._frameBottomBg = var_160_5
end

function var_0_0.addVerticalTabButtons(arg_161_0, arg_161_1, arg_161_2, arg_161_3, arg_161_4, arg_161_5)
	local var_161_0 = 159

	arg_161_5 = arg_161_5 or 116

	local var_161_1 = lc.List.createV(cc.size(var_161_0, arg_161_4 or arg_161_2), 0, 0)

	lc.addChildToPos(arg_161_0, var_161_1, cc.p(arg_161_3, arg_161_2 - lc.h(var_161_1)))

	arg_161_0._tabArea = var_161_1

	local var_161_2 = #arg_161_1 * arg_161_5
	local var_161_3 = ccui.Widget:create()

	var_161_3:setContentSize(lc.w(var_161_1), var_161_2)
	var_161_1:pushBackCustomItem(var_161_3)

	if var_161_2 < lc.h(var_161_1) then
		var_161_1:setBounceEnabled(false)
	end

	function var_161_1.showTab(arg_162_0, arg_162_1)
		if arg_162_0._focusTabIndex then
			arg_162_0:unfocusTab(arg_162_0._focusTabIndex)
		end

		arg_162_0._focusTabIndex = arg_162_1

		local var_162_0 = arg_162_0._tabs[arg_162_0._focusTabIndex]

		var_162_0:loadTextureNormal("img_btn_tab_bg_focus_1", ccui.TextureResType.plistType)
		var_162_0:setEnabled(false)
		var_162_0:setSwallowTouches(false)
	end

	function var_161_1.unfocusTab(arg_163_0, arg_163_1)
		local var_163_0 = arg_163_0._tabs[arg_163_1]

		var_163_0:loadTextureNormal("img_btn_tab_bg_unfocus_1", ccui.TextureResType.plistType)
		var_163_0:setEnabled(true)
		var_163_0:setSwallowTouches(true)
	end

	function var_161_1.insertTab(arg_164_0, arg_164_1, arg_164_2)
		local var_164_0 = var_0_0.createShaderButton("img_btn_tab_bg_unfocus_1", function(arg_165_0)
			if arg_161_0.showTab then
				arg_161_0:showTab(arg_165_0._index)
			else
				var_161_1:showTab(arg_165_0._index)
			end
		end)

		var_164_0:setAnchorPoint(0, 0.5)
		var_164_0:addLabel(arg_164_2)
		var_164_0:setZoomScale(0)
		var_161_3:addChild(var_164_0, -arg_164_1 - 1)
		table.insert(var_161_1._tabs, arg_164_1, var_164_0)

		for iter_164_0, iter_164_1 in ipairs(var_161_1._tabs) do
			iter_164_1._index = iter_164_0
		end

		if arg_164_0._focusTabIndex and arg_164_1 <= arg_164_0._focusTabIndex then
			arg_164_0._focusTabIndex = arg_164_0._focusTabIndex + 1
		end

		arg_164_0:updateTabsPos()

		return var_164_0
	end

	function var_161_1.updateTabsPos(arg_166_0)
		local var_166_0 = 0

		for iter_166_0, iter_166_1 in ipairs(arg_166_0._tabs) do
			if iter_166_1:isVisible() then
				var_166_0 = var_166_0 + 1
			end
		end

		local var_166_1 = var_166_0 * arg_161_5

		var_161_3:setContentSize(lc.w(var_161_1), var_166_1)
		arg_166_0:setBounceEnabled(var_166_1 > lc.h(arg_166_0))
		arg_166_0:refreshView()

		local var_166_2 = var_166_1

		for iter_166_2, iter_166_3 in ipairs(arg_166_0._tabs) do
			if iter_166_3:isVisible() then
				iter_166_3:setPosition(0, var_166_2 - lc.h(iter_166_3) / 2)

				var_166_2 = var_166_2 - arg_161_5
			end
		end
	end

	var_161_1._tabs = {}

	for iter_161_0, iter_161_1 in ipairs(arg_161_1) do
		local var_161_4 = var_161_1:insertTab(iter_161_0, iter_161_1)
	end

	var_161_1:updateTabsPos()
end

function var_0_0.addRoundEffect(arg_167_0, arg_167_1)
	local function var_167_0(arg_168_0, arg_168_1, arg_168_2, arg_168_3)
		local var_168_0 = 0.01
		local var_168_1 = cc.BezierBy:create(var_168_0 * arg_168_3, {
			cc.p(-arg_168_0, 0),
			cc.p(-arg_168_0, arg_168_1),
			cc.p(0, arg_168_1)
		})
		local var_168_2 = cc.MoveBy:create(var_168_0 * arg_168_2, cc.p(arg_168_2, 0))
		local var_168_3 = cc.BezierBy:create(var_168_0 * arg_168_3, {
			cc.p(arg_168_0, 0),
			cc.p(arg_168_0, -arg_168_1),
			cc.p(0, -arg_168_1)
		})
		local var_168_4 = cc.MoveBy:create(var_168_0 * arg_168_2, cc.p(-arg_168_2, 0))

		return cc.RepeatForever:create(cc.Sequence:create(var_168_1, var_168_2, var_168_3, var_168_4))
	end

	local function var_167_1(arg_169_0, arg_169_1, arg_169_2, arg_169_3)
		local var_169_0 = 0.01
		local var_169_1 = cc.BezierBy:create(var_169_0 * arg_169_3, {
			cc.p(-arg_169_0, 0),
			cc.p(-arg_169_0, arg_169_1),
			cc.p(0, arg_169_1)
		})
		local var_169_2 = cc.MoveBy:create(var_169_0 * arg_169_2, cc.p(arg_169_2, 0))
		local var_169_3 = cc.BezierBy:create(var_169_0 * arg_169_3, {
			cc.p(arg_169_0, 0),
			cc.p(arg_169_0, -arg_169_1),
			cc.p(0, -arg_169_1)
		})
		local var_169_4 = cc.MoveBy:create(var_169_0 * arg_169_2, cc.p(-arg_169_2, 0))

		return cc.RepeatForever:create(cc.Sequence:create(var_169_3, var_169_4, var_169_1, var_169_2))
	end

	local var_167_2 = Particle.create("par_recharge")
	local var_167_3 = Particle.create("par_recharge")
	local var_167_4 = lc.sw(arg_167_0) - 2 * arg_167_1
	local var_167_5 = lc.sh(arg_167_0)

	var_167_2:setPositionType(cc.POSITION_TYPE_RELATIVE)
	var_167_2:setPosition(cc.p(arg_167_1, 0))
	var_167_2:runAction(var_167_0(arg_167_1, lc.sh(arg_167_0), var_167_4, var_167_5))
	var_167_3:setPositionType(cc.POSITION_TYPE_RELATIVE)
	var_167_3:setPosition(cc.p(arg_167_1 + var_167_4, lc.sh(arg_167_0)))
	var_167_3:runAction(var_167_1(arg_167_1, lc.sh(arg_167_0), var_167_4, var_167_5))
	arg_167_0:addChild(var_167_2)
	arg_167_0:addChild(var_167_3)
end

function var_0_0.addAvaiableArrow(arg_170_0, arg_170_1, arg_170_2)
	if arg_170_0._avaiableArrow then
		return
	end

	local var_170_0 = lc.createSprite("img_arrow_up_2")

	var_170_0:setColor(var_0_0.COLOR_TEXT_ORANGE)
	lc.addChildToPos(arg_170_0, var_170_0, cc.p(arg_170_1, arg_170_2))

	local var_170_1 = 10

	var_170_0:runAction(lc.rep(lc.sequence(lc.moveBy(0.8, 0, var_170_1), lc.moveBy(0.8, 0, -var_170_1))))

	arg_170_0._avaiableArrow = var_170_0
end

function var_0_0.addDecoratedLabel(arg_171_0, arg_171_1, arg_171_2, arg_171_3, arg_171_4)
	local var_171_0 = lc.createSprite({
		_name = "img_blank",
		_crect = cc.rect(1, 1, 1, 1),
		_size = cc.size(lc.w(arg_171_0) - arg_171_3 * 2, 36)
	})

	lc.addChildToPos(arg_171_0, var_171_0, arg_171_2, arg_171_4)

	local var_171_1 = cc.Label:createWithTTF(arg_171_1, var_0_0.TTF_FONT, var_0_0.FontSize.M1)

	var_171_1:setColor(var_0_0.COLOR_TEXT_ORANGE)

	local var_171_2 = var_171_1:getContentSize()

	lc.addChildToPos(var_171_0, var_171_1, cc.p(lc.w(var_171_1) / 2 + 12, lc.h(var_171_1) / 2 + 4))

	return var_171_1
end

function var_0_0.addIconValue(arg_172_0, arg_172_1, arg_172_2, arg_172_3, arg_172_4, arg_172_5, arg_172_6)
	local var_172_0 = lc.createSprite(arg_172_1)

	lc.addChildToPos(arg_172_0, var_172_0, cc.p(arg_172_3, arg_172_4))

	local var_172_1 = var_0_0.createTTF(tostring(arg_172_2), var_0_0.FontSize.S1)

	var_172_1:setAnchorPoint(arg_172_5 and 1 or 0, 0.5)

	if arg_172_6 then
		var_172_1:setColor(arg_172_6)
	end

	if arg_172_5 then
		lc.addChildToPos(arg_172_0, var_172_1, cc.p(lc.x(var_172_0) - 30, arg_172_4))
	else
		lc.addChildToPos(arg_172_0, var_172_1, cc.p(lc.x(var_172_0) + 30, arg_172_4))
	end

	return var_172_1, var_172_0
end

function var_0_0.addLockChains(arg_173_0, arg_173_1)
	local function var_173_0(arg_174_0)
		local var_174_0 = 14
		local var_174_1 = lc.createSprite("img_chain")

		var_174_1:setScale(arg_173_1)
		var_174_1:setFlippedX(arg_174_0)
		var_174_1:setRotation(arg_174_0 and var_174_0 or -var_174_0)

		return var_174_1
	end

	local var_173_1 = var_173_0(false)

	lc.addChildToPos(arg_173_0, var_173_1, cc.p(lc.w(arg_173_0) / 2 + 5 * arg_173_1, lc.h(arg_173_0) / 2 - 20 * arg_173_1))

	local var_173_2 = var_173_0(true)

	lc.addChildToPos(arg_173_0, var_173_2, cc.p(lc.w(arg_173_0) / 2 - 5 * arg_173_1, lc.y(var_173_1)))

	local var_173_3 = lc.createSprite("img_lock")

	var_173_3:setScale(arg_173_1)
	lc.addChildToPos(arg_173_0, var_173_3, cc.p(lc.w(arg_173_0) / 2, lc.h(arg_173_0) / 2 - 50 * arg_173_1))
end

function var_0_0.addUnionContribution(arg_175_0, arg_175_1, arg_175_2, arg_175_3, arg_175_4, arg_175_5, arg_175_6)
	local var_175_0 = var_0_0.createTTF(arg_175_1 .. ": ", arg_175_2, var_0_0.COLOR_LABEL_DARK)

	var_175_0:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_175_0, var_175_0, cc.p(arg_175_3, arg_175_4))

	local var_175_1 = var_0_0.addIconValue(arg_175_0, "img_icon_res13_s", arg_175_5 or 0, lc.right(var_175_0) + 16, lc.y(var_175_0))

	var_175_1:setColor(var_0_0.COLOR_TEXT_DARK)

	return var_175_1
end

function var_0_0.addUnionPersonalPowerBar(arg_176_0, arg_176_1, arg_176_2, arg_176_3, arg_176_4)
	local var_176_0 = lc.createSprite("img_icon_res" .. arg_176_1 .. "_s")

	lc.addChildToPos(arg_176_0, var_176_0, cc.p(arg_176_2, arg_176_3))
	var_176_0:setAnchorPoint(0.5, 1)

	local var_176_1 = ClientView.createProgressBar(arg_176_4)

	var_176_1:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_176_0, var_176_1, cc.p(lc.right(var_176_0) + 10, arg_176_3 - lc.ch(var_176_0)))

	local var_176_2 = var_0_0.createBMFont(ClientView.BMFont.huali_20, "")

	lc.addChildToPos(var_176_1, var_176_2, cc.p(lc.cw(var_176_1) - lc.cw(var_176_2), lc.ch(var_176_1) + 2))

	var_176_1._label = var_176_2

	function var_176_1.update(arg_177_0, arg_177_1)
		var_176_1._bar:setPercent(100 * arg_177_0 / arg_177_1)
		var_176_2:setString(arg_177_0 .. "/" .. arg_177_1)
	end

	var_176_1.update(1, 100)

	return var_176_1
end

function var_0_0.createBoxProgressBar(arg_178_0, arg_178_1, arg_178_2, arg_178_3)
	local var_178_0 = 12

	arg_178_3 = arg_178_3 or 0

	local var_178_1 = lc.createSprite({
		_name = "img_progress_bg2",
		_crect = var_0_0.CRECT_PROGRESS_BG2,
		_size = cc.size(arg_178_1, var_178_0)
	})
	local var_178_2 = ccui.LoadingBar:create()

	var_178_2:loadTexture("img_progress_fg2", ccui.TextureResType.plistType)
	var_178_2:setDirection(ccui.LoadingBarDirection.LEFT)
	var_178_2:setPosition(arg_178_1 / 2, var_178_0 / 2)
	var_178_2:setScale9Enabled(true)
	var_178_2:setCapInsets(var_0_0.CRECT_PROGRESS_FG)
	var_178_2:setContentSize(arg_178_1 - 6, var_0_0.CRECT_PROGRESS_FG.height)
	var_178_2:setColor(barColor or lc.Color3B.yellow)
	lc.addChildToPos(var_178_1, var_178_2, cc.p(lc.cw(var_178_1) - 3, lc.ch(var_178_1) + 8))
	var_178_2:setPercent(0)

	var_178_1._bar = var_178_2

	local var_178_3 = arg_178_0[#arg_178_0]._val
	local var_178_4 = math.max(0, 5 - #arg_178_0)
	local var_178_5 = {
		"mubaoxiang",
		"tongbaoxiang",
		"yinbaoxiang",
		"jinbaoxiang",
		"heizuanbaoxiang"
	}
	local var_178_6 = {}

	for iter_178_0, iter_178_1 in ipairs(arg_178_0) do
		local var_178_7 = iter_178_1._val
		local var_178_8 = (arg_178_1 - 10) * (var_178_7 - arg_178_3) / (var_178_3 - arg_178_3) + 3
		local var_178_9 = iter_178_1._claimed
		local var_178_10 = lc.createSprite(iter_178_1._darkSpr)

		lc.addChildToPos(var_178_2, var_178_10, cc.p(var_178_8, var_178_0 / 2))

		local var_178_11 = ClientView.createTTF(var_178_7, ClientView.FontSize.S3, ClientView.COLOR_TEXT_WHITE)

		lc.addChildToPos(var_178_1, var_178_11, cc.p(var_178_8, -lc.ch(var_178_11)))

		local var_178_12 = DragonBones.create(var_178_5[iter_178_0 + var_178_4])

		var_178_12._claimed = var_178_9

		var_178_12:setScale(0.35)
		var_178_12:gotoAndPlay("effect4")

		local var_178_13 = ClientView.createShaderButton(nil, function(arg_179_0)
			if arg_178_2 then
				arg_178_2(arg_179_0)
			end
		end)

		var_178_13:setContentSize(cc.size(60, 60))
		lc.addChildToCenter(var_178_13, var_178_12)

		var_178_13._bones = var_178_12
		var_178_13._index = iter_178_0

		lc.addChildToPos(var_178_1, var_178_13, cc.p(var_178_8, 65))

		local var_178_14 = {
			_val = var_178_7,
			_spr = var_178_10,
			_bones = var_178_12
		}

		table.insert(var_178_6, var_178_14)
	end

	function var_178_1.update(arg_180_0)
		local var_180_0 = 100 * math.max(0, arg_180_0 - arg_178_3) / (var_178_3 - arg_178_3)

		var_178_2:setPercent(var_180_0)

		for iter_180_0, iter_180_1 in ipairs(var_178_6) do
			iter_180_1._spr:setSpriteFrame(arg_180_0 >= iter_180_1._val and "light_point" or "dark_point")

			if arg_180_0 < iter_180_1._val then
				iter_180_1._bones:gotoAndPlay("effect4")
			elseif iter_180_1._bones._claimed then
				iter_180_1._bones:gotoAndPlay("effect5")
			else
				iter_180_1._bones:gotoAndPlay("effect2")
			end
		end
	end

	return var_178_1
end

function var_0_0.createClashChestProgressBar(arg_181_0)
	local var_181_0 = cc.ProgressTimer:create(lc.createSpriteWithMask("res/jpg/daily_target_progress.jpg"))

	var_181_0:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	var_181_0:setPercentage(0)

	local function var_181_1(arg_182_0)
		return P._playerFindClash:getChestGrade(arg_182_0), arg_182_0, Data.CardQuality.UR
	end

	local var_181_2 = #arg_181_0
	local var_181_3 = 2 * math.pi / var_181_2
	local var_181_4 = lc.cw(var_181_0)
	local var_181_5 = {}

	for iter_181_0, iter_181_1 in ipairs(arg_181_0) do
		local var_181_6 = {}
		local var_181_7 = iter_181_0

		var_181_6._val = var_181_7

		local var_181_8 = (var_181_4 - 10) * math.sin((var_181_7 - 0) * var_181_3) + var_181_4
		local var_181_9 = (var_181_4 - 10) * math.cos((var_181_7 - 0) * var_181_3) + var_181_4
		local var_181_10 = (var_181_4 - 50) * math.sin((var_181_7 - 0.5) * var_181_3) + var_181_4
		local var_181_11 = (var_181_4 - 50) * math.cos((var_181_7 - 0.5) * var_181_3) + var_181_4
		local var_181_12 = (var_181_4 + 120) * math.sin((var_181_7 - 0.5) * var_181_3) + var_181_4
		local var_181_13 = (var_181_4 + 120) * math.cos((var_181_7 - 0.5) * var_181_3) + var_181_4
		local var_181_14 = lc.createSprite(iter_181_1._darkSpr)

		var_181_14:setRotation(var_181_7 * var_181_3 * 360 / (2 * math.pi))

		var_181_6._spr = var_181_14

		lc.addChildToPos(var_181_0, var_181_14, cc.p(var_181_8, var_181_9))

		local var_181_15 = ClientView.createTTF(string.format(Str(STR.WIN_CONTINOUS), var_181_7), ClientView.FontSize.S3, ClientView.COLOR_TEXT_WHITE)

		lc.addChildToPos(var_181_0, var_181_15, cc.p(var_181_10, var_181_11))

		var_181_6._numLabel = var_181_15

		table.insert(var_181_5, var_181_6)
	end

	function var_181_0.update(arg_183_0)
		local var_183_0 = 100 * arg_183_0 / var_181_2

		var_181_0:setPercentage(var_183_0)

		for iter_183_0, iter_183_1 in ipairs(var_181_5) do
			iter_183_1._spr:setSpriteFrame(arg_183_0 >= iter_183_1._val and arg_181_0[iter_183_0]._lightSpr or arg_181_0[iter_183_0]._darkSpr)
			iter_183_1._numLabel:setColor(arg_183_0 >= iter_183_1._val and ClientView.COLOR_TEXT_INGOT or ClientView.COLOR_TEXT_WHITE)
		end
	end

	function var_181_0.updateWithAni()
		var_181_0:stopAllActions()

		local var_184_0 = #P._playerFindClash._chests
		local var_184_1 = var_181_0:getPercentage() / 100 * var_181_2
		local var_184_2 = 60
		local var_184_3 = (var_184_0 - var_184_1) / var_184_2
		local var_184_4 = 1

		var_181_0:runAction(lc.ease(lc.sequence(lc.rep(lc.sequence(function()
			var_181_0.update(var_181_0:getPercentage() * var_181_2 / 100 + var_184_3)
		end, var_184_4 / var_184_2), var_184_2), function()
			var_181_0.update(var_184_0)
		end), "SineIO"))
	end

	return var_181_0
end

function var_0_0.createClashSeasonProgressBar(arg_187_0)
	local var_187_0 = cc.ProgressTimer:create(lc.createSpriteWithMask("res/jpg/daily_target_progress.jpg"))

	var_187_0:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	var_187_0:setPercentage(0)

	local function var_187_1(arg_188_0)
		return P._playerFindClash:getChestGrade(arg_188_0), arg_188_0, Data.CardQuality.UR
	end

	local var_187_2 = arg_187_0[1]._val
	local var_187_3 = #arg_187_0
	local var_187_4 = arg_187_0[#arg_187_0]._val
	local var_187_5 = 2 * math.pi * (var_187_3 - 1) / var_187_3 / (var_187_4 - var_187_2)
	local var_187_6 = lc.cw(var_187_0)
	local var_187_7 = {}

	for iter_187_0, iter_187_1 in ipairs(arg_187_0) do
		local var_187_8 = {}
		local var_187_9 = iter_187_1._val

		var_187_8._val = var_187_9

		local var_187_10 = (var_187_6 - 10) * math.sin((var_187_9 - var_187_2) * var_187_5) + var_187_6
		local var_187_11 = (var_187_6 - 10) * math.cos((var_187_9 - var_187_2) * var_187_5) + var_187_6
		local var_187_12 = (var_187_6 - 60) * math.sin((var_187_9 - var_187_2) * var_187_5) + var_187_6
		local var_187_13 = (var_187_6 - 60) * math.cos((var_187_9 - var_187_2) * var_187_5) + var_187_6
		local var_187_14 = (var_187_6 + 120) * math.sin((var_187_9 - var_187_2) * var_187_5) + var_187_6
		local var_187_15 = (var_187_6 + 120) * math.cos((var_187_9 - var_187_2) * var_187_5) + var_187_6
		local var_187_16 = lc.createSprite(iter_187_1._darkSpr)

		var_187_16:setRotation((var_187_9 - var_187_2) * var_187_5 * 360 / (2 * math.pi))

		var_187_8._spr = var_187_16

		lc.addChildToPos(var_187_0, var_187_16, cc.p(var_187_10, var_187_11))

		local var_187_17 = lc.createNode()
		local var_187_18 = ClientView.createTTF(var_187_9, ClientView.FontSize.S3, ClientView.COLOR_TEXT_WHITE)
		local var_187_19 = lc.createSprite(string.format("img_icon_res%d_s", Data.ResType.clash_trophy))

		var_187_19:setScale(0.6)
		lc.addNodesToCenter(var_187_17, {
			var_187_19,
			var_187_18
		}, 0)
		lc.addChildToPos(var_187_0, var_187_17, cc.p(var_187_12, var_187_13))

		var_187_8._numLabel = var_187_18

		table.insert(var_187_7, var_187_8)
	end

	function var_187_0.update(arg_189_0)
		arg_189_0 = math.min(arg_189_0, var_187_4)

		local var_189_0 = 100 * (var_187_3 - 1) / var_187_3 * (arg_189_0 - var_187_2) / (var_187_4 - var_187_2)

		var_187_0:setPercentage(var_189_0)

		for iter_189_0, iter_189_1 in ipairs(var_187_7) do
			iter_189_1._spr:setSpriteFrame(arg_189_0 >= iter_189_1._val and arg_187_0[iter_189_0]._lightSpr or arg_187_0[iter_189_0]._darkSpr)
			iter_189_1._numLabel:setColor(arg_189_0 >= iter_189_1._val and ClientView.COLOR_TEXT_INGOT or ClientView.COLOR_TEXT_WHITE)
		end
	end

	function var_187_0.updateWithAni(arg_190_0)
		var_187_0:stopAllActions()

		arg_190_0 = math.min(arg_190_0, var_187_4)

		local var_190_0 = var_187_0:getPercentage() / 100 * (var_187_4 - var_187_2) * var_187_3 / (var_187_3 - 1) + var_187_2
		local var_190_1 = 60
		local var_190_2 = (arg_190_0 - var_190_0) / var_190_1
		local var_190_3 = 1

		var_187_0:runAction(lc.ease(lc.sequence(lc.rep(lc.sequence(function()
			local var_191_0 = var_187_0:getPercentage() / 100

			var_187_0.update(var_191_0 * (var_187_4 - var_187_2) * var_187_3 / (var_187_3 - 1) + var_187_2 + var_190_2)
		end, var_190_3 / var_190_1), var_190_1), function()
			var_187_0.update(arg_190_0)
		end), "SineIO"))
	end

	return var_187_0
end

function var_0_0.createTrophyProgressBar(arg_193_0, initTrophy)
	local var_193_0 = P._playerFindClash
	local var_193_1 = ClientView.createProgressBar(arg_193_0 - 100)
	local var_193_2 = lc.createSprite("img_icon_res6_s")

	var_193_2:setScale(0.8)
	lc.addChildToPos(var_193_1, var_193_2, cc.p(70, lc.ch(var_193_1)))

	local var_193_3 = ClientView.createBMFont(ClientView.BMFont.huali_20, "0/0", cc.TEXT_ALIGNMENT_LEFT)

	lc.addChildToPos(var_193_1, var_193_3, cc.p(150, lc.ch(var_193_1)))
	var_193_1._label = var_193_3

	function var_193_1.update(customTrophy)
		if var_193_1._curBone then
			var_193_1._curBone:removeFromParent()
			var_193_1._curBone = nil
		end

		if var_193_1._nextBone then
			var_193_1._nextBone:removeFromParent()
			var_193_1._nextBone = nil
		end

		local trophyVal = customTrophy or initTrophy or (var_193_0 and var_193_0._trophy) or (P and P._trophy) or 0
		if trophyVal < 0 then trophyVal = 0 end
		local var_194_0 = (var_193_0 and var_193_0.getGrade and var_193_0:getGrade(trophyVal)) or 1
		local var_194_1 = Data._ladderInfo[var_194_0]._trophy
		local var_194_2

		if var_194_0 >= Data.FindClashGrade.legend then
			var_194_2 = Data._ladderInfo[Data.FindClashGrade.legend]._trophy
		else
			var_194_2 = Data._ladderInfo[var_194_0 + 1]._trophy
		end

		local var_194_3 = (var_194_2 > 0) and (trophyVal / var_194_2 * 100) or 100
		local var_194_4 = math.max(0, math.min(var_194_3, 100))

		var_193_1._bar:setPercent(var_194_4)
		var_193_3:setString(tostring(trophyVal) .. "/" .. tostring(var_194_2))

		local var_194_5 = ClientView.createTrophyGradeDB(var_194_0)

		var_194_5:setScale(0.5)
		lc.addChildToPos(var_193_1, var_194_5, cc.p(-25, lc.ch(var_193_1)))

		var_193_1._curBone = var_194_5

		if var_194_0 < Data.FindClashGrade.legend then
			local var_194_6 = ClientView.createTrophyGradeDB(var_194_0 + 1)

			var_194_6:setScale(0.5)
			lc.addChildToPos(var_193_1, var_194_6, cc.p(lc.w(var_193_1) + 25, lc.ch(var_193_1)))

			var_193_1._nextBone = var_194_6
		end
	end

	var_193_1.update(initTrophy)

	return var_193_1
end

function var_0_0.createTrophyGradeDB(arg_195_0)
	local var_195_0 = DragonBones.create(ClientView.trophyGradeBones[arg_195_0])

	var_195_0:gotoAndPlay("effect")

	return var_195_0
end

function var_0_0.addLongPressDescPanel(arg_196_0, arg_196_1, arg_196_2)
	arg_196_0:setTouchEnabled(true)
	arg_196_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	arg_196_0:addTouchEventListener(function(arg_197_0, arg_197_1, arg_197_2)
		if arg_197_1 == ccui.TouchEventType.began then
			local var_197_0 = require("TopMostPanel").DescPanel.create(arg_196_1)

			if var_197_0 then
				var_197_0:setPosition(arg_196_2(var_197_0))
				var_197_0:show()
			end
		elseif arg_197_1 == ccui.TouchEventType.moved then
			if cc.pGetDistance(arg_197_2:getLocation(), arg_197_2:getStartLocation()) > lc.Gesture.BUDGE_LIMIT then
				BasePanel.hideTopMost()
			end
		elseif arg_197_1 == ccui.TouchEventType.ended or arg_197_1 == ccui.TouchEventType.canceled then
			BasePanel.hideTopMost()
		end
	end)
end

function var_0_0.checkNewFlag(arg_198_0, arg_198_1, arg_198_2, arg_198_3, arg_198_4)
	if type(arg_198_1) == "boolean" and arg_198_1 or type(arg_198_1) == "number" and arg_198_1 > (arg_198_4 or 0) then
		if arg_198_0._newFlag == nil then
			local var_198_0 = lc.createSprite("img_new")

			var_198_0:setPosition(lc.w(arg_198_0) - 40 + (arg_198_2 or 0), lc.h(arg_198_0) - 10 + (arg_198_3 or 0))
			arg_198_0:addChild(var_198_0)

			if type(arg_198_1) == "number" then
				var_198_0._value = var_0_0.createBMFont(var_0_0.BMFont.huali_20, "00")

				var_198_0._value:setScale(0.8)
				lc.addChildToPos(var_198_0, var_198_0._value, cc.p(lc.w(var_198_0) / 2, lc.h(var_198_0) / 2 + 2))
			else
				var_198_0:setScale(0.9)
			end

			var_198_0:setCameraMask(arg_198_0:getCameraMask())

			arg_198_0._newFlag = var_198_0
		end

		if arg_198_0._newFlag._value and type(arg_198_1) == "number" then
			arg_198_0._newFlag._value:setString(string.format("%d", arg_198_1))
		end
	elseif arg_198_0._newFlag then
		arg_198_0._newFlag:removeFromParent()

		arg_198_0._newFlag = nil
	end

	return arg_198_0._newFlag
end

function var_0_0.checkDiscountFlag(arg_199_0, arg_199_1, arg_199_2, arg_199_3)
	local var_199_0 = Data._globalInfo._unionShopDiscount

	if lc._runningScene._sceneId == ClientData.SceneId.tavern then
		var_199_0 = Data._globalInfo._magicShopDiscount
	end

	local var_199_1 = ""

	if arg_199_1 > 0 and arg_199_1 <= #var_199_0 then
		var_199_1 = var_199_0[arg_199_1] / 10
	end

	if var_199_1 == "" then
		return nil
	end

	if arg_199_0._discountFlag == nil and var_199_1 ~= "" then
		local var_199_2 = lc.createSprite("discount_bg")

		var_199_2:setPosition(lc.w(arg_199_0) - 40 + (arg_199_2 or 0), lc.h(arg_199_0) - 10 + (arg_199_3 or 0))
		var_199_2:setScale(0.8)
		arg_199_0:addChild(var_199_2)

		var_199_2._value = var_0_0.createTTF("", ClientView.FontSize.B2)

		lc.addChildToPos(var_199_2, var_199_2._value, cc.p(lc.w(var_199_2) / 2 - 6, lc.h(var_199_2) / 2 + 2))
		var_199_2:setCameraMask(arg_199_0:getCameraMask())

		arg_199_0._discountFlag = var_199_2
	end

	if arg_199_0._discountFlag._value then
		arg_199_0._discountFlag._value:setString(var_199_1)
		arg_199_0._discountFlag._value:setColor(lc.Color3B.yellow)
	end

	return arg_199_0._discountFlag
end

function var_0_0.checkIngot(arg_200_0)
	if not P:hasResource(Data.ResType.ingot, arg_200_0) then
		if ClientData.isHideCharge() then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._resInfo[Data.ResType.ingot]._nameSid)))
		else
			require("PromptForm").ConfirmBuyIngot.create():show()
		end

		return false
	end

	return true
end

function var_0_0.checkGold(arg_201_0)
	if not P:hasResource(Data.ResType.gold, arg_201_0) then
		ToastManager.push(Str(STR.NOT_ENOUGH_GOLD))
		require("ExchangeResForm").create(Data.ResType.gold):show()

		return false
	end

	return true
end

function var_0_0.getWorldDisplayName(arg_202_0)
	if arg_202_0 == Data.WorldDisplay.map then
		return Str(STR.WORLD_DISPLAY_MAP)
	else
		return Str(STR.STORY_LINE + arg_202_0 - 1)
	end
end

function var_0_0.useSweepCard(arg_203_0, arg_203_1, arg_203_2)
	local var_203_0 = arg_203_0

	if not P._propBag:hasProps(Data.PropsId.sweep_card, var_203_0) then
		if arg_203_1 then
			require("PromptForm").ConfirmSweep.create(var_203_0, arg_203_2):show()

			return false
		else
			var_203_0 = P._propBag._props[Data.PropsId.sweep_card]._num

			local var_203_1 = (arg_203_0 - var_203_0) * 2

			P:changeResource(Data.ResType.ingot, -var_203_1)
		end
	end

	P._propBag:changeProps(Data.PropsId.sweep_card, -var_203_0)

	return true
end

function var_0_0.getSkillDisplayInfo(arg_204_0, arg_204_1)
	local var_204_0 = type(arg_204_0) == "table" and arg_204_0 or Data._skillInfo[arg_204_0]
	local var_204_1 = string.format("img_icon_skill_%d", Data.getSkillType(var_204_0._id))
	local var_204_2 = var_0_0.getSkillName(var_204_0, arg_204_1 or 1)
	local var_204_3 = ClientData.getSkillDesc(var_204_0._id, arg_204_1 or 1)

	return var_204_1, var_204_2, var_204_3
end

function var_0_0.getSkillName(arg_205_0, arg_205_1)
	local var_205_0 = type(arg_205_0) == "number" and Data._skillInfo[arg_205_0] or arg_205_0

	return (Str(var_205_0._nameSid))
end

function var_0_0.getCardQualityStrColor(arg_206_0, arg_206_1)
	if var_0_0.QUALITY_COLOR == nil then
		var_0_0.QUALITY_COLOR = {
			[Data.CardQuality.HR] = var_0_0.COLOR_TEXT_LIGHT,
			[Data.CardQuality.GR] = var_0_0.COLOR_TEXT_LIGHT,
			[Data.CardQuality.UR] = var_0_0.COLOR_TEXT_LIGHT,
			[Data.CardQuality.SR] = var_0_0.COLOR_TEXT_LIGHT,
			[Data.CardQuality.R] = var_0_0.COLOR_TEXT_LIGHT,
			[Data.CardQuality.N] = var_0_0.COLOR_TEXT_LIGHT
		}
	end

	if arg_206_1 and var_0_0.QUALITY_COLOR_DARK == nil then
		var_0_0.QUALITY_COLOR_DARK = {
			[Data.CardQuality.HR] = var_0_0.COLOR_TEXT_DARK,
			[Data.CardQuality.GR] = var_0_0.COLOR_TEXT_DARK,
			[Data.CardQuality.UR] = var_0_0.COLOR_TEXT_DARK,
			[Data.CardQuality.SR] = var_0_0.COLOR_TEXT_DARK,
			[Data.CardQuality.R] = var_0_0.COLOR_TEXT_DARK,
			[Data.CardQuality.N] = var_0_0.COLOR_TEXT_DARK
		}
	end

	if var_0_0.QUALITY_STR == nil then
		var_0_0.QUALITY_STR = {
			[Data.CardQuality.HR] = "HR",
			[Data.CardQuality.GR] = "GR",
			[Data.CardQuality.UR] = "UR",
			[Data.CardQuality.SR] = "SR",
			[Data.CardQuality.R] = "R",
			[Data.CardQuality.N] = "N"
		}
	end

	if arg_206_0 then
		return var_0_0.QUALITY_STR[arg_206_0], arg_206_1 and var_0_0.QUALITY_COLOR_DARK[arg_206_0] or var_0_0.QUALITY_COLOR[arg_206_0]
	else
		return var_0_0.QUALITY_STR, arg_206_1 and var_0_0.QUALITY_COLOR_DARK or var_0_0.QUALITY_COLOR
	end
end

function var_0_0.getMenuUI()
	if var_0_0.MenuUI == nil then
		var_0_0.MenuUI = require("MenuPanel").create()

		var_0_0.MenuUI:retain()
	end

	return var_0_0.MenuUI
end

function var_0_0.releaseMenuUI(arg_208_0)
	if var_0_0.MenuUI ~= nil then
		var_0_0.MenuUI:onRelease()
		var_0_0.MenuUI:release()

		var_0_0.MenuUI = nil
	end
end

function var_0_0.removeMenuFromParent()
	if var_0_0.MenuUI ~= nil then
		var_0_0.MenuUI:removeFromParent(false)
	end
end

function var_0_0.getResourceUI()
	if var_0_0.ResourceUI == nil then
		var_0_0.ResourceUI = require("ResourcePanel").create()

		var_0_0.ResourceUI:retain()
	end

	return var_0_0.ResourceUI
end

function var_0_0.releaseResourceUI()
	if var_0_0.ResourceUI ~= nil then
		var_0_0.ResourceUI:onRelease()
		var_0_0.ResourceUI:release()

		var_0_0.ResourceUI = nil
	end
end

function var_0_0.removeResourceFromParent()
	if var_0_0.ResourceUI ~= nil then
		var_0_0.ResourceUI:removeFromParent(false)
	end
end

function var_0_0.getChatPanel()
	if var_0_0.ChatPanel == nil then
		var_0_0.ChatPanel = require("ChatPanel").create()

		var_0_0.ChatPanel:retain()
	end

	return var_0_0.ChatPanel
end

function var_0_0.releaseChatPanel()
	if var_0_0.ChatPanel ~= nil then
		var_0_0.ChatPanel:onRelease()
		var_0_0.ChatPanel:release()

		var_0_0.ChatPanel = nil
	end
end

function var_0_0.removeChatPanelFromParent()
	if var_0_0.ChatPanel ~= nil then
		var_0_0.ChatPanel:removeFromParent(false)
	end
end

function var_0_0.getActiveIndicator()
	if var_0_0.ActiveIndicator == nil then
		var_0_0.ActiveIndicator = require("ActiveIndicator").create()

		var_0_0.ActiveIndicator:retain()
	end

	return var_0_0.ActiveIndicator
end

function var_0_0.releaseActiveIndicator()
	if var_0_0.ActiveIndicator ~= nil then
		var_0_0.ActiveIndicator:removeAllChildren()
		var_0_0.ActiveIndicator:release()

		var_0_0.ActiveIndicator = nil
	end
end

function var_0_0.getEnvelopePanel(...)
	if var_0_0.EnvelopePanel == nil then
		var_0_0.EnvelopePanel = require("EnvelopePanel").create(...)

		var_0_0.EnvelopePanel:retain()
	end

	return var_0_0.EnvelopePanel
end

function var_0_0.releaseEnvelopePanel(arg_219_0)
	if var_0_0.EnvelopePanel ~= nil then
		var_0_0.EnvelopePanel:removeFromParent()
		var_0_0.EnvelopePanel:release()

		var_0_0.EnvelopePanel = nil
	end
end

function var_0_0.showClaimBonusResult(arg_220_0, arg_220_1)
	if arg_220_1 == Data.ErrorType.ok then
		local var_220_0 = require("RewardPanel")

		var_220_0.create(arg_220_0, var_220_0.MODE_CLAIM):show()
		lc.Audio.playAudio(AUDIO.E_CLAIM)
	elseif arg_220_1 == Data.ErrorType.claimed then
		ToastManager.push(Str(STR.CLAIMED) .. Str(STR.BONUS))
	elseif arg_220_1 == Data.ErrorType.claim_not_support then
		ToastManager.push(Str(STR.CANNOT_CLAIM) .. Str(STR.BONUS))
	end
end

function var_0_0.showOperateTopMostPanel(arg_221_0, arg_221_1, arg_221_2)
	local var_221_0 = require("TopMostPanel").ButtonList.create(cc.size(200, 600), arg_221_0)

	if var_221_0 then
		local var_221_1 = lc.convertPos(cc.p(lc.w(arg_221_2) / 2, lc.h(arg_221_2) / 2), arg_221_2)

		var_221_0:setButtonDefs(arg_221_1)
		var_221_0:linkNode(arg_221_2)

		local var_221_2 = lc.h(var_221_0) / 2

		if var_221_1.y - var_221_2 < 0 then
			var_221_1.y = var_221_2
		elseif var_221_1.y + var_221_2 > ClientView.SCR_H then
			var_221_1.y = ClientView.SCR_H - var_221_2
		end

		var_221_0:setPosition(var_221_1.x, var_221_1.y)
		var_221_0:show()
	end

	return var_221_0
end

function var_0_0.operateMember(arg_222_0, arg_222_1)
	if arg_222_0._unionId == 0 then
		return
	end

	if arg_222_0._id == P._id then
		return
	end

	local var_222_0 = P._playerUnion
	local var_222_1 = {}

	table.insert(var_222_1, {
		_str = Str(STR.INFO),
		_handler = function()
			var_0_0.visitUser(arg_222_0)
		end
	})

	if not ClientData.getValidActivityByType(Data.ActivityType.sensitive_day) then
		table.insert(var_222_1, {
			_str = Str(STR.LEAVE_MESSAGE),
			_handler = function()
				var_0_0.mailUser(arg_222_0)
			end
		})
	end

	if arg_222_0._unionId == P._unionId then
		if var_222_0:canOperate(var_222_0.Operate.give_leader) == Data.ErrorType.ok then
			table.insert(var_222_1, {
				_str = Str(STR.UNION_GIVE_LEADER),
				_handler = function()
					require("Dialog").showDialog(Str(STR.UNION_GIVE_LEADER_TIP), function()
						ClientData.sendUnionGiveLeader(arg_222_0._id)
					end)
				end
			})
		end

		if var_222_0:canOperate(var_222_0.Operate.set_job) == Data.ErrorType.ok then
			if arg_222_0._unionJob == Data.UnionJob.rookie then
				table.insert(var_222_1, {
					_str = Str(STR.UNION_PROMOTE),
					_handler = function()
						ClientData.sendUnionPromote(arg_222_0._id)
					end
				})
			end

			if arg_222_0._unionJob == Data.UnionJob.elder then
				table.insert(var_222_1, {
					_str = Str(STR.UNION_DEMOTE),
					_handler = function()
						ClientData.sendUnionDemote(arg_222_0._id)
					end
				})
			end
		end

		if var_222_0:canOperate(var_222_0.Operate.fire_member) == Data.ErrorType.ok and P._unionJob > arg_222_0._unionJob then
			table.insert(var_222_1, {
				_str = Str(STR.UNION_FIRE_MEMBER),
				_handler = function()
					require("Dialog").showDialog(Str(STR.UNION_KICK_OUT_TIP), function()
						ClientData.sendUnionKickout(arg_222_0._id)
					end)
				end
			})
		end

		if #var_222_1 > 3 then
			table.insert(var_222_1, 4, {
				_isSeparator = true
			})
		elseif not ClientData.isAppStoreReviewing() then
			table.insert(var_222_1, {
				_isSeparator = true
			})
		end

		if arg_222_0._unionJob == Data.UnionJob.leader and var_222_0:canOperate(var_222_0.Operate.impeach) == Data.ErrorType.ok and (ClientData.getCurrentTime() - arg_222_0._lastLogin) / Data.DAY_SECONDS > 6 then
			table.insert(var_222_1, {
				_str = Str(STR.UNION_IMPEACH),
				_handler = function()
					var_0_0.impeachLeader(arg_222_0)
				end,
				_onButtonCreate = function(arg_232_0)
					arg_232_0:setDisplayFrame("img_btn_3")
				end
			})
		end

		if #P:getItemsToSend() > 0 then
			table.insert(var_222_1, {
				_isSeparator = true
			})
			table.insert(var_222_1, {
				_str = Str(STR.SEND_GIFT),
				_handler = function()
					require("GivePropForm").create(arg_222_0):show()
				end
			})
		end
	end

	var_0_0.showOperateTopMostPanel(arg_222_0._name, var_222_1, arg_222_1)
end

function var_0_0.operateGroupMember(arg_234_0)
	local var_234_0 = arg_234_0._groupId
	local var_234_1 = arg_234_0._member
	local var_234_2 = P._playerUnion

	if var_234_1._id == P._id or not var_234_2._groupId or not var_234_2._groupJob or var_234_2._groupId ~= var_234_0 then
		return
	end

	local var_234_3 = {}

	table.insert(var_234_3, {
		_str = Str(STR.INFO),
		_handler = function()
			var_0_0.visitUser(var_234_1)
		end
	})

	if not ClientData.getValidActivityByType(Data.ActivityType.sensitive_day) then
		table.insert(var_234_3, {
			_str = Str(STR.LEAVE_MESSAGE),
			_handler = function()
				var_0_0.mailUser(var_234_1)
			end
		})
	end

	if arg_234_0._canOperate and var_234_2._groupJob == Data.GroupJob.leader then
		table.insert(var_234_3, {
			_str = Str(STR.UNION_FIRE_MEMBER),
			_handler = function()
				require("Dialog").showDialog(Str(STR.GROUP_KICK_OUT_TIP), function()
					ClientData.sendGroupKick(var_234_0, var_234_1._id)
				end)
			end
		})
	end

	if #var_234_3 > 2 then
		table.insert(var_234_3, 3, {
			_isSeparator = true
		})
	elseif not ClientData.isAppStoreReviewing() then
		table.insert(var_234_3, {
			_isSeparator = true
		})
	end

	var_0_0.showOperateTopMostPanel(var_234_1._name, var_234_3, arg_234_0)
end

function var_0_0.operateUser(arg_239_0, arg_239_1, arg_239_2)
	if arg_239_0._id == P._id or arg_239_0._id == 0 then
		return
	end

	if not arg_239_2 and arg_239_0._regionId ~= ClientData._userRegion._id then
		return
	end

	local var_239_0 = {}

	table.insert(var_239_0, {
		_str = Str(STR.INFO),
		_handler = function()
			var_0_0.visitUser(arg_239_0)
		end
	})

	if not ClientData.getValidActivityByType(Data.ActivityType.sensitive_day) then
		table.insert(var_239_0, {
			_str = Str(STR.LEAVE_MESSAGE),
			_handler = function()
				var_0_0.mailUser(arg_239_0)
			end
		})
	end

	if arg_239_0._unionId == nil or arg_239_0._unionId == 0 then
		local var_239_1 = P._playerUnion

		if var_239_1:canOperate(var_239_1.Operate.invite_user) == Data.ErrorType.ok then
			local var_239_2 = var_239_1:getMyUnion()

			if arg_239_0._level >= var_239_2._reqLevel then
				table.insert(var_239_0, {
					_isSeparator = true
				})
				table.insert(var_239_0, {
					_str = Str(STR.UNION_INVITE),
					_handler = function()
						ToastManager.push(Str(STR.UNION_INVITE_SEND))
						ClientData.sendUnionInvite(arg_239_0._id, string.format(Str(STR.UNION_INVITE_MSG), P._unionName))
					end
				})
			end
		end
	elseif arg_239_0._unionId ~= P._unionId then
		table.insert(var_239_0, {
			_isSeparator = true
		})
		table.insert(var_239_0, {
			_str = Str(STR.UNION) .. Str(STR.DETAIL),
			_handler = function()
				require("UnionDetailForm").create(arg_239_0._unionId):show()
			end
		})
	end

	if #P:getItemsToSend() > 0 then
		table.insert(var_239_0, {
			_isSeparator = true
		})
		table.insert(var_239_0, {
			_str = Str(STR.SEND_GIFT),
			_handler = function()
				require("GivePropForm").create(arg_239_0):show()
			end
		})
	end

	if P:hasPrivilege(Data.Privilege.chat_ban) then
		table.insert(var_239_0, {
			_isSeparator = true
		})
		table.insert(var_239_0, {
			_str = Str(STR.CHAT_BAN),
			_handler = function()
				var_0_0.doPrivilege(Data.Privilege.chat_ban, arg_239_0)
			end,
			_onButtonCreate = function(arg_246_0)
				if P._chatBanList[arg_239_0._id] then
					arg_246_0:setEnabled(false)
				else
					arg_246_0:setDisplayFrame("img_btn_3")
				end
			end
		})
	end

	var_0_0.showOperateTopMostPanel(arg_239_0._name, var_239_0, arg_239_1)
end

function var_0_0.operateUnion(arg_247_0, arg_247_1)
	local var_247_0 = {}

	table.insert(var_247_0, {
		_str = Str(STR.UNION) .. Str(STR.DETAIL),
		_handler = function()
			require("UnionDetailForm").create(arg_247_0._id):show()
		end
	})

	if not P:hasUnion() and P:getMaxCharacterLevel() >= P._playerCity:getUnionUnlockLevel() and arg_247_0._joinType ~= Data.UnionJoinType.close then
		local var_247_1 = arg_247_0._joinType == Data.UnionJoinType.any
		local var_247_2 = var_247_1 and Str(STR.JOIN) or Str(STR.APPLY) .. Str(STR.JOIN)

		table.insert(var_247_0, {
			_str = var_247_2,
			_handler = function()
				if not var_247_1 then
					ToastManager.push(Str(STR.UNION_APPLY_SEND))
				end

				ClientData.sendUnionApply(arg_247_0._id, Str(STR.UNION_APPLY_MSG))
			end
		})
	end

	var_0_0.showOperateTopMostPanel(arg_247_0._name, var_247_0, arg_247_1)
end

function var_0_0.visitUser(arg_250_0)
	local targetId = (type(arg_250_0) == "table" and arg_250_0._id) or tonumber(arg_250_0)
	if targetId then
		require("VisitForm").create(targetId):show()
	end
end

function var_0_0.compareUser(arg_251_0)
	if arg_251_0._id == P._id then
		return
	end

	var_0_0.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.startFriendBattle(arg_251_0._id)

	local var_251_0 = cc.EventCustom:new(Data.Event.pk_join)

	lc.Dispatcher:dispatchEvent(var_251_0)
end

function var_0_0.mailUser(arg_252_0)
	if arg_252_0._id == P._id then
		return
	end

	if not P:hasPrivilege(Data.Privilege.mail_free) then
		if P:getMaxCharacterLevel() < Data._globalInfo._unlockSendMail then
			ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockSendMail))

			return
		end

		if Data._globalInfo._dailySendMailCount - P._dailySendMail <= 0 then
			ToastManager.push(Str(STR.DAILY_CANNOT_SEND_MAIL))

			return
		end
	end

	require("SendMailForm").create(arg_252_0):show()
end

function var_0_0.giveFund(arg_253_0)
	if arg_253_0._id == P._id then
		return
	end

	require("GiveFundForm").create(arg_253_0):show()
end

function var_0_0.impeachLeader(arg_254_0)
	require("ImpeachForm").create(arg_254_0):show()
end

function var_0_0.doPrivilege(arg_255_0, arg_255_1)
	if arg_255_0 == Data.Privilege.chat_ban then
		local var_255_0 = arg_255_1

		require("Dialog").showDialog(string.format(Str(STR.CONFIRM_CHAT_BAN), var_255_0._name), function()
			ClientData.sendChatBan(var_255_0._id)
		end)
	end
end

function var_0_0.createBadge(arg_257_0, arg_257_1)
	local var_257_0 = cc.Sprite:createWithSpriteFrameName(string.format("img_badge_%d", arg_257_0))
	local var_257_1 = cc.Sprite:createWithSpriteFrameName("img_badge_x3")
	local var_257_2 = cc.Sprite:createWithSpriteFrameName("img_badge_x3")

	var_257_2:setFlippedX(true)
	lc.addChildToPos(var_257_0, var_257_1, cc.p(4 - lc.w(var_257_1) / 2, lc.h(var_257_0) - lc.h(var_257_1) / 2), -1)
	lc.addChildToPos(var_257_0, var_257_2, cc.p(lc.w(var_257_0) + lc.w(var_257_2) / 2 - 6, lc.h(var_257_0) - lc.h(var_257_2) / 2), -1)

	if arg_257_1 then
		local var_257_3 = cc.Sprite:createWithSpriteFrameName("img_badge_word_bg")

		lc.addChildToPos(var_257_0, var_257_3, cc.p(lc.w(var_257_0) / 2, lc.h(var_257_0) / 2 + 26))

		local var_257_4 = cc.Label:createWithTTF(arg_257_1, var_0_0.TTF_FONT, var_0_0.FontSize.B1)

		var_257_4:setColor(lc.Color3B.yellow)
		lc.addChildToCenter(var_257_3, var_257_4)

		var_257_0._bg = var_257_3
		var_257_0._label = var_257_4
	end

	function var_257_0.update(arg_258_0, arg_258_1, arg_258_2)
		arg_258_0:setSpriteFrame(string.format("img_badge_%d", arg_258_1))

		if arg_258_0._label then
			arg_258_0._label:setString(arg_258_2)
		end
	end

	return var_257_0
end

function var_0_0.createGroupAvatar(arg_259_0)
	arg_259_0 = arg_259_0 or 1

	local var_259_0 = cc.Sprite:createWithSpriteFrameName(string.format("img_group_avatar_%d", arg_259_0))

	function var_259_0.update(arg_260_0)
		var_259_0:setSpriteFrame(string.format("img_group_avatar_%d", arg_260_0))
	end

	return var_259_0
end

function var_0_0.createWavingBadge(arg_261_0, arg_261_1)
	local var_261_0 = 13
	local var_261_1 = 2
	local var_261_2 = 32
	local var_261_3 = 12
	local var_261_4 = 4
	local var_261_5 = 50
	local var_261_6 = 1 / (var_261_0 - 1)
	local var_261_7 = 1 / (var_261_1 - 1)

	if var_0_0.WAVING_BADGE_SIN_VALUES == nil then
		var_0_0.WAVING_BADGE_SIN_VALUES = {}

		for iter_261_0 = 0, var_261_2 * 2 do
			table.insert(var_0_0.WAVING_BADGE_SIN_VALUES, math.sin(3.14 * iter_261_0 / var_261_2))
		end
	end

	local var_261_8 = cc.Sprite:createWithSpriteFrameName(string.format("img_badge_%d", arg_261_0))
	local var_261_9 = var_261_8:getContentSize()

	var_261_8:setPosition(var_261_9.width / 2, var_261_9.height / 2)

	local var_261_10 = cc.Sprite:createWithSpriteFrameName("img_badge_word_bg")

	var_261_10:setPosition(var_261_9.width / 2, var_261_9.height / 2 + 20)

	local var_261_11 = cc.Label:createWithTTF(arg_261_1, var_0_0.TTF_FONT, var_0_0.FontSize.B1)

	var_261_11:setColor(lc.Color3B.yellow)
	lc.addChildToCenter(var_261_10, var_261_11)

	local var_261_12 = cc.RenderTexture:create(var_261_9.width, var_261_9.height)

	var_261_12:begin()
	var_261_8:visit()
	var_261_10:visit()
	var_261_12:endToLua()

	local var_261_13 = cc.MeshSprite:create(var_261_0, var_261_1, var_261_12:getSprite():getTexture())

	for iter_261_1 = 0, var_261_0 - 1 do
		for iter_261_2 = 0, var_261_1 - 1 do
			var_261_13:setTexCoord(iter_261_1, iter_261_2, cc.p(var_261_7 * iter_261_2, var_261_6 * (var_261_0 - 1 - iter_261_1)))
		end
	end

	function var_261_13.startWave(arg_262_0)
		if arg_262_0._schedulerID ~= nil then
			return
		end

		arg_262_0._waveIndex = 0
		arg_262_0._targetOffsetX = math.random(var_261_4, var_261_3)

		arg_262_0:wave()

		arg_262_0._schedulerID = lc.Scheduler:scheduleScriptFunc(function(arg_263_0)
			arg_262_0:wave()
		end, 0.1, false)
	end

	function var_261_13.stopWave(arg_264_0)
		if arg_264_0._schedulerID ~= nil then
			lc.Scheduler:unscheduleScriptEntry(arg_264_0._schedulerID)

			arg_264_0._schedulerID = nil
		end
	end

	function var_261_13.wave(arg_265_0)
		arg_265_0._waveIndex = (arg_265_0._waveIndex + 1) % var_261_2

		if arg_265_0._waveIndex == 0 then
			arg_265_0._targetOffsetX = math.random(var_261_4, var_261_3)
		end

		if arg_265_0._offsetX == nil then
			arg_265_0._offsetX = var_261_4
		end

		if arg_265_0._offsetX - arg_265_0._targetOffsetX > 0.1 then
			arg_265_0._offsetX = math.max(arg_265_0._targetOffsetX, arg_265_0._offsetX - 0.25)
		elseif arg_265_0._offsetX - arg_265_0._targetOffsetX < -0.1 then
			arg_265_0._offsetX = math.min(arg_265_0._targetOffsetX, arg_265_0._offsetX + 0.25)
		end

		local var_265_0 = (var_261_2 - arg_265_0._waveIndex) * 2 % (var_261_2 * 2)
		local var_265_1 = arg_265_0._offsetX * var_0_0.WAVING_BADGE_SIN_VALUES[var_265_0 + 1]

		for iter_265_0 = 0, var_261_0 - 1 do
			local var_265_2 = (iter_265_0 * 4 + (var_261_2 - arg_265_0._waveIndex) * 2) % (var_261_2 * 2)

			for iter_265_1 = 0, var_261_1 - 1 do
				arg_265_0:setVertice(iter_265_0, iter_265_1, cc.p(iter_265_1 * var_261_7 * var_261_9.width + arg_265_0._offsetX * var_0_0.WAVING_BADGE_SIN_VALUES[var_265_2 + 1] - var_265_1, (var_261_0 - 1 - iter_265_0) * var_261_6 * var_261_9.height + iter_265_1 * var_261_5))
			end
		end
	end

	local var_261_14 = cc.p(var_261_9.width / 2 - 6, var_261_9.height / 2 + 10)
	local var_261_15 = cc.Sprite:createWithSpriteFrameName("img_badge_x1")

	var_261_15:setScale(1.4)
	lc.addChildToPos(var_261_13, var_261_15, var_261_14, -1)

	local var_261_16 = cc.Sprite:createWithSpriteFrameName("img_badge_x2")

	var_261_16:setScale(1.4)
	lc.addChildToPos(var_261_13, var_261_16, var_261_14)

	return var_261_13
end

function var_0_0.createWavingFlag(arg_266_0, arg_266_1)
	local var_266_0 = 2
	local var_266_1 = 19
	local var_266_2 = 9
	local var_266_3 = 0
	local var_266_4 = 4
	local var_266_5 = 1 / (var_266_0 - 1)
	local var_266_6 = 1 / (var_266_1 - 1)

	if var_0_0.WAVING_FLAG_SIN_VALUES == nil then
		var_0_0.WAVING_FLAG_SIN_VALUES = {}

		for iter_266_0 = 0, var_266_2 * 2 - 1 do
			table.insert(var_0_0.WAVING_FLAG_SIN_VALUES, math.sin(3.14 * iter_266_0 / var_266_2))
		end
	end

	local var_266_7 = cc.Sprite:createWithSpriteFrameName(string.format("union_war_flag_%02d", arg_266_0 or 0))
	local var_266_8 = var_266_7:getContentSize()

	var_266_7:setPosition(var_266_8.width / 2, var_266_8.height / 2)

	local var_266_9

	if arg_266_1 ~= nil then
		var_266_9 = cc.Label:createWithTTF(arg_266_1, var_0_0.TTF_FONT, var_0_0.FontSize.S1)

		var_266_9:setColor(lc.Color3B.yellow)
		var_266_9:setPosition(lc.w(var_266_7) / 4, lc.h(var_266_7) / 2)
	end

	local var_266_10 = cc.RenderTexture:create(var_266_8.width, var_266_8.height)

	var_266_10:begin()
	var_266_7:visit()

	if var_266_9 ~= nil then
		var_266_9:visit()
	end

	var_266_10:endToLua()

	local var_266_11 = cc.MeshSprite:create(var_266_0, var_266_1, var_266_10:getSprite():getTexture())

	for iter_266_1 = 0, var_266_0 - 1 do
		for iter_266_2 = 0, var_266_1 - 1 do
			var_266_11:setTexCoord(iter_266_1, iter_266_2, cc.p(var_266_6 * iter_266_2, var_266_5 * (var_266_0 - 1 - iter_266_1)))
		end
	end

	function var_266_11.startWave(arg_267_0)
		if arg_267_0._schedulerID ~= nil then
			return
		end

		arg_267_0._waveIndex = math.random(0, var_266_2 - 1)

		arg_267_0:wave()

		arg_267_0._schedulerID = lc.Scheduler:scheduleScriptFunc(function(arg_268_0)
			arg_267_0:wave()
		end, 0.1, false)
	end

	function var_266_11.stopWave(arg_269_0)
		if arg_269_0._schedulerID ~= nil then
			lc.Scheduler:unscheduleScriptEntry(arg_269_0._schedulerID)

			arg_269_0._schedulerID = nil
		end
	end

	function var_266_11.wave(arg_270_0)
		arg_270_0._waveIndex = ((arg_270_0._waveIndex or 0) + 1) % var_266_2

		local var_270_0 = (var_266_2 - arg_270_0._waveIndex) * 2 % (var_266_2 * 2)
		local var_270_1 = var_266_4 * var_0_0.WAVING_FLAG_SIN_VALUES[var_270_0 + 1]

		for iter_270_0 = 0, var_266_0 - 1 do
			for iter_270_1 = 0, var_266_1 - 1 do
				local var_270_2 = (iter_270_1 + (var_266_2 - arg_270_0._waveIndex) * 2) % (var_266_2 * 2)

				arg_270_0:setVertice(iter_270_0, iter_270_1, cc.p(iter_270_1 * var_266_6 * var_266_8.width + iter_270_1 * var_266_3, (var_266_0 - 1 - iter_270_0) * var_266_5 * var_266_8.height + var_266_4 * var_0_0.WAVING_FLAG_SIN_VALUES[var_270_2 + 1] - var_270_1))
			end
		end
	end

	return var_266_11
end

function var_0_0.createAddCardArea(arg_271_0, arg_271_1, arg_271_2)
	local var_271_0 = cc.size(256, 370)
	local var_271_1 = var_0_0.createTouchSpriteWithMask("res/jpg/add_card_bg.jpg", function(arg_272_0)
		if arg_271_1 then
			arg_271_1(arg_272_0)
		end
	end)

	var_271_1:setScale(arg_271_0)

	local var_271_2

	if arg_271_2 then
		var_271_1:setEnabled(false)
		var_271_1:setSwallowTouches(false)

		var_271_2 = cc.LayerGradient:create(cc.c4b(137, 137, 137, 255), cc.c4b(75, 75, 75, 255))

		var_0_0.addLockChains(var_271_1, arg_271_0)
	else
		var_271_2 = cc.LayerGradient:create(cc.c4b(196, 157, 108, 255), cc.c4b(94, 80, 57, 255))
	end

	var_271_2:ignoreAnchorPointForPosition(false)
	var_271_2:setContentSize(var_271_0.width - 32, var_271_0.height - 32)
	var_271_2:setScale(arg_271_0)
	lc.addChildToCenter(var_271_1, var_271_2, -1)

	local var_271_3 = lc.createSprite("img_icon_add_big")

	if arg_271_2 then
		var_271_3:setColor(lc.Color3B.gray)
		var_271_3:setOpacity(100)
	end

	lc.addChildToCenter(var_271_2, var_271_3)

	return var_271_1
end

function var_0_0.addTapHandler(arg_273_0, arg_273_1)
	arg_273_0:setTouchEnabled(true)
	arg_273_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	arg_273_0:addTouchEventListener(function(arg_274_0, arg_274_1)
		if arg_274_1 == ccui.TouchEventType.ended then
			arg_273_1()
		end
	end)
end

function var_0_0.addSkillTapHandler(arg_275_0, arg_275_1, arg_275_2)
	var_0_0.addTapHandler(arg_275_0, function()
		require("SkillForm").create(arg_275_1, arg_275_2):show()
	end)
end

function var_0_0.createClipNode(arg_277_0, arg_277_1, arg_277_2)
	local var_277_0 = cc.ClippingNode:create()

	var_277_0:setContentSize(arg_277_0 and arg_277_0:getContentSize() or cc.size(arg_277_1.width, arg_277_1.height))

	if arg_277_2 then
		var_277_0:setInverted(arg_277_2)
	end

	local var_277_1 = cc.LayerColor:create(lc.Color4B.white, arg_277_1.width, arg_277_1.height)

	var_277_1:setPosition(arg_277_1.x, arg_277_1.y)
	var_277_0:setStencil(var_277_1)

	if arg_277_0 then
		var_277_0:addChild(arg_277_0)
	end

	return var_277_0
end

function var_0_0.getPropExtra(arg_278_0, arg_278_1, arg_278_2)
	local var_278_0, var_278_1 = P._propBag:validPropId(arg_278_0, arg_278_2)
	local var_278_2

	if var_278_0 == Data.PropsId.avatar_frame_level_rank then
		local var_278_3 = var_278_1 - var_278_0

		if var_278_3 > 0 then
			var_278_2 = lc.createSprite(string.format("avatar_frame_7502_%d", var_278_3))

			var_278_2:setPosition(lc.w(arg_278_1) / 2 or 0, 46)
		end
	elseif var_278_0 == Data.PropsId.avatar_frame_xmas_1 then
		var_278_2 = lc.createNode(arg_278_1:getContentSize())

		var_278_2:setPosition(lc.w(arg_278_1) / 2, lc.h(arg_278_1) / 2)

		if var_278_1 == Data.PropsId.avatar_frame_xmas_2 then
			local var_278_4 = lc.createSprite("avatar_frame_7507_1")

			var_278_4:setAnchorPoint(0.52, 0.77)
			var_278_4:setRotation(-10)
			var_278_4:runAction(lc.rep(lc.sequence(lc.rotateTo(1, 10), lc.rotateTo(1, -10))))
			lc.addChildToPos(var_278_2, var_278_4, cc.p(lc.w(arg_278_1) / 2, 12))

			local var_278_5 = lc.createSprite("avatar_frame_7507_2")

			var_278_5:setColor(lc.Color3B.orange)
			var_278_2:addChild(var_278_5)
			var_278_5:runAction(lc.rep(lc.sequence(function()
				var_278_5:setPosition(12, 15)
			end, 1, function()
				var_278_5:setPosition(22, 7)
				var_278_5:setColor(lc.Color3B.yellow)
			end, 1, function()
				var_278_5:setPosition(84, 7)
			end, 1, function()
				var_278_5:setPosition(94, 15)
				var_278_5:setColor(lc.Color3B.orange)
			end, 1)))
		end
	end

	return var_278_0, var_278_2
end

function var_0_0.getAvatarVipOffset(arg_283_0)
	if P._propBag:validPropId(arg_283_0) == Data.PropsId.avatar_frame then
		return 0, 0
	end

	return 0, 0
end

function var_0_0.containPos(arg_284_0, arg_284_1)
	if arg_284_0:getCameraMask() == ClientData.CAMERA_3D_FLAG then
		return lc.contain3D(arg_284_0, arg_284_1, ClientData._camera3D)
	elseif arg_284_0.containPos then
		return arg_284_0:containPos(arg_284_1)
	else
		return lc.contain(arg_284_0, arg_284_1)
	end
end

function var_0_0.openUserProtocol()
	local var_285_0, var_285_1 = lc.App:getChannelName()
	local var_285_2 = lc.App:getRedirectGameServer()
	local var_285_3 = ClientData.getAppId()
	local var_285_4 = "http://sh.smbbgo.com/mzsm/080609314939.html"

	lc.App:openURL(var_285_4)
end

function var_0_0.createLoadingBg()
	local var_286_0 = "res/updater/loading.jpg"
	local var_286_1 = cc.Sprite:create(var_286_0)

	if var_286_1 == nil then
		var_286_0 = "res/updater/loading_1.jpg"
		var_286_1 = cc.Sprite:create(var_286_0)
	end

	if var_286_1 == nil then
		var_286_0 = "res/updater/loading1.jpg"
		var_286_1 = cc.Sprite:create(var_286_0)
	end

	return var_286_1, var_286_0
end

function var_0_0.setValueLabel(arg_287_0, arg_287_1, arg_287_2)
	arg_287_0:stopActionByTag(1)
	arg_287_0:setString(arg_287_2 ~= nil and arg_287_2(arg_287_1) or arg_287_1)

	arg_287_0._value = arg_287_1
end

function var_0_0.updateValueLabel(arg_288_0, arg_288_1, arg_288_2, arg_288_3)
	if arg_288_0._value ~= nil then
		if arg_288_0._value == arg_288_1 or arg_288_2 and arg_288_2(arg_288_0._value) == arg_288_2(arg_288_1) then
			return arg_288_0:stopActionByTag(1)
		end
	else
		arg_288_0:setString(arg_288_2 ~= nil and arg_288_2(arg_288_1) or arg_288_1)

		arg_288_0._value = arg_288_1

		return
	end

	local var_288_0 = 0.05
	local var_288_1 = lc.rep(lc.sequence(var_288_0, lc.call(function()
		local var_289_0 = true

		if arg_288_1 ~= arg_288_0._value and (arg_288_2 == nil or arg_288_2(arg_288_0._value) ~= arg_288_2(arg_288_1)) then
			var_289_0 = false

			local var_289_1 = (arg_288_1 - arg_288_0._value) / 2

			if var_289_1 > 0 then
				var_289_1 = math.ceil(var_289_1)
			else
				var_289_1 = math.floor(var_289_1)
			end

			arg_288_0._value = arg_288_0._value + var_289_1

			if (arg_288_1 - arg_288_0._value) * var_289_1 < 0 then
				arg_288_0._value = arg_288_1
			end

			arg_288_0:setString(arg_288_2 and arg_288_2(arg_288_0._value) or arg_288_0._value)

			if not arg_288_0:getActionByTag(2) then
				local var_289_2 = cc.EaseSineInOut:create(cc.ScaleBy:create(0.05, arg_288_3 or 1.2))
				local var_289_3 = cc.Sequence:create(var_289_2, var_289_2:reverse())

				var_289_3:setTag(2)
				arg_288_0:runAction(var_289_3)
			end
		end

		if var_289_0 then
			arg_288_0._value = arg_288_1

			arg_288_0:stopActionByTag(1)
		end
	end)))

	var_288_1:setTag(1)
	arg_288_0:stopActionByTag(1)
	arg_288_0:runAction(var_288_1)
end

function var_0_0.createFilterButton(arg_290_0, arg_290_1, arg_290_2, arg_290_3)
	local var_290_0 = var_0_0.createBMFont(var_0_0.BMFont.huali_20, arg_290_0)
	local var_290_1 = lc.createSprite("img_filter_item")
	local var_290_2 = 6

	arg_290_2 = arg_290_2 or (lc.w(var_290_0) + lc.w(var_290_1) + var_290_2)
	arg_290_3 = arg_290_3 or lc.h(var_290_1)

	local var_290_3 = var_0_0.createScale9ShaderButton(nil, arg_290_1, cc.rect(1, 1, 1, 1), arg_290_2, arg_290_3)

	lc.addChildToPos(var_290_3, var_290_1, cc.p(lc.cw(var_290_1), lc.ch(var_290_3)))
	
	local maxW = arg_290_2 - lc.w(var_290_1) - var_290_2 - 4
	if lc.w(var_290_0) > maxW then
		var_290_0:setScale(maxW / lc.w(var_290_0))
	end
	var_290_0:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_290_3, var_290_0, cc.p(lc.w(var_290_1) + var_290_2, lc.ch(var_290_3)))

	local var_290_4 = lc.createSprite("img_filter")

	lc.addChildToPos(var_290_1, var_290_4, cc.p(lc.cw(var_290_4), lc.ch(var_290_4)))

	var_290_3._selectSpr = var_290_4

	function var_290_3.setIsSelected(arg_291_0, arg_291_1)
		arg_291_0._selectSpr:setVisible(arg_291_1)
	end

	return var_290_3
end

function var_0_0.debugNode(arg_292_0)
	local var_292_0 = cc.DrawNode:create()

	var_292_0:setContentSize(arg_292_0:getContentSize())
	var_292_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_292_0, var_292_0)
	var_292_0:drawRect(cc.p(0, 0), cc.p(lc.w(var_292_0), lc.h(var_292_0)), cc.c4f(1, 1, 1, 1))
end

function var_0_0.showResExchangeForm(arg_293_0)
	local var_293_0 = {
		Data.ResType.gold,
		Data.ResType.grain,
		Data.ResType.ingot,
		Data.PropsId.dust_monster,
		Data.PropsId.dust_magic,
		Data.PropsId.dust_rare
	}

	for iter_293_0 = 1, #var_293_0 do
		local var_293_1 = var_293_0[iter_293_0]
		local var_293_2 = ClientView._resExchangeForms[var_293_1]

		if var_293_2 then
			if arg_293_0 == var_293_1 then
				return
			else
				var_293_2:hide()

				break
			end
		end
	end

	if arg_293_0 == Data.ResType.ingot or arg_293_0 == Data.PropsId.cumulative_exchange_token then
		if not ClientData.isHideCharge() then
			if ClientData.isAppStoreReviewing() then
				require("VIPForm").create(true):show()
			else
				lc.pushScene(require("RechargeScene").create())
			end
		end
	else
		require("ExchangeResForm").create(arg_293_0):show()
	end
end

function var_0_0.createCardPackage(arg_294_0, arg_294_1)
	local var_294_0 = cc.Node:create()
	local var_294_1 = string.format("lottery_%d", arg_294_0._value)
	local var_294_2

	if arg_294_0._value < 10201 or not lc.File:isFileExist(lc.formatJpg(var_294_1)) then
		var_294_1 = "lottery_101001"
	end

	if ClientData.isAnotherSkin() then
		lc.TextureCache:addImageWithMask(lc.formatJpg(var_294_1 .. "_2"))

		var_294_2 = cc.ShaderSprite:createWithFilename(lc.formatJpg(var_294_1 .. "_2"))
	elseif ClientData.isAnotherCardImageSkin() then
		lc.TextureCache:addImageWithMask(lc.formatJpg(var_294_1 .. "_3"))

		var_294_2 = cc.ShaderSprite:createWithFilename(lc.formatJpg(var_294_1 .. "_3"))
	end

	if not var_294_2 then
		local var_294_3 = lc.formatJpg(var_294_1)

		lc.TextureCache:addImageWithMask(var_294_3)

		var_294_2 = cc.ShaderSprite:createWithFilename(var_294_3)
	end

	local var_294_4 = 1

	if Data.getIsRareRecruite(arg_294_0) then
		var_294_4 = 0
	elseif Data.getIsClashRecruite(arg_294_0) then
		var_294_4 = 2
	end

	local var_294_5 = string.format("res/jpg/tavern_item_head_%.2d.jpg", var_294_4)

	if Data.getIsGodPumpRecruite(arg_294_0) then
		var_294_5 = "res/jpg/rare_shop_head.jpg"
	end

	lc.TextureCache:addImageWithMask(var_294_5)

	local var_294_6 = cc.ShaderSprite:createWithFilename(var_294_5)
	local var_294_7 = string.format("res/jpg/tavern_item_foot_%.2d.jpg", var_294_4)

	if Data.getIsGodPumpRecruite(arg_294_0) then
		var_294_7 = "res/jpg/rare_shop_foot.jpg"
	end

	lc.TextureCache:addImageWithMask(var_294_7)

	local var_294_8 = cc.ShaderSprite:createWithFilename(var_294_7)

	var_294_0:setContentSize(cc.size(lc.w(var_294_2), lc.h(var_294_8) + lc.h(var_294_2) + lc.h(var_294_6)))
	var_294_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(var_294_0, var_294_8, cc.p(lc.cw(var_294_0), lc.ch(var_294_8)))
	lc.addChildToPos(var_294_0, var_294_6, cc.p(lc.cw(var_294_0), lc.h(var_294_0) - lc.ch(var_294_6)))
	lc.addChildToPos(var_294_0, var_294_2, cc.p(lc.cw(var_294_0), lc.h(var_294_8) + lc.ch(var_294_2)))

	if arg_294_0._type == 1001 then
		local var_294_9 = Particle.create("leiya")

		lc.addChildToCenter(var_294_2, var_294_9)
		var_294_9:setPositionType(cc.POSITION_TYPE_GROUPED)

		var_294_0._particle = var_294_9
	end

	function var_294_0.setGray(arg_295_0)
		var_294_2:setEffect(ClientView.SHADER_DISABLE)
		var_294_6:setEffect(ClientView.SHADER_DISABLE)
		var_294_8:setEffect(ClientView.SHADER_DISABLE)

		if arg_295_0._particle then
			arg_295_0._particle:setVisible(false)
		end
	end

	return var_294_0
end

function var_0_0.startIAP(arg_296_0)
	local var_296_0 = ClientData.getAppId()

	if var_296_0 == "1223968820" or var_296_0 == "1224018227" then
		require("Dialog").showDialog(Str(STR.IAP_TIP_1, true), function()
			lc.App:openUrl("http://jdzc_update.smbbgo.com")
		end)

		return
	elseif var_296_0 == "1263797229" then
		require("Dialog").showDialog(Str(STR.IAP_TIP_1, true), function()
			lc.App:openUrl("https://itunes.apple.com/cn/app/id1423078317?l=zh&ls=1&mt=8")
		end)

		return
	end

	local var_296_1 = ClientData.getSubChannelName()

	if var_296_1 == "huyacomp" then
		return
	end

	if var_296_1 ~= "uc" and var_296_1 ~= "jinli" and var_296_1 ~= "mhr" and var_296_1 ~= "pptv" and var_296_1 ~= "ewan" and var_296_1 ~= "m4399" and var_296_1 ~= "xmw" and var_296_1 ~= "panda" then
		ClientView.getActiveIndicator():show(Str(STR.WAITING), nil, nil, 0)
	elseif ClientData._isIAPing and arg_296_0 >= Data.PurchaseType.month_card_1 then
		require("Dialog").showDialog(Str(STR.IAP_TIP_2), function()
			ClientData.sendIAPStartReq(arg_296_0)
		end, true)

		return
	end

	ClientData.sendIAPStartReq(arg_296_0)

	ClientData._isIAPing = true
end

function var_0_0.iapPaySuccess()
	return
end

function var_0_0.iapFinish()
	ClientView.getActiveIndicator():hide()
end

function var_0_0.createUnionCardPackage(arg_302_0, arg_302_1)
	local var_302_0 = cc.Node:create()
	local var_302_1 = string.format("res/jpg/union_shop_%d.jpg", arg_302_0._type)

	lc.TextureCache:addImageWithMask(var_302_1)

	local var_302_2 = cc.ShaderSprite:createWithFilename(var_302_1)

	if not var_302_2 then
		local var_302_3 = string.format("res/jpg/union_shop_%d.jpg", 16)

		lc.TextureCache:addImageWithMask(var_302_3)

		var_302_2 = cc.ShaderSprite:createWithFilename(var_302_3)
	end

	local var_302_4 = string.format("res/jpg/union_shop_head.jpg")

	lc.TextureCache:addImageWithMask(var_302_4)

	local var_302_5 = cc.ShaderSprite:createWithFilename(var_302_4)
	local var_302_6 = string.format("res/jpg/union_shop_foot.jpg")

	lc.TextureCache:addImageWithMask(var_302_6)

	local var_302_7 = cc.ShaderSprite:createWithFilename(var_302_6)

	var_302_0:setContentSize(cc.size(lc.w(var_302_2), lc.h(var_302_7) + lc.h(var_302_2) + lc.h(var_302_5)))
	var_302_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(var_302_0, var_302_7, cc.p(lc.cw(var_302_0), lc.ch(var_302_7)))
	lc.addChildToPos(var_302_0, var_302_5, cc.p(lc.cw(var_302_0), lc.h(var_302_0) - lc.ch(var_302_5)))
	lc.addChildToPos(var_302_0, var_302_2, cc.p(lc.cw(var_302_0), lc.h(var_302_7) + lc.ch(var_302_2)))

	function var_302_0.setGray(arg_303_0)
		var_302_2:setEffect(ClientView.SHADER_DISABLE)
		var_302_5:setEffect(ClientView.SHADER_DISABLE)
		var_302_7:setEffect(ClientView.SHADER_DISABLE)

		if arg_303_0._particle then
			arg_303_0._particle:setVisible(false)
		end
	end

	return var_302_0
end

function var_0_0.createRareCardPackage(arg_304_0, arg_304_1)
	local var_304_0 = cc.Node:create()
	local var_304_1 = arg_304_0._type == 0 and "res/jpg/rare_shop_0.jpg" or string.format("res/jpg/lottery_%d.jpg", arg_304_0._type .. "01")

	lc.TextureCache:addImageWithMask(var_304_1)

	local var_304_2 = cc.ShaderSprite:createWithFilename(var_304_1)
	local var_304_3 = "res/jpg/rare_shop_head.jpg"

	lc.TextureCache:addImageWithMask(var_304_3)

	local var_304_4 = cc.ShaderSprite:createWithFilename(var_304_3)
	local var_304_5 = "res/jpg/rare_shop_foot.jpg"

	lc.TextureCache:addImageWithMask(var_304_5)

	local var_304_6 = cc.ShaderSprite:createWithFilename(var_304_5)

	var_304_0:setContentSize(cc.size(lc.w(var_304_2), lc.h(var_304_6) + lc.h(var_304_2) + lc.h(var_304_4)))
	var_304_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(var_304_0, var_304_6, cc.p(lc.cw(var_304_0), lc.ch(var_304_6)))
	lc.addChildToPos(var_304_0, var_304_4, cc.p(lc.cw(var_304_0), lc.h(var_304_0) - lc.ch(var_304_4)))
	lc.addChildToPos(var_304_0, var_304_2, cc.p(lc.cw(var_304_0), lc.h(var_304_6) + lc.ch(var_304_2)))

	local var_304_7 = Particle.create("leiya")

	lc.addChildToCenter(var_304_2, var_304_7)
	var_304_7:setPositionType(cc.POSITION_TYPE_GROUPED)

	var_304_0._particle = var_304_7

	function var_304_0.setGray(arg_305_0)
		var_304_2:setEffect(ClientView.SHADER_DISABLE)
		var_304_4:setEffect(ClientView.SHADER_DISABLE)
		var_304_6:setEffect(ClientView.SHADER_DISABLE)

		if arg_305_0._particle then
			arg_305_0._particle:setVisible(false)
		end
	end

	return var_304_0
end

function var_0_0.createExchangeCardPackage(arg_306_0, arg_306_1)
	local var_306_0 = cc.Node:create()
	local var_306_1 = Data._exchangeInfo[arg_306_0]._activityId
	local var_306_2 = string.format("res/jpg/lottery_%d.jpg", var_306_1)

	lc.TextureCache:addImageWithMask(var_306_2)

	local var_306_3 = cc.ShaderSprite:createWithFilename(var_306_2)

	if not var_306_3 then
		local var_306_4 = string.format("res/jpg/lottery_%d.jpg", 1001)

		lc.TextureCache:addImageWithMask(var_306_4)

		var_306_3 = cc.ShaderSprite:createWithFilename(var_306_4)
	end

	local var_306_5 = "res/jpg/rare_shop_head.jpg"

	lc.TextureCache:addImageWithMask(var_306_5)

	local var_306_6 = cc.ShaderSprite:createWithFilename(var_306_5)
	local var_306_7 = "res/jpg/rare_shop_foot.jpg"

	lc.TextureCache:addImageWithMask(var_306_7)

	local var_306_8 = cc.ShaderSprite:createWithFilename(var_306_7)

	var_306_0:setContentSize(cc.size(lc.w(var_306_3), lc.h(var_306_8) + lc.h(var_306_3) + lc.h(var_306_6)))
	var_306_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(var_306_0, var_306_8, cc.p(lc.cw(var_306_0), lc.ch(var_306_8)))
	lc.addChildToPos(var_306_0, var_306_6, cc.p(lc.cw(var_306_0), lc.h(var_306_0) - lc.ch(var_306_6)))
	lc.addChildToPos(var_306_0, var_306_3, cc.p(lc.cw(var_306_0), lc.h(var_306_8) + lc.ch(var_306_3)))

	local var_306_9 = Particle.create("leiya")

	lc.addChildToCenter(var_306_3, var_306_9)
	var_306_9:setPositionType(cc.POSITION_TYPE_GROUPED)

	var_306_0._particle = var_306_9

	function var_306_0.setGray(arg_307_0)
		var_306_3:setEffect(ClientView.SHADER_DISABLE)
		var_306_6:setEffect(ClientView.SHADER_DISABLE)
		var_306_8:setEffect(ClientView.SHADER_DISABLE)

		if arg_307_0._particle then
			arg_307_0._particle:setVisible(false)
		end
	end

	return var_306_0
end

function var_0_0.createDiamondCardPackage(arg_308_0, arg_308_1)
	local var_308_0 = cc.Node:create()
	local var_308_1 = arg_308_0._type == 0 and "res/jpg/diamond_shop_0.jpg" or string.format("res/jpg/lottery_%d.jpg", arg_308_0._type .. "01")

	lc.TextureCache:addImageWithMask(var_308_1)

	local var_308_2 = cc.ShaderSprite:createWithFilename(var_308_1)
	local var_308_3 = "res/jpg/diamond_shop_head.jpg"

	lc.TextureCache:addImageWithMask(var_308_3)

	local var_308_4 = cc.ShaderSprite:createWithFilename(var_308_3)
	local var_308_5 = "res/jpg/diamond_shop_foot.jpg"

	lc.TextureCache:addImageWithMask(var_308_5)

	local var_308_6 = cc.ShaderSprite:createWithFilename(var_308_5)

	var_308_0:setContentSize(cc.size(lc.w(var_308_2), lc.h(var_308_6) + lc.h(var_308_2) + lc.h(var_308_4)))
	var_308_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(var_308_0, var_308_6, cc.p(lc.cw(var_308_0), lc.ch(var_308_6)))
	lc.addChildToPos(var_308_0, var_308_4, cc.p(lc.cw(var_308_0), lc.h(var_308_0) - lc.ch(var_308_4)))
	lc.addChildToPos(var_308_0, var_308_2, cc.p(lc.cw(var_308_0), lc.h(var_308_6) + lc.ch(var_308_2)))

	local var_308_7 = Particle.create("leiya")

	lc.addChildToCenter(var_308_2, var_308_7)
	var_308_7:setPositionType(cc.POSITION_TYPE_GROUPED)

	var_308_0._particle = var_308_7

	function var_308_0.setGray(arg_309_0)
		var_308_2:setEffect(ClientView.SHADER_DISABLE)
		var_308_4:setEffect(ClientView.SHADER_DISABLE)
		var_308_6:setEffect(ClientView.SHADER_DISABLE)

		if arg_309_0._particle then
			arg_309_0._particle:setVisible(false)
		end
	end

	return var_308_0
end

function var_0_0.createNewCardPackage(arg_310_0, arg_310_1)
	local var_310_0 = cc.Node:create()
	local var_310_1 = string.format("res/jpg/lottery_%d.jpg", arg_310_0._type .. "01")

	lc.TextureCache:addImageWithMask(var_310_1)

	local var_310_2 = cc.ShaderSprite:createWithFilename(var_310_1)
	local var_310_3 = "res/jpg/rare_shop_head.jpg"

	lc.TextureCache:addImageWithMask(var_310_3)

	local var_310_4 = cc.ShaderSprite:createWithFilename(var_310_3)
	local var_310_5 = "res/jpg/rare_shop_foot.jpg"

	lc.TextureCache:addImageWithMask(var_310_5)

	local var_310_6 = cc.ShaderSprite:createWithFilename(var_310_5)

	var_310_0:setContentSize(cc.size(lc.w(var_310_2), lc.h(var_310_6) + lc.h(var_310_2) + lc.h(var_310_4)))
	var_310_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(var_310_0, var_310_6, cc.p(lc.cw(var_310_0), lc.ch(var_310_6)))
	lc.addChildToPos(var_310_0, var_310_4, cc.p(lc.cw(var_310_0), lc.h(var_310_0) - lc.ch(var_310_4)))
	lc.addChildToPos(var_310_0, var_310_2, cc.p(lc.cw(var_310_0), lc.h(var_310_6) + lc.ch(var_310_2)))

	local var_310_7 = Particle.create("leiya")

	lc.addChildToCenter(var_310_2, var_310_7)
	var_310_7:setPositionType(cc.POSITION_TYPE_GROUPED)

	var_310_0._particle = var_310_7

	function var_310_0.setGray(arg_311_0)
		var_310_2:setEffect(ClientView.SHADER_DISABLE)
		var_310_4:setEffect(ClientView.SHADER_DISABLE)
		var_310_6:setEffect(ClientView.SHADER_DISABLE)

		if arg_311_0._particle then
			arg_311_0._particle:setVisible(false)
		end
	end

	return var_310_0
end

function var_0_0.setMaxSize(arg_312_0, arg_312_1, arg_312_2)
	if arg_312_0.setScale == nil then
		return
	end

	local var_312_0

	if arg_312_1 == nil and arg_312_2 ~= nil then
		var_312_0 = arg_312_2 / lc.h(arg_312_0)
	elseif arg_312_1 ~= nil and arg_312_2 == nil then
		var_312_0 = arg_312_1 / lc.w(arg_312_0)
	elseif arg_312_1 ~= nil and arg_312_2 ~= nil then
		var_312_0 = math.min(arg_312_2 / lc.h(arg_312_0), arg_312_1 / lc.w(arg_312_0))
	end

	if var_312_0 ~= nil and var_312_0 < 1 then
		arg_312_0:setScale(var_312_0)
	end
end

function var_0_0.createCharacterHeadById(arg_313_0)
	if arg_313_0 ~= -1 then
		local var_313_0 = string.format("head_%02d", arg_313_0)

		if ClientData.isAnotherSkin() and lc.FrameCache:getSpriteFrame(var_313_0 .. "_2") then
			var_313_0 = var_313_0 .. "_2"
		elseif ClientData.isAnotherSkin2() and lc.FrameCache:getSpriteFrame(var_313_0 .. "_3") then
			var_313_0 = var_313_0 .. "_3"
		end

		return cc.ShaderSprite:createWithFramename(var_313_0)
	end

	return cc.ShaderSprite:createWithFramename("head_unknow")
end

function var_0_0.addPriceToBtn(arg_314_0, arg_314_1, arg_314_2, arg_314_3, arg_314_4)
	if not arg_314_2 then
		if arg_314_0._resIcon then
			arg_314_0._resIcon:removeFromParent()

			arg_314_0._resIcon = nil
		end

		if arg_314_0._resNumLabel then
			arg_314_0._resNumLabel:removeFromParent()

			arg_314_0._resNumLabel = nil
		end

		return
	end

	local var_314_0
	local var_314_1 = arg_314_0._resIcon
	local var_314_2 = Data.getType(arg_314_2)

	if var_314_2 == Data.CardType.props or var_314_2 == Data.CardType.item_skill or var_314_2 == Data.CardType.res then
		var_314_0 = ClientData.getIconName(arg_314_2)
	else
		if var_314_1 then
			var_314_1:removeFromParent()

			arg_314_0._resIcon = nil
		end

		return
	end

	if var_314_1 == nil then
		var_314_1 = lc.createSprite(var_314_0)

		var_314_1:setAnchorPoint(cc.p(0, 0.5))
		var_0_0.setMaxSize(var_314_1, arg_314_3, arg_314_4)
		lc.addChildToPos(arg_314_0, var_314_1, cc.p(lc.cw(arg_314_0) - arg_314_3 / 2 - 2, lc.ch(arg_314_0)))

		arg_314_0._resIcon = var_314_1
	else
		var_314_1:setSpriteFrame(var_314_0)
	end

	local var_314_3 = ClientData.formatNum(arg_314_1, 99999)
	local var_314_4 = arg_314_0._resNumLabel
	local var_314_5 = lc.cw(arg_314_0) + arg_314_3 / 2 - lc.right(var_314_1)

	if var_314_4 == nil then
		var_314_4 = var_0_0.createBMFont(var_0_0.BMFont.huali_20, var_314_3)

		var_314_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_0_0.setMaxSize(var_314_4, var_314_5)
		lc.addChildToPos(arg_314_0, var_314_4, cc.p(lc.right(var_314_1) + var_314_5 / 2 + 4, lc.ch(arg_314_0)))

		arg_314_0._resNumLabel = var_314_4

		var_314_4:setColor(arg_314_1 > P:getItemCount(arg_314_2) and ClientView.COLOR_TEXT_RED or ClientView.COLOR_TEXT_WHITE)
	else
		var_314_4:setString(var_314_3)
		var_314_4:setColor(arg_314_1 > P:getItemCount(arg_314_2) and ClientView.COLOR_TEXT_RED or ClientView.COLOR_TEXT_WHITE)
	end
end

function var_0_0.createPageArrow(arg_315_0, arg_315_1, arg_315_2)
	local var_315_0 = ClientView.createShaderButton("img_page_right", arg_315_2)

	var_315_0:setAnchorPoint(0, 0.5)
	var_315_0:setFlippedX(arg_315_0)
	var_315_0:setTouchRect(cc.rect(-20, -20, lc.w(var_315_0) + 40, lc.h(var_315_0) + 40))

	var_315_0._pos = arg_315_1

	function var_315_0.float(arg_316_0)
		arg_316_0:stopAllActions()
		arg_316_0:setPosition(arg_316_0._pos)
		arg_316_0:runAction(lc.rep(lc.sequence({
			lc.moveTo(0.8, cc.p(arg_316_0._pos.x + (arg_315_0 and -8 or 8), arg_316_0._pos.y)),
			lc.moveTo(0.8, arg_316_0._pos)
		})))
	end

	return var_315_0
end

function var_0_0.createSkinFrame(arg_317_0, arg_317_1, arg_317_2)
	local var_317_0 = Data._skinInfo[arg_317_0]

	arg_317_1 = arg_317_1 or var_317_0._infoId

	local var_317_1 = Data.getInfo(arg_317_1)
	local var_317_2 = lc.createSpriteWithMask("res/jpg/skin_frame.jpg")
	local var_317_3 = lc.createSprite("card_frame_bg_0")

	lc.addChildToPos(var_317_2, var_317_3, cc.p(lc.cw(var_317_2), lc.ch(var_317_2)), -1)

	if not arg_317_2 then
		local var_317_4 = lc.createSprite({
			_name = "img_com_bg_27",
			_crect = ClientView.CRECT_COM_BG27,
			_size = cc.size(lc.w(var_317_2) - 20, 50)
		})

		var_317_4:setOpacity(160)
		lc.addChildToPos(var_317_2, var_317_4, cc.p(lc.cw(var_317_2), lc.ch(var_317_4) + 8), 1)

		local var_317_5 = ClientView.createTTF(Str(var_317_0._nameSid), ClientView.FontSize.S1)

		var_317_5:setScale(0.8)
		lc.addChildToPos(var_317_2, var_317_5, cc.p(lc.cw(var_317_2), 44), 1)

		var_317_2._nameLabel = var_317_5

		local var_317_6 = ClientView.createTTF(Str(var_317_1._nameSid), ClientView.FontSize.S1)

		var_317_6:setColor(ClientView.COLOR_LABEL_LIGHT)
		lc.addChildToPos(var_317_2, var_317_6, cc.p(lc.cw(var_317_2), 22), 1)

		var_317_2._monsterNameLabel = var_317_6

		var_317_6:setScale(math.min(0.8, 230 / lc.w(var_317_6)))
	end

	function var_317_2.updateSkin(arg_318_0, arg_318_1, arg_318_2)
		local var_318_0 = Data._skinInfo[arg_318_1]

		arg_318_2 = arg_318_2 or var_318_0._infoId

		local var_318_1 = Data.getInfo(arg_318_2)

		if arg_318_0._bones ~= nil then
			arg_318_0._bones:removeFromParent()

			arg_318_0._bones = nil
		end

		local var_318_2 = var_318_0 and tonumber(string.sub(var_318_0._effect, 1, -3)) or 0

		if var_318_0 == nil or var_318_2 == 0 then
			if arg_318_0._image == nil then
				local var_318_3 = cc.ShaderSprite:createWithFilename(ClientView.getCardImageName(arg_318_2, arg_318_1))

				lc.addChildToCenter(arg_318_0, var_318_3)

				arg_318_0._image = var_318_3
			else
				arg_318_0._image:setTexture(lc.TextureCache:addImage(ClientView.getCardImageName(arg_318_2, arg_318_1)))
			end
		else
			local var_318_4 = DragonBones.create(var_318_2)

			var_318_4:gotoAndPlay("effect")
			lc.addChildToCenter(arg_318_0, var_318_4)

			arg_318_0._bones = var_318_4

			if arg_318_0._image ~= nil then
				arg_318_0._image:removeFromParent()

				arg_318_0._image = nil
			end
		end
	end

	var_317_2:updateSkin(arg_317_0, arg_317_1)

	return var_317_2
end

function var_0_0.createAvatarSkinFrame(arg_319_0, arg_319_1, arg_319_2)
	local var_319_0 = Data._skinInfo[arg_319_0]

	arg_319_1 = arg_319_1 or var_319_0._infoId

	local var_319_1 = Data._characterInfo[arg_319_1]
	local var_319_2 = lc.createNode(cc.size(140, 150))
	local var_319_3 = lc.createSprite("avatar_frame_001")

	var_319_3:setScale(1.3)
	lc.addChildToCenter(var_319_2, var_319_3, 1)

	if not arg_319_2 then
		local var_319_4 = lc.createSprite({
			_name = "img_com_bg_27",
			_crect = ClientView.CRECT_COM_BG27,
			_size = cc.size(lc.w(var_319_2) - 20, 30)
		})

		var_319_4:setOpacity(160)
		lc.addChildToPos(var_319_2, var_319_4, cc.p(lc.cw(var_319_2), lc.ch(var_319_4) + 8), 1)

		local var_319_5 = ClientView.createTTF(Str(var_319_0._nameSid), ClientView.FontSize.S1)

		var_319_5:setScale(0.8)
		lc.addChildToCenter(var_319_4, var_319_5)

		var_319_2._nameLabel = var_319_5
	end

	function var_319_2.updateSkin(arg_320_0, arg_320_1, arg_320_2)
		local var_320_0 = Data._skinInfo[arg_320_1]

		arg_320_2 = arg_320_2 or var_320_0._infoId

		local var_320_1 = Data._characterInfo[arg_320_2]

		if arg_320_0._image == nil then
			local var_320_2 = lc.createSprite(ClientData.getAvatarName(arg_320_1))

			lc.addChildToCenter(arg_320_0, var_320_2)

			arg_320_0._image = var_320_2
		else
			arg_320_0._image:setSpriteFrame(ClientData.getAvatarName(arg_320_1))
		end

		local var_320_3 = arg_320_0._nameLabel

		if var_320_3 then
			var_320_3:setString(Str(var_320_0._nameSid))
		end
	end

	var_319_2:updateSkin(arg_319_0, arg_319_1)

	return var_319_2
end

function var_0_0.createCharacterSkinFrame(arg_321_0, arg_321_1, arg_321_2)
	local var_321_0 = Data._skinInfo[arg_321_0]

	arg_321_1 = arg_321_1 or var_321_0._infoId

	local var_321_1 = Data._characterInfo[arg_321_1]
	local var_321_2 = ccui.Layout:create()

	var_321_2:setContentSize(256, 256)
	var_321_2:setAnchorPoint(0.5, 0.5)
	lc.TextureCache:addImageWithMask("res/jpg/skin_frame.jpg")
	var_321_2:setBackGroundImage("res/jpg/skin_frame.jpg", ccui.TextureResType.localType)
	var_321_2:setClippingEnabled(true)

	local var_321_3 = lc.createSprite("card_frame_bg_0")

	lc.addChildToPos(var_321_2, var_321_3, cc.p(lc.cw(var_321_2), lc.ch(var_321_2)), -1)

	if not arg_321_2 then
		local var_321_4 = lc.createSprite({
			_name = "img_com_bg_27",
			_crect = ClientView.CRECT_COM_BG27,
			_size = cc.size(lc.w(var_321_2) - 20, 50)
		})

		var_321_4:setOpacity(160)
		lc.addChildToPos(var_321_2, var_321_4, cc.p(lc.cw(var_321_2), lc.ch(var_321_4) + 8), 1)

		local var_321_5 = ClientView.createTTF(Str(var_321_0._nameSid), ClientView.FontSize.S1)

		var_321_5:setScale(0.8)
		lc.addChildToPos(var_321_2, var_321_5, cc.p(lc.cw(var_321_2), 44), 1)

		var_321_2._nameLabel = var_321_5

		local var_321_6 = ClientView.createTTF(Str(var_321_1._nameSid), ClientView.FontSize.S1)

		var_321_6:setScale(0.8)
		var_321_6:setColor(ClientView.COLOR_LABEL_LIGHT)
		lc.addChildToPos(var_321_2, var_321_6, cc.p(lc.cw(var_321_2), 22), 1)

		var_321_2._characterNameLabel = var_321_6
	end

	function var_321_2.updateSkin(arg_322_0, arg_322_1, arg_322_2)
		local var_322_0 = Data._skinInfo[arg_322_1]

		arg_322_2 = arg_322_2 or var_322_0._infoId

		local var_322_1 = Data._characterInfo[arg_322_2]

		if arg_322_0._bones ~= nil then
			arg_322_0._bones:removeFromParent()

			arg_322_0._bones = nil
		end

		arg_322_0._nameLabel:setString(Str(var_322_0._nameSid))
		arg_322_0._characterNameLabel:setString(Str(var_322_1._nameSid))

		local var_322_2 = var_322_0._effect
		local var_322_3 = DragonBones.create(var_322_2)

		var_322_3:setScale(0.3)
		var_322_3:gotoAndPlay(Data.getEffectAniName(var_322_2))
		lc.addChildToCenter(arg_322_0, var_322_3)
		lc.offset(var_322_3, 0, CHARACTER_OFFSETY[var_322_2] * 0.3 - 30)

		arg_322_0._bones = var_322_3
	end

	var_321_2:updateSkin(arg_321_0, arg_321_1)

	return var_321_2
end

function var_0_0.setOrCreateFundTaskCell(arg_323_0, arg_323_1, arg_323_2, arg_323_3)
	if not arg_323_0 then
		arg_323_0 = ClientView.createShaderButton(nil, nil)

		local var_323_0 = cc.ShaderSprite:createWithFramename("fund_task_bg")

		arg_323_0:setContentSize(var_323_0:getContentSize())
		lc.addChildToCenter(arg_323_0, var_323_0)

		local var_323_1 = arg_323_0:getContentSize()
		local var_323_2 = ClientView.createTTF("", ClientView.FontSize.S2, ClientView.COLOR_TEXT_DARK)

		lc.addChildToPos(arg_323_0, var_323_2, cc.p(var_323_1.width / 2, var_323_1.height - 19))

		arg_323_0._titleLabel = var_323_2

		local var_323_3 = ClientView.createShaderButton(nil, function()
			P._playerBonus:sendResetFundTask(arg_323_0._bonus._info._cid)
		end)

		var_323_3:setContentSize(cc.size(80, 80))

		local var_323_4 = lc.createSprite("img_icon_wrong")

		lc.addChildToCenter(var_323_3, var_323_4)
		lc.addChildToPos(arg_323_0, var_323_3, cc.p(var_323_1.width - lc.cw(var_323_4) - 10, lc.y(var_323_2)))

		local var_323_5 = lc.createSprite({
			_name = "img_com_bg_23",
			_crect = ClientView.CRECT_COM_BG23,
			_size = cc.size(var_323_1.width - 40, 1)
		})

		var_323_5:setScaleY(0.5)
		lc.addChildToPos(arg_323_0, var_323_5, cc.p(var_323_1.width / 2, var_323_1.height - 35))

		local var_323_6 = ClientView.createTTF("", ClientView.FontSize.S3, ClientView.COLOR_TEXT_DARK, cc.size(var_323_1.width - 30, 60), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

		var_323_6:setAnchorPoint(0.5, 1)
		lc.addChildToPos(arg_323_0, var_323_6, cc.p(var_323_1.width / 2, lc.bottom(var_323_5) - 5))

		arg_323_0._contentLabel = var_323_6

		local var_323_7 = ClientView.createScale9ShaderButton("img_btn_1_s", nil, ClientView.CRECT_BUTTON_S, var_323_1.width - 60, 40)

		lc.addChildToPos(arg_323_0, var_323_7, cc.p(var_323_1.width / 2, lc.ch(var_323_7) + 10))
		var_323_7:addLabel(Str(STR.CLAIM))

		arg_323_0._claimBtn = var_323_7

		local var_323_8 = ClientView.createProgressBar(var_323_1.width - 20)

		lc.addChildToPos(arg_323_0, var_323_8, cc.p(lc.x(var_323_7), lc.y(var_323_7)))

		local var_323_9 = ClientView.createBMFont(ClientView.BMFont.huali_20, "")

		var_323_9:setScale(0.8)
		lc.addChildToCenter(var_323_8, var_323_9)

		local var_323_10 = lc.createSprite({
			_name = "img_com_bg_45",
			_crect = ClientView.CRECT_COM_BG45,
			_size = cc.size(lc.w(arg_323_0) - 20, 69)
		})

		lc.addChildToCenter(arg_323_0, var_323_10)

		local var_323_11 = ClientView.createTTF(Str(STR.WAIT_FOR_TASK), ClientView.FontSize.S3)

		ClientView.fitLabel(var_323_11, lc.w(var_323_10) - 16)
		lc.addChildToCenter(var_323_10, var_323_11)

		local var_323_12 = lc.createNode()

		var_323_12:setAnchorPoint(0.5, 1)
		lc.addChildToPos(arg_323_0, var_323_12, cc.p(var_323_1.width / 2, lc.top(var_323_7) + 40))

		function arg_323_0.hide()
			var_323_0:setEffect(ClientView.SHADER_DISABLE)
			var_323_2:setVisible(false)
			var_323_3:setVisible(false)
			var_323_5:setVisible(false)
			var_323_6:setVisible(false)
			var_323_7:setVisible(false)
			var_323_8:setVisible(false)
			var_323_12:setVisible(false)
			var_323_10:setVisible(true)
		end

		function arg_323_0.show()
			var_323_0:setEffect(nil)
			var_323_2:setVisible(true)
			var_323_3:setVisible(true)
			var_323_5:setVisible(true)
			var_323_6:setVisible(true)
			var_323_7:setVisible(true)
			var_323_8:setVisible(true)
			var_323_12:setVisible(true)
			var_323_10:setVisible(false)
		end

		function arg_323_0.update(arg_327_0)
			var_323_12:removeAllChildren()

			if not arg_327_0 then
				arg_323_0.hide()

				return
			else
				arg_323_0.show()
			end

			arg_323_0._bonus = arg_327_0

			if arg_323_3 then
				if arg_327_0:canClaim() then
					var_323_7:setVisible(true)
					var_323_8:setVisible(false)
				else
					var_323_7:setVisible(false)
					var_323_8:setVisible(true)
				end

				if P._playerBonus._fundResetCount > 0 and not arg_327_0:canClaim() then
					var_323_3:setVisible(true)
				else
					var_323_3:setVisible(false)
				end
			else
				var_323_3:setVisible(false)
				var_323_7:setVisible(false)
				var_323_8:setVisible(true)
			end

			local var_327_0 = ""

			if arg_323_2 then
				var_327_0 = string.format(Str(STR.TASK_NO), arg_323_2)
			else
				var_327_0 = Str(STR.FUND_TASK)
			end

			var_323_2:setString(var_327_0)

			local var_327_1 = arg_327_0._info
			local var_327_2 = {}

			if var_327_1 then
				local var_327_3 = string.format(ClientData.str(var_327_1._nameSid, true), var_327_1._val)

				var_323_6:setString(var_327_3)

				local var_327_4 = var_327_1._rid
				local var_327_5 = var_327_1._level
				local var_327_6 = var_327_1._count
				local var_327_7 = var_327_1._isFragment

				for iter_327_0, iter_327_1 in ipairs(var_327_4) do
					local var_327_8 = IconWidget.create({
						_infoId = iter_327_1,
						_level = var_327_5[iter_327_0],
						_isFragment = var_327_7[iter_327_0] > 0,
						_count = var_327_6[iter_327_0]
					}, IconWidget.DisplayFlag.COUNT)

					var_327_8:setScale(0.75)
					var_327_8._name:setColor(lc.Color3B.black)
					var_327_8:setSwallowTouches(not arg_323_3)
					table.insert(var_327_2, var_327_8)
				end

				var_323_8._bar:setPercent(100 * arg_327_0._value / var_327_1._val)

				if arg_327_0._value >= var_327_1._val then
					var_323_9:setString(Str(STR.CAN_S) .. Str(STR.CLAIM))
				else
					var_323_9:setString(arg_327_0._value .. "/" .. var_327_1._val)
				end
			end

			if #var_327_2 > 0 then
				lc.addNodesToCenter(var_323_12, var_327_2, 0)
			end

			lc._runningScene:seenByCamera3D(arg_323_0)
		end

		function arg_323_0.runActionHideToShow()
			arg_323_0:runAction(lc.sequence(function()
				arg_323_0:setEnabled(false)
				var_323_10:setVisible(false)
			end, lc.rotateTo(0.2, {
				z = 0,
				x = 0,
				y = -90
			}), function()
				arg_323_0:setRotation3D({
					z = 0,
					x = 0,
					y = 90
				})
			end, lc.call(function()
				arg_323_0.update(arg_323_0._bonus)
			end), lc.rotateTo(0.2, {
				z = 0,
				x = 0,
				y = 0
			}), function()
				arg_323_0:setEnabled(true)
			end))

			return 0.4
		end

		function arg_323_0.runActionShowToHide()
			arg_323_0:runAction(lc.sequence(function()
				arg_323_0:setEnabled(false)
			end, lc.rotateTo(0.2, {
				z = 0,
				x = 0,
				y = -90
			}), lc.call(function()
				arg_323_0.hide()
			end), lc.rotateTo(0.2, {
				z = 0,
				x = 0,
				y = 0
			}), function()
				arg_323_0:setEnabled(true)
			end))

			return 0.4
		end

		function arg_323_0.runActionUpdateBonus(arg_337_0)
			local var_337_0 = 0

			if arg_323_0._bonus == nil and arg_337_0 ~= nil then
				arg_323_0._bonus = arg_337_0
				var_337_0 = var_337_0 + arg_323_0.runActionHideToShow()
			elseif arg_323_0._bonus ~= nil and arg_337_0 ~= nil then
				arg_323_0._bonus = arg_337_0
				var_337_0 = var_337_0 + arg_323_0.runActionHideToShow()
			elseif arg_323_0._bonus ~= nil and arg_337_0 == nil then
				arg_323_0._bonus = arg_337_0
				var_337_0 = var_337_0 + arg_323_0.runActionShowToHide()
			end

			return var_337_0
		end
	end

	arg_323_0.update(arg_323_1)

	return arg_323_0
end

function var_0_0.tryGotoFindClash(arg_338_0)
	local var_338_0 = require("FindScene").create(Data.FindMatchType.clash)

	if arg_338_0 then
		lc.pushScene(var_338_0)
	else
		lc.replaceScene(var_338_0)
	end

	return true
end

function var_0_0.tryGotoFindLadder(arg_339_0)
	if P:getMaxCharacterLevel() >= Data._globalInfo._unlockLadder then
		local var_339_0 = require("FindScene").create(Data.FindMatchType.ladder)

		if arg_339_0 then
			lc.pushScene(var_339_0)
		else
			lc.replaceScene(var_339_0)
		end

		return true
	else
		local var_339_1 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

		var_339_1:init(false, true)

		function var_339_1.onCleanup(arg_340_0)
			lc.TextureCache:removeTextureForKey("res/jpg/ad_20.jpg")
		end

		local var_339_2 = lc.createSpriteWithMask("res/jpg/ad_20.jpg")

		lc.addChildToCenter(var_339_1, var_339_2)
		var_339_1:show()

		return false
	end
end

function var_0_0.tryGotoUnionBattle(arg_341_0)
	if P:getMaxCharacterLevel() < Data._globalInfo._unlock2v2 then
		local var_341_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

		var_341_0:init(false, true)

		function var_341_0.onCleanup(arg_342_0)
			lc.TextureCache:removeTextureForKey("res/jpg/ad_18.jpg")
		end

		local var_341_1 = lc.createSpriteWithMask("res/jpg/ad_18.jpg")

		lc.addChildToCenter(var_341_0, var_341_1)
		var_341_0:show()

		return false
	end

	local var_341_2 = require("FindScene").create(Data.FindMatchType.union_battle)

	if arg_341_0 then
		lc.pushScene(var_341_2)
	else
		lc.replaceScene(var_341_2)
	end

	return true
end

function var_0_0.tryGotoExpedition(arg_343_0)
	if P:getMaxCharacterLevel() >= Data._globalInfo._unlockExpedition then
		local var_343_0 = require("ExpeditionScene").create(Data.FindMatchType.ladder)

		if arg_343_0 then
			lc.pushScene(var_343_0)
		else
			lc.replaceScene(var_343_0)
		end

		return true
	else
		local var_343_1 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

		var_343_1:init(false, true)

		function var_343_1.onCleanup(arg_344_0)
			lc.TextureCache:removeTextureForKey("res/jpg/ad_25.jpg")
			lc.TextureCache:removeTextureForKey("res/jpg/ad_25_2.jpg")
		end

		local var_343_2 = "ad_25"

		if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_343_2 .. "_2")) then
			var_343_2 = var_343_2 .. "_2"
		end

		if ClientData.isAnotherSkin2() and lc.File:isFileExist(lc.formatJpg(var_343_2 .. "_3")) then
			var_343_2 = var_343_2 .. "_3"
		end

		lc.TextureCache:addImageWithMask(lc.formatJpg(var_343_2))

		local var_343_3 = lc.createSprite(lc.formatJpg(var_343_2))

		lc.addChildToCenter(var_343_1, var_343_3)
		var_343_1:show()

		return false
	end
end

function var_0_0.tryGotoDark(arg_345_0)
	if P:getMaxCharacterLevel() < Data._globalInfo._unlockDark then
		local var_345_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

		var_345_0:init(false, true)

		function var_345_0.onCleanup(arg_346_0)
			lc.TextureCache:removeTextureForKey("res/jpg/ad_dark.jpg")
		end

		local var_345_1 = lc.createSpriteWithMask("res/jpg/ad_dark.jpg")

		lc.addChildToCenter(var_345_0, var_345_1)
		var_345_0:show()

		return false
	end

	local var_345_2 = require("FindScene").create(Data.FindMatchType.dark)

	if arg_345_0 then
		lc.pushScene(var_345_2)
	else
		lc.replaceScene(var_345_2)
	end

	return true
end

function var_0_0.isPackageShowInRareShop(arg_347_0)
	local var_347_0 = Data._rareProductsInfo

	for iter_347_0, iter_347_1 in ipairs(var_347_0) do
		if iter_347_1._type == math.floor(arg_347_0 / 100) then
			return true
		end
	end

	return false
end

function var_0_0.getProbabilityColor(arg_348_0)
	if arg_348_0 < 1 then
		return cc.c3b(1, 92, 253)
	end

	if arg_348_0 < 10 then
		return cc.c3b(0, 255, 66)
	end

	if arg_348_0 < 25 then
		return cc.c3b(255, 233, 1)
	end

	if arg_348_0 < 50 then
		return cc.c3b(203, 0, 253)
	end

	return cc.c3b(255, 56, 68)
end

function var_0_0.createProgressSector(arg_349_0, arg_349_1, arg_349_2, arg_349_3)
	arg_349_1 = arg_349_1 or 360
	arg_349_2 = arg_349_2 or 0

	local var_349_0 = lc.createSprite(arg_349_0)
	local var_349_1 = cc.ProgressTimer:create(var_349_0)

	var_349_1:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	var_349_1:setPercentage(100)

	function var_349_1.setPercentage(arg_350_0, arg_350_1)
		if arg_349_3 then
			cc.ProgressTimer.setPercentage(arg_350_0, (100 - arg_350_1) * arg_349_1 / 360)
		else
			cc.ProgressTimer.setPercentage(arg_350_0, arg_350_1 * arg_349_1 / 360)
		end
	end

	return var_349_1
end

var_0_0.CrownAnis1 = {
	"jhuangguan",
	"yhuangguan",
	"thuangguan",
	"jinbei",
	"yingbei",
	"tongbei",
	"mingrentangjinbei",
	"shijiebeijiangbei"
}
var_0_0.CrownAnis2 = {
	"chuanqiduijue1",
	"chuanqiduijue2",
	"chuanqiduijue3"
}
var_0_0.CrownAnis = {}

for iter_0_0, iter_0_1 in ipairs(var_0_0.CrownAnis1) do
	var_0_0.CrownAnis[7200 + iter_0_0] = iter_0_1
end

for iter_0_2, iter_0_3 in ipairs(var_0_0.CrownAnis2) do
	var_0_0.CrownAnis[7250 + iter_0_2] = iter_0_3
end

function var_0_0.createCrown(arg_351_0, arg_351_1)
	local var_351_0 = var_0_0.CrownAnis[arg_351_0]

	if arg_351_0 == 7201 and arg_351_1 > 9 then
		var_351_0 = "yjhuangguan"
	elseif arg_351_0 == 7202 and arg_351_1 > 9 then
		var_351_0 = "yjhuangguan_yin"
	elseif arg_351_0 == 7203 and arg_351_1 > 9 then
		var_351_0 = "yjhuangguan_tong"
	elseif arg_351_0 == 7204 and arg_351_1 > 9 then
		var_351_0 = "zuanshibei"
	end

	local var_351_1 = cc.DragonBonesNode:createWithDecrypt("res/effects/" .. var_351_0 .. ".lcres", var_351_0, var_351_0)

	var_351_1:gotoAndPlay("effect1")

	var_351_1._infoId = arg_351_0
	var_351_1._num = arg_351_1

	if (arg_351_0 == 7201 or arg_351_0 == 7202 or arg_351_0 == 7203) and arg_351_1 > 9 or arg_351_0 == 7207 or arg_351_0 == 7208 then
		-- block empty
	elseif arg_351_0 == 7204 and arg_351_1 > 9 then
		if arg_351_1 > 10 then
			local var_351_2 = cc.Label:createWithBMFont(ClientView.BMFont.num_24, arg_351_1 - 10)

			lc.addChildToPos(var_351_1, var_351_2, cc.p(lc.cw(var_351_1) + 1, lc.ch(var_351_2) + 0))

			var_351_1._label = var_351_2
		end
	elseif arg_351_1 > 1 then
		local var_351_3 = cc.Label:createWithBMFont(ClientView.BMFont.num_24, arg_351_1)

		lc.addChildToPos(var_351_1, var_351_3, cc.p(lc.cw(var_351_1) - 1, lc.ch(var_351_3) + 0))

		var_351_1._label = var_351_3
	end

	return var_351_1
end

ClientView = var_0_0
return var_0_0
