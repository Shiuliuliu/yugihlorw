local var_0_0 = class("FilterWidget", lc.ExtendUIWidget)

var_0_0.ModeType = {
	hire = 5,
	monster = 1,
	magic = 2,
	skin = 10,
	trap = 3,
	rare = 4,
	illustration = 100
}
var_0_0.SortType = {
	cost = 4,
	quality = 1,
	infoId = 5,
	life = 3,
	power = 2
}
var_0_0.SortFunc = {
	P.sortByQuality,
	P.sortCardsByATK,
	P.sortCardsByHP,
	P.sortCardsByNum,
	P.sortByInfoId
}
var_0_0.SortStr = {
	Str(STR.QUALITY),
	Str(STR.POWER),
	Str(STR.LIFE),
	Str(STR.AMOUNT),
	Str(STR.NEW_OLD)
}
var_0_0.FilterNature = {
	all = 1,
	fire = 5,
	earth = 4,
	water = 6,
	wind = 7,
	light = 2,
	dark = 3,
	god = 8
}
var_0_0.FilterNatureKeyword = {
	-1,
	Data.CardNature.light,
	Data.CardNature.dark,
	Data.CardNature.earth,
	Data.CardNature.fire,
	Data.CardNature.water,
	Data.CardNature.wind,
	Data.CardNature.god
}
var_0_0.FilterNatureStr = {
	Str(STR.ALL_FULL),
	Str(STR.NATURE_LIGHT),
	Str(STR.NATURE_DARK),
	Str(STR.NATURE_EARTH),
	Str(STR.NATURE_FIRE),
	Str(STR.NATURE_WATER),
	Str(STR.NATURE_WIND),
	Str(STR.NATURE_GOD)
}
var_0_0.FilterQuality = {
	all = 1,
	legend = 5,
	saga = 6,
	good = 3,
	rare = 4,
	normal = 2
}
var_0_0.FilterQualityKeyword = {
	-1,
	Data.CardQuality.N,
	Data.CardQuality.R,
	Data.CardQuality.SR,
	Data.CardQuality.UR,
	Data.CardQuality.GR
}
var_0_0.FilterQualityStr = {
	Str(STR.ALL_FULL),
	"N",
	"R",
	"SR",
	"UR",
	"GR"
}
var_0_0.FilterCollect = {
	collected = 2,
	all = 1,
	not_collected = 3
}
var_0_0.FilterCollectKeyword = {
	-1,
	1,
	2
}
var_0_0.FilterCollectStr = {
	Str(STR.ALL_FULL),
	Str(STR.COLLECTED),
	Str(STR.NOT_COLLECTED)
}
var_0_0.FilterLevel = {
	xi = 12,
	iv = 5,
	vi = 7,
	iii = 4,
	vii = 8,
	xii = 13,
	all = 1,
	ii = 3,
	v = 6,
	ix = 10,
	viii = 9,
	x = 11,
	i = 2
}
var_0_0.FilterLevelKeyword = {
	-1,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12
}
var_0_0.FilterLevelStr = {
	Str(STR.ALL_FULL),
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
	"11",
	"12"
}
var_0_0.FilterCategory = {
	insect = 16,
	magician = 2,
	angle = 15,
	all = 1,
	fish = 17,
	undead = 18,
	fire = 20,
	worm = 11,
	beast = 6,
	thund = 22,
	imagery_god = 21,
	sea_dragon = 10,
	devil = 5,
	machinery = 4,
	beast_warrior = 12,
	water = 9,
	creative_god = 21,
	warrior = 7,
	dinosaur = 13,
	bird_beast = 14,
	plant = 19,
	dragon = 3,
	rock = 8,
	spirit_power = 22
}
var_0_0.FilterCategoryKeyword = {
	-1,
	Data.CardCategory.magician,
	Data.CardCategory.dragon,
	Data.CardCategory.machinery,
	Data.CardCategory.devil,
	Data.CardCategory.beast,
	Data.CardCategory.warrior,
	Data.CardCategory.rock,
	Data.CardCategory.water,
	Data.CardCategory.sea_dragon,
	Data.CardCategory.worm,
	Data.CardCategory.beast_warrior,
	Data.CardCategory.dinosaur,
	Data.CardCategory.bird_beast,
	Data.CardCategory.angle,
	Data.CardCategory.insect,
	Data.CardCategory.fish,
	Data.CardCategory.undead,
	Data.CardCategory.plant,
	Data.CardCategory.fire,
	Data.CardCategory.imagery_god,
	Data.CardCategory.thund,
	Data.CardCategory.creative_god,
	Data.CardCategory.spirit_power,
	Data.CardCategory.huanlong
}
var_0_0.FilterCategoryStr = {
	Str(STR.ALL_FULL),
	Str(STR.CARD_CATEGORY_MAGICIAN),
	Str(STR.CARD_CATEGORY_DRAGON),
	Str(STR.CARD_CATEGORY_MACHINERY),
	Str(STR.CARD_CATEGORY_DEVEL),
	Str(STR.CARD_CATEGORY_BEAST),
	Str(STR.CARD_CATEGORY_WARRIOR),
	Str(STR.CARD_CATEGORY_ROCK),
	Str(STR.CARD_CATEGORY_WATER),
	Str(STR.CARD_CATEGORY_SEA_DRAGON),
	Str(STR.CARD_CATEGORY_WORM),
	Str(STR.CARD_CATEGORY_BEAST_WARRIOR),
	Str(STR.CARD_CATEGORY_DINOSAUR),
	Str(STR.CARD_CATEGORY_BIRD_BEAST),
	Str(STR.CARD_CATEGORY_ANGLE),
	Str(STR.CARD_CATEGORY_INSECT),
	Str(STR.CARD_CATEGORY_FISH),
	Str(STR.CARD_CATEGORY_UNDEAD),
	Str(STR.CARD_CATEGORY_PLANT),
	Str(STR.CARD_CATEGORY_FIRE),
	Str(STR.CARD_CATEGORY_IMAGERY_GOD),
	Str(STR.CARD_CATEGORY_THUND),
	Str(STR.CARD_CATEGORY_CREATIVE_GOD),
	Str(STR.CARD_CATEGORY_SPIRIT_POWER),
	Str(STR.CARD_CATEGORY_HUANLONG)
}
var_0_0.FilterMagicOptionKeyword = {
	Data.MagicOption.is_normal,
	Data.MagicOption.is_equipment,
	Data.MagicOption.is_field,
	Data.MagicOption.is_ceremony,
	Data.MagicOption.is_sustainable
}
var_0_0.FilterMagicOptionStr = {
	Str(STR.CARD_MAGIC_OPTION_NORMAL),
	Str(STR.CARD_MAGIC_OPTION_EQUIPMENT),
	Str(STR.CARD_MAGIC_OPTION_FIELD),
	Str(STR.CARD_MAGIC_OPTION_CEREMONY),
	Str(STR.CARD_MAGIC_OPTION_SUSTAINABLE)
}
var_0_0.FilterTrapOptionKeyword = {
	Data.TrapOption.is_normal,
	Data.TrapOption.is_sustainable,
	Data.TrapOption.is_counter,
	Data.TrapOption.is_equipment
}
var_0_0.FilterTrapOptionStr = {
	Str(STR.CARD_TRAP_OPTION_NORMAL),
	Str(STR.CARD_TRAP_OPTION_SUSTAINABLE),
	Str(STR.CARD_TRAP_OPTION_COUNTER),
	Str(STR.CARD_TRAP_OPTION_EQUIPMENT)
}
var_0_0.FilterMonsterOptionKeyword = {
	Data.MonsterOption.is_normal,
	Data.MonsterOption.is_effect,
	Data.MonsterOption.is_spirit,
	Data.MonsterOption.is_ceremony,
	Data.MonsterOption.is_cartoon,
	Data.MonsterOption.is_dual,
	Data.MonsterOption.is_adjust,
	Data.MonsterOption.is_ally_monster
}
var_0_0.FilterMonsterOptionStr = {
	Str(STR.CARD_MONSTER_OPTION_1),
	Str(STR.CARD_MONSTER_OPTION_2),
	Str(STR.CARD_MONSTER_OPTION_8),
	Str(STR.CARD_MONSTER_OPTION_16),
	Str(STR.CARD_MONSTER_OPTION_32),
	Str(STR.CARD_MONSTER_OPTION_64),
	Str(STR.CARD_MONSTER_OPTION_128),
	Str(STR.CARD_MONSTER_OPTION_256)
}
var_0_0.FilterRareOptionStr = {
	Str(STR.CARD_MONSTER_OPTION_4),
	Str(STR.CARD_MONSTER_OPTION_512),
	Str(STR.CARD_MONSTER_OPTION_1024),
	Str(STR.CARD_MONSTER_OPTION_4096),
	Str(STR.CARD_MONSTER_OPTION_8192)
}
var_0_0.FilterRareOptionKeyword = {
	Data.MonsterOption.is_merge,
	Data.MonsterOption.is_sync,
	Data.MonsterOption.is_xyz,
	Data.MonsterOption.is_pendulum,
	Data.MonsterOption.is_link
}
var_0_0.UpdateFlag = {
	filter_type = 8,
	filter_status = 5,
	filter_nature = 2,
	filter_collect = 9,
	search = 7,
	filter_level = 6,
	filter_equip = 3,
	filter_category = 6,
	filter_quality = 4,
	sort = 1
}

local var_0_1 = cc.size(ClientView.AREA_MAX_WIDTH, 46)
local var_0_2 = 140
local var_0_3 = 140
local var_0_4 = 80
local var_0_5 = cc.size(300, 570)
local var_0_6 = cc.size(810, 400)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(var_0_3, arg_1_1)
	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	if arg_2_1 > var_0_0.ModeType.illustration then
		arg_2_1 = arg_2_1 - var_0_0.ModeType.illustration
		arg_2_0._isIllustration = true
	end

	arg_2_0._mode = arg_2_1

	local var_2_0 = lc.h(arg_2_0)
	local var_2_1 = lc.w(arg_2_0) / 2

	if arg_2_0._mode ~= var_0_0.ModeType.skin then
		arg_2_0._btnSort = arg_2_0:createSortButton()

		lc.addChildToPos(arg_2_0, arg_2_0._btnSort, cc.p(var_2_1, var_2_0 - lc.h(arg_2_0._btnSort) / 2))

		var_2_0 = var_2_0 - lc.h(arg_2_0._btnSort) - 20
	end

	arg_2_0._btnFilter = arg_2_0:createFilterButton()

	if arg_2_0._btnFilter then
		arg_2_0._btnFilter._label:setString(Str(STR.FILTER))
		lc.addChildToPos(arg_2_0, arg_2_0._btnFilter, cc.p(var_2_1, var_2_0 - lc.h(arg_2_0._btnFilter) / 2))

		var_2_0 = var_2_0 - lc.h(arg_2_0._btnFilter) - 20
	end

	arg_2_0._searchArea = arg_2_0:createSearchArea()

	lc.addChildToPos(arg_2_0, arg_2_0._searchArea, cc.p(var_2_1, var_2_0 - lc.h(arg_2_0._searchArea) / 2))
end

function var_0_0.createButton(arg_3_0, arg_3_1)
	local var_3_0 = ClientView.createShaderButton("img_filter_bg", arg_3_1)

	var_3_0:setZoomScale(0)

	local var_3_1 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

	lc.addChildToPos(var_3_0, var_3_1, cc.p(lc.w(var_3_0) / 2, lc.h(var_3_0) / 2))

	var_3_0._label = var_3_1

	return var_3_0
end

function var_0_0.createSortButton(arg_4_0)
	arg_4_0._sortTypes = {}

	if not arg_4_0._isIllustration then
		for iter_4_0 = 1, #var_0_0.SortStr do
			if iter_4_0 == var_0_0.SortType.cost then
				table.insert(arg_4_0._sortTypes, iter_4_0)
			elseif iter_4_0 == var_0_0.SortType.quality then
				table.insert(arg_4_0._sortTypes, iter_4_0)
			elseif (iter_4_0 == var_0_0.SortType.power or iter_4_0 == var_0_0.SortType.life) and arg_4_0._mode == var_0_0.ModeType.monster then
				table.insert(arg_4_0._sortTypes, iter_4_0)
			end
		end
	else
		arg_4_0._sortTypes[1] = var_0_0.SortType.infoId
	end

	local var_4_0 = arg_4_0:createButton(function(arg_5_0)
		arg_4_0:showSortTypes()
	end)
	local var_4_1 = var_4_0._label

	lc.offset(var_4_1, -10)

	local var_4_2 = lc.createSprite("img_arrow_down_1")

	var_4_2:setColor(var_4_1:getColor())
	var_4_0:addChild(var_4_2)

	var_4_0._orderArrow = var_4_2

	return var_4_0
end

function var_0_0.createFilterButton(arg_6_0)
	if arg_6_0._mode == var_0_0.ModeType.monster or arg_6_0._mode == var_0_0.ModeType.rare or arg_6_0._mode == var_0_0.ModeType.hire or arg_6_0._mode == var_0_0.ModeType.skin then
		arg_6_0._filterNatureTypes = {}

		for iter_6_0 = 1, #var_0_0.FilterNatureStr do
			table.insert(arg_6_0._filterNatureTypes, iter_6_0)
		end

		arg_6_0._filterCategoryTypes = {}

		for iter_6_1 = 1, #var_0_0.FilterCategoryStr do
			table.insert(arg_6_0._filterCategoryTypes, iter_6_1)
		end

		arg_6_0._filterLevelTypes = {}

		for iter_6_2 = 1, #var_0_0.FilterLevelStr do
			table.insert(arg_6_0._filterLevelTypes, iter_6_2)
		end
	end

	if arg_6_0._mode == var_0_0.ModeType.monster then
		arg_6_0._filterMonsterOptions = {}

		for iter_6_3 = 1, #var_0_0.FilterMonsterOptionStr do
			table.insert(arg_6_0._filterMonsterOptions, iter_6_3)
		end
	elseif arg_6_0._mode == var_0_0.ModeType.magic then
		arg_6_0._filterMagicOptions = {}

		for iter_6_4 = 1, #var_0_0.FilterMagicOptionStr do
			table.insert(arg_6_0._filterMagicOptions, iter_6_4)
		end
	elseif arg_6_0._mode == var_0_0.ModeType.trap then
		arg_6_0._filterTrapOptions = {}

		for iter_6_5 = 1, #var_0_0.FilterTrapOptionStr do
			table.insert(arg_6_0._filterTrapOptions, iter_6_5)
		end
	elseif arg_6_0._mode == var_0_0.ModeType.rare then
		arg_6_0._filterRareOptions = {}

		for iter_6_6 = 1, #var_0_0.FilterRareOptionStr do
			table.insert(arg_6_0._filterRareOptions, iter_6_6)
		end
	end

	if not arg_6_0._isIllustration then
		arg_6_0._filterQualityTypes = {}

		for iter_6_7 = 1, #var_0_0.FilterQualityStr do
			table.insert(arg_6_0._filterQualityTypes, iter_6_7)
		end
	end

	arg_6_0._filterCollectTypes = {}

	for iter_6_8 = 1, #var_0_0.FilterCollectStr do
		table.insert(arg_6_0._filterCollectTypes, iter_6_8)
	end

	if arg_6_0._filterNatureTypes or arg_6_0._filterCategoryTypes or arg_6_0._filterQualityTypes or arg_6_0._filterMagicOptions or arg_6_0._filterTrapOptions or arg_6_0._filterCollectTypes then
		return arg_6_0:createButton(function(arg_7_0)
			if BasePanel._topMostPanel then
				BasePanel.hideTopMost()
				return
			end
			arg_6_0:showFilterTypes()
		end)
	end

	return nil
end

function var_0_0.createSearchArea(arg_8_0)
	local var_8_0 = lc.createSprite("img_filter_bg")
	local var_8_1 = ClientView.createEditBox("img_com_bg_26", ClientView.CRECT_COM_BG26, cc.size(var_0_4, ClientView.CRECT_COM_BG26.height), "", true, 10)

	var_8_1:setFontColor(lc.Color4B.white)
	lc.addChildToPos(var_8_0, var_8_1, cc.p(lc.w(var_8_0) / 2 - 20, lc.h(var_8_0) / 2))

	var_8_0._editBox = var_8_1

	local var_8_2 = ClientView.createShaderButton("img_icon_search", function(arg_9_0)
		arg_8_0:onSearch()
	end)

	lc.addChildToPos(var_8_0, var_8_2, cc.p(lc.right(var_8_1) + lc.w(var_8_2) / 2 + 4, lc.h(var_8_0) / 2))
	var_8_2:setTouchRect(cc.rect(-20, -20, lc.w(var_8_2) + 40, lc.h(var_8_2) + 40))

	var_8_0._button = var_8_2
	arg_8_0._searchText = ""

	return var_8_0
end

function var_0_0.setSort(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._btnSort == nil then
		return
	end

	if arg_10_0._sort == arg_10_1 and arg_10_0._isAscending == arg_10_2 then
		return
	end

	local var_10_0 = arg_10_0._btnSort._label

	var_10_0:setString(var_0_0.SortStr[arg_10_1])

	local var_10_1 = arg_10_0._btnSort._orderArrow

	var_10_1:setSpriteFrame(arg_10_2 and "img_arrow_up_1" or "img_arrow_down_1")
	var_10_1:setPosition(lc.right(var_10_0) + 6 + lc.w(var_10_1) / 2, lc.y(var_10_0))

	arg_10_0._sort = arg_10_1
	arg_10_0._isAscending = arg_10_2

	if arg_10_0._sortFilterHandler then
		arg_10_0._sortFilterHandler(var_0_0.UpdateFlag.sort)
	end
end

function var_0_0.getSortFunc(arg_11_0)
	if arg_11_0._sort ~= nil then
		return var_0_0.SortFunc[arg_11_0._sort], arg_11_0._isAscending
	end
end

function var_0_0.setFilterNature(arg_12_0, arg_12_1)
	if arg_12_0._filterNature == arg_12_1 then
		return
	end

	arg_12_0._filterNature = arg_12_1

	if arg_12_0._sortFilterHandler then
		arg_12_0._sortFilterHandler(var_0_0.UpdateFlag.filter_nature)
	end
end

function var_0_0.getFilterNatureFunc(arg_13_0)
	if arg_13_0._filterNature ~= nil then
		local var_13_0 = var_0_0.FilterNatureKeyword[arg_13_0._filterNature]

		if var_13_0 >= 0 then
			return P.filterByNature, var_13_0
		end
	end
end

function var_0_0.setFilterLevel(arg_14_0, arg_14_1)
	if arg_14_0._filterLevel == arg_14_1 then
		return
	end

	arg_14_0._filterLevel = arg_14_1

	if arg_14_0._sortFilterHandler then
		arg_14_0._sortFilterHandler(var_0_0.UpdateFlag.filter_level)
	end
end

function var_0_0.getFilterLevelFunc(arg_15_0)
	if arg_15_0._filterLevel ~= nil then
		local var_15_0 = var_0_0.FilterLevelKeyword[arg_15_0._filterLevel]

		if var_15_0 >= 0 then
			return P.filterByLevel, var_15_0
		end
	end
end

function var_0_0.setFilterQuality(arg_16_0, arg_16_1)
	if arg_16_0._filterQuality == arg_16_1 then
		return
	end

	arg_16_0._filterQuality = arg_16_1

	if arg_16_0._sortFilterHandler then
		arg_16_0._sortFilterHandler(var_0_0.UpdateFlag.filter_quality)
	end
end

function var_0_0.getFilterQualityFunc(arg_17_0)
	if arg_17_0._filterQuality ~= nil then
		local var_17_0 = var_0_0.FilterQualityKeyword[arg_17_0._filterQuality]

		if var_17_0 >= 0 then
			return P.filterByQuality, var_17_0
		end
	end
end

function var_0_0.setFilterCollect(arg_18_0, arg_18_1)
	if arg_18_0._filterCollect == arg_18_1 then
		return
	end

	arg_18_0._filterCollect = arg_18_1

	if arg_18_0._sortFilterHandler then
		arg_18_0._sortFilterHandler(var_0_0.UpdateFlag.filter_collect)
	end
end

function var_0_0.getFilterCollectFunc(arg_19_0)
	if arg_19_0._filterCollect ~= nil then
		local var_19_0 = var_0_0.FilterCollectKeyword[arg_19_0._filterCollect]

		if var_19_0 >= 0 then
			return P.filterByCollect, var_19_0
		end
	end
end

function var_0_0.setFilterCategory(arg_20_0, arg_20_1)
	if arg_20_0._filterCategory == arg_20_1 then
		return
	end

	arg_20_0._filterCategory = arg_20_1

	if arg_20_0._sortFilterHandler then
		arg_20_0._sortFilterHandler(var_0_0.UpdateFlag.filter_category)
	end
end

function var_0_0.getFilterCategoryFunc(arg_21_0, arg_21_1)
	if arg_21_0._filterCategory ~= nil then
		local var_21_0 = var_0_0.FilterCategoryKeyword[arg_21_0._filterCategory]

		if var_21_0 >= 0 then
			return P.filterByCategory, var_21_0
		end
	end
end

function var_0_0.setFilterOption(arg_22_0, arg_22_1)
	arg_22_0._filterOption = arg_22_0._filterOption or {}

	if arg_22_0._filterOption[arg_22_1] then
		arg_22_0._filterOption[arg_22_1] = nil
	else
		arg_22_0._filterOption[arg_22_1] = 1
	end

	if arg_22_0._sortFilterHandler then
		arg_22_0._sortFilterHandler(var_0_0.UpdateFlag.filter_type)
	end
end

function var_0_0.getFilterMonsterOptionFunc(arg_23_0)
	local var_23_0 = 0

	if arg_23_0._filterOption ~= nil then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._filterOption) do
			local var_23_1 = var_0_0.FilterMonsterOptionKeyword[iter_23_0]

			if var_23_1 >= 0 then
				var_23_0 = bor(var_23_0, var_23_1)
			end
		end
	end

	if var_23_0 > 0 then
		return P.filterByOption, var_23_0
	end
end

function var_0_0.getFilterMagicOptionFunc(arg_24_0)
	local var_24_0 = 0

	if arg_24_0._filterOption ~= nil then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._filterOption) do
			local var_24_1 = var_0_0.FilterMagicOptionKeyword[iter_24_0]

			if var_24_1 >= 0 then
				var_24_0 = bor(var_24_0, var_24_1)
			end
		end
	end

	if var_24_0 > 0 then
		return P.filterByOption, var_24_0
	end
end

function var_0_0.getFilterTrapOptionFunc(arg_25_0)
	local var_25_0 = 0

	if arg_25_0._filterOption ~= nil then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._filterOption) do
			local var_25_1 = var_0_0.FilterTrapOptionKeyword[iter_25_0]

			if var_25_1 >= 0 then
				var_25_0 = bor(var_25_0, var_25_1)
			end
		end
	end

	if var_25_0 > 0 then
		return P.filterByOption, var_25_0
	end
end

function var_0_0.getFilterRareOptionFunc(arg_26_0)
	local var_26_0 = 0

	if arg_26_0._filterOption ~= nil then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._filterOption) do
			local var_26_1 = var_0_0.FilterRareOptionKeyword[iter_26_0]

			if var_26_1 >= 0 then
				var_26_0 = bor(var_26_0, var_26_1)
			end
		end
	end

	if var_26_0 > 0 then
		return P.filterByOption, var_26_0
	end
end

function var_0_0.getFilterSearchFunc(arg_27_0)
	if arg_27_0._searchText ~= "" then
		return P.filterBySearch, arg_27_0._searchText
	end
end

function var_0_0.registerSortFilterHandler(arg_28_0, arg_28_1)
	arg_28_0._sortFilterHandler = arg_28_1
end

function var_0_0.showSortTypes(arg_29_0)
	local function var_29_0(arg_30_0, arg_30_1)
		local var_30_0 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_0_0.SortStr[arg_29_0._sortTypes[arg_30_0]])
		local var_30_1 = cc.Sprite:createWithSpriteFrameName(arg_30_1 and "img_arrow_up_1" or "img_arrow_down_1")
		local var_30_2 = lc.w(var_30_0) + 6 + lc.w(var_30_1)
		local var_30_3 = lc.h(var_30_0)
		local var_30_4 = lc.createNode(cc.size(var_30_2, var_30_3))

		lc.addChildToPos(var_30_4, var_30_0, cc.p(lc.w(var_30_0) / 2, var_30_3 / 2))
		lc.addChildToPos(var_30_4, var_30_1, cc.p(var_30_2 - lc.w(var_30_1) / 2, var_30_3 / 2))

		return var_30_4
	end

	local var_29_1 = {}

	for iter_29_0 = 1, #arg_29_0._sortTypes do
		table.insert(var_29_1, {
			_area = var_29_0(iter_29_0, true),
			_handler = function(arg_31_0)
				arg_29_0:setSort(arg_29_0._sortTypes[iter_29_0], true)
			end
		})
		table.insert(var_29_1, {
			_area = var_29_0(iter_29_0, false),
			_handler = function(arg_32_0)
				arg_29_0:setSort(arg_29_0._sortTypes[iter_29_0], false)
			end
		})
	end

	arg_29_0:showPopPanel(arg_29_0._btnSort, var_29_1)
end

function var_0_0.showFilterTypes(arg_33_0)
	local var_33_0 = {}

	if arg_33_0._filterCollectTypes then
		local var_33_1 = {
			_curFilters = {}
		}

		for iter_33_0 = 1, #arg_33_0._filterCollectTypes do
			local var_33_2 = arg_33_0._filterCollectTypes[iter_33_0]

			table.insert(var_33_1, {
				_str = var_0_0.FilterCollectStr[var_33_2],
				_handler = function(arg_34_0)
					arg_33_0:setFilterCollect(var_33_2)

					var_33_1._curFilters[1] = iter_33_0
				end
			})

			if var_33_2 == arg_33_0._filterCollect then
				var_33_1._curFilters[1] = iter_33_0
			end
		end

		var_33_1._titleStr = Str(STR.COLLECT_2)

		table.insert(var_33_0, var_33_1)
	end

	if arg_33_0._filterQualityTypes then
		local var_33_3 = {
			_curFilters = {}
		}

		for iter_33_1 = 1, #arg_33_0._filterQualityTypes do
			local var_33_4 = arg_33_0._filterQualityTypes[iter_33_1]

			table.insert(var_33_3, {
				_str = var_0_0.FilterQualityStr[var_33_4],
				_handler = function(arg_35_0)
					arg_33_0:setFilterQuality(var_33_4)

					var_33_3._curFilters[1] = iter_33_1
				end
			})

			if var_33_4 == arg_33_0._filterQuality then
				var_33_3._curFilters[1] = iter_33_1
			end
		end

		var_33_3._titleStr = Str(STR.QUALITY)

		table.insert(var_33_0, var_33_3)
	end

	if arg_33_0._filterLevelTypes then
		local var_33_5 = {
			_curFilters = {}
		}

		for iter_33_2 = 1, #arg_33_0._filterLevelTypes do
			local var_33_6 = arg_33_0._filterLevelTypes[iter_33_2]

			table.insert(var_33_5, {
				_str = var_0_0.FilterLevelStr[var_33_6],
				_handler = function(arg_36_0)
					arg_33_0:setFilterLevel(var_33_6)

					var_33_5._curFilters[1] = iter_33_2
				end
			})

			if var_33_6 == arg_33_0._filterLevel then
				var_33_5._curFilters[1] = iter_33_2
			end
		end

		var_33_5._titleStr = Str(STR.CARD_LEVEL)

		table.insert(var_33_0, var_33_5)
	end

	if arg_33_0._filterNatureTypes then
		local var_33_7 = {
			_curFilters = {}
		}

		for iter_33_3 = 1, #arg_33_0._filterNatureTypes do
			local var_33_8 = arg_33_0._filterNatureTypes[iter_33_3]

			table.insert(var_33_7, {
				_str = var_0_0.FilterNatureStr[var_33_8],
				_handler = function(arg_37_0)
					arg_33_0:setFilterNature(var_33_8)

					var_33_7._curFilters[1] = iter_33_3
				end
			})

			if var_33_8 == arg_33_0._filterNature then
				var_33_7._curFilters[1] = iter_33_3
			end
		end

		var_33_7._titleStr = "Thuộc tính"

		table.insert(var_33_0, var_33_7)
	end

	if arg_33_0._filterCategoryTypes then
		local var_33_9 = {
			_curFilters = {}
		}

		for iter_33_4 = 1, #arg_33_0._filterCategoryTypes do
			local var_33_10 = arg_33_0._filterCategoryTypes[iter_33_4]

			table.insert(var_33_9, {
				_str = var_0_0.FilterCategoryStr[var_33_10],
				_handler = function(arg_38_0)
					arg_33_0:setFilterCategory(var_33_10)

					var_33_9._curFilters[1] = iter_33_4
				end
			})

			if var_33_10 == arg_33_0._filterCategory then
				var_33_9._curFilters[1] = iter_33_4
			end
		end

		var_33_9._titleStr = "Chủng tộc"

		table.insert(var_33_0, var_33_9)
	end

	if arg_33_0._filterMonsterOptions then
		local var_33_11 = {
			_curFilters = {}
		}

		for iter_33_5 = 1, #arg_33_0._filterMonsterOptions do
			local var_33_12 = arg_33_0._filterMonsterOptions[iter_33_5]

			table.insert(var_33_11, {
				_str = var_0_0.FilterMonsterOptionStr[var_33_12],
				_handler = function(arg_39_0)
					arg_33_0:setFilterOption(var_33_12)

					var_33_11._curFilters = {}

					if arg_33_0._filterOption then
						for iter_39_0, iter_39_1 in pairs(arg_33_0._filterOption) do
							var_33_11._curFilters[#var_33_11._curFilters + 1] = iter_39_0
						end
					end
				end
			})

			if arg_33_0._filterOption and arg_33_0._filterOption[var_33_12] then
				var_33_11._curFilters[#var_33_11._curFilters + 1] = iter_33_5
			end
		end

		var_33_11._titleStr = Str(STR.TYPE)

		table.insert(var_33_0, var_33_11)
	elseif arg_33_0._filterMagicOptions then
		local var_33_13 = {
			_curFilters = {}
		}

		for iter_33_6 = 1, #arg_33_0._filterMagicOptions do
			local var_33_14 = arg_33_0._filterMagicOptions[iter_33_6]

			table.insert(var_33_13, {
				_str = var_0_0.FilterMagicOptionStr[var_33_14],
				_handler = function(arg_40_0)
					arg_33_0:setFilterOption(var_33_14)

					var_33_13._curFilters = {}

					if arg_33_0._filterOption then
						for iter_40_0, iter_40_1 in pairs(arg_33_0._filterOption) do
							var_33_13._curFilters[#var_33_13._curFilters + 1] = iter_40_0
						end
					end
				end
			})

			if arg_33_0._filterOption and arg_33_0._filterOption[var_33_14] then
				var_33_13._curFilters[#var_33_13._curFilters + 1] = iter_33_6
			end
		end

		var_33_13._titleStr = Str(STR.TYPE)

		table.insert(var_33_0, var_33_13)
	elseif arg_33_0._filterTrapOptions then
		local var_33_15 = {
			_curFilters = {}
		}

		for iter_33_7 = 1, #arg_33_0._filterTrapOptions do
			local var_33_16 = arg_33_0._filterTrapOptions[iter_33_7]

			table.insert(var_33_15, {
				_str = var_0_0.FilterTrapOptionStr[var_33_16],
				_handler = function(arg_41_0)
					arg_33_0:setFilterOption(var_33_16)

					var_33_15._curFilters = {}

					if arg_33_0._filterOption then
						for iter_41_0, iter_41_1 in pairs(arg_33_0._filterOption) do
							var_33_15._curFilters[#var_33_15._curFilters + 1] = iter_41_0
						end
					end
				end
			})

			if arg_33_0._filterOption and arg_33_0._filterOption[var_33_16] then
				var_33_15._curFilters[#var_33_15._curFilters + 1] = iter_33_7
			end
		end

		var_33_15._titleStr = Str(STR.TYPE)

		table.insert(var_33_0, var_33_15)
	elseif arg_33_0._filterRareOptions then
		local var_33_17 = {
			_curFilters = {}
		}

		for iter_33_8 = 1, #arg_33_0._filterRareOptions do
			local var_33_18 = arg_33_0._filterRareOptions[iter_33_8]

			table.insert(var_33_17, {
				_str = var_0_0.FilterRareOptionStr[var_33_18],
				_handler = function(arg_42_0)
					arg_33_0:setFilterOption(var_33_18)

					var_33_17._curFilters = {}

					if arg_33_0._filterOption then
						for iter_42_0, iter_42_1 in pairs(arg_33_0._filterOption) do
							var_33_17._curFilters[#var_33_17._curFilters + 1] = iter_42_0
						end
					end
				end
			})

			if arg_33_0._filterOption and arg_33_0._filterOption[var_33_18] then
				var_33_17._curFilters[#var_33_17._curFilters + 1] = iter_33_8
			end
		end

		var_33_17._titleStr = Str(STR.TYPE)

		table.insert(var_33_0, var_33_17)
	end

	arg_33_0:showFilterPanel(arg_33_0._btnFilter, var_33_0)
end

function var_0_0.showPopPanel(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = require("TopMostPanel").ButtonList.create(var_0_5)

	if var_43_0 then
		local var_43_1 = lc.convertPos(cc.p(0, lc.h(arg_43_1)), arg_43_1)

		var_43_0:setButtonDefs(arg_43_2)
		var_43_0:setPosition(var_43_1.x - lc.w(var_43_0) / 2 - 20, var_43_1.y - lc.h(var_43_0) / 2 + 40)
		var_43_0:linkNode(arg_43_1)
		var_43_0:show()

		local var_43_2 = lc.createSprite("img_arrow_right_02")

		lc.addChildToPos(var_43_0, var_43_2, cc.p(lc.w(var_43_0) + lc.w(var_43_2) / 2 - 1, lc.h(var_43_0) - 40 - lc.h(arg_43_1) / 2))
	end
end

function var_0_0.showFilterPanel(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = require("TopMostPanel").FilterList.create(var_0_6)

	if var_44_0 then
		var_44_0:setButtonDefs(arg_44_2)

		local var_44_1 = lc.convertPos(cc.p(0, lc.h(arg_44_1)), arg_44_1)
		local var_44_2 = 20
		local var_44_3 = var_44_1.y - lc.ch(var_44_0) + var_44_2

		if var_44_3 - lc.ch(var_44_0) < 10 then
			var_44_3 = 10 + lc.ch(var_44_0)
			var_44_2 = lc.h(var_44_0) - var_44_1.y + 10
		elseif var_44_3 + lc.ch(var_44_0) > ClientView.SCR_H - 10 then
			var_44_3 = ClientView.SCR_H - 10 - lc.ch(var_44_0)
			var_44_2 = ClientView.SCR_H - var_44_1.y - 10
		end

		var_44_0:setPosition(var_44_1.x - lc.cw(var_44_0) - 20, var_44_3)
		var_44_0:linkNode(arg_44_1)
		var_44_0:show()

		local var_44_4 = lc.createSprite("img_arrow_right_02")

		lc.addChildToPos(var_44_0, var_44_4, cc.p(lc.w(var_44_0) + lc.cw(var_44_4) - 1, lc.h(var_44_0) - var_44_2 - lc.ch(arg_44_1)))
	end
end

function var_0_0.onSearch(arg_45_0)
	arg_45_0._searchText = arg_45_0._searchArea._editBox:getText()

	if arg_45_0._sortFilterHandler then
		arg_45_0._sortFilterHandler(var_0_0.UpdateFlag.search)
	end
end

function var_0_0.resetAllFilter(arg_46_0)
	arg_46_0:setSort(var_0_0.SortType.quality)
	arg_46_0:setFilterQuality(var_0_0.FilterQuality.all)
	arg_46_0:setFilterCollect(var_0_0.FilterCollect.all)

	if arg_46_0._mode == var_0_0.ModeType.monster or arg_46_0._mode == var_0_0.ModeType.rare then
		arg_46_0:setFilterCategory(var_0_0.FilterCategory.all)
		arg_46_0:setFilterLevel(var_0_0.FilterLevel.all)
		arg_46_0:setFilterNature(var_0_0.FilterNature.all)
	end
end

return var_0_0
