import os, sys, re

sys.stdout.reconfigure(encoding='utf-8')

# 1. web/data/rare.lua (Wither 40748)
RARE_LUA = r"D:\yugitauapk\web\data\rare.lua"
with open(RARE_LUA, 'r', encoding='utf-8') as f:
    rare_content = f.read()

wither_rare_str = """  [40748]={["_atk"]={[1]=3000,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57338,["_category"]=17,["_cost"]=0,["_descSid"]=57337,["_guideSid"]=0,["_hp"]={[1]=0,},
  ["_id"]=40748,["_isHide"]=0,["_joinComponent"]={[1]=0,},
  ["_joinResult"]={[1]=0,},
  ["_keyword"]=304,["_link"]={[1]=1,[2]=2,[3]=3,},
  ["_linkAllCandidates"]="0.0",["_linkCandidate"]="0.0",["_linkCount"]="#>=2",["_linkSelectedCandidates"]="0.0",["_maxCount"]=3,["_nameSid"]=57336,["_nature"]=2,["_option"]=8194,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="wither",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=12007,[2]=14796,},
  ["_skin"]={[1]=0,},
  ["_star"]=0,["_syncComponent"]={[1]={[1]=0,},},},
"""

if '[40748]=' not in rare_content:
    last_brace = rare_content.rfind('}')
    if last_brace != -1:
        rare_content = rare_content[:last_brace] + wither_rare_str + rare_content[last_brace:]
        with open(RARE_LUA, 'w', encoding='utf-8') as f:
            f.write(rare_content)
        print("[OK] Added Wither 40748 to rare.lua")
    else:
        print("[ERR] last_brace not found in rare.lua")
else:
    print("[SKIP] rare.lua already has 40748")

# 2. web/data/skill.lua (Skill 14796)
SKILL_LUA = r"D:\yugitauapk\web\data\skill.lua"
with open(SKILL_LUA, 'r', encoding='utf-8') as f:
    sk_content = f.read()

wither_sk_str = """  [14796]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57340,["_effectVal"]={[1]=0,},
  ["_id"]=14796,["_isIgnoreDefend"]=1,["_modes"]={[1]=2,[2]=131,[3]=132,},
  ["_nameSid"]=57339,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=0,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
"""

if '[14796]=' not in sk_content:
    last_brace = sk_content.rfind('}')
    if last_brace != -1:
        sk_content = sk_content[:last_brace] + wither_sk_str + sk_content[last_brace:]
        with open(SKILL_LUA, 'w', encoding='utf-8') as f:
            f.write(sk_content)
        print("[OK] Added skill 14796 to skill.lua")
    else:
        print("[ERR] last_brace not found in skill.lua")
else:
    print("[SKIP] skill.lua already has 14796")

# 3. web/data/diamond_products.lua
DIA_LUA = r"D:\yugitauapk\web\data\diamond_products.lua"
with open(DIA_LUA, 'r', encoding='utf-8') as f:
    dia_content = f.read()

product_553_str = '  [553]={["_cardId"]=40748,["_cost"]=10000,["_date"]="20240101.0",["_id"]=553,["_resType"]=3,["_type"]=0,},\n'
if '[553]=' not in dia_content and '40748' not in dia_content:
    last_brace = dia_content.rfind('}')
    if last_brace != -1:
        dia_content = dia_content[:last_brace] + product_553_str + dia_content[last_brace:]
        with open(DIA_LUA, 'w', encoding='utf-8') as f:
            f.write(dia_content)
        print("[OK] Updated diamond_products.lua with product 553")
else:
    print("[SKIP] diamond_products.lua already has 553")

# 4. web/src/Data.lua
DATA_LUA = r"D:\yugitauapk\web\src\Data.lua"
with open(DATA_LUA, 'r', encoding='utf-8') as f:
    data_content = f.read()

if 'arg_13_0 == 14796' not in data_content:
    target_data_halo = 'or arg_13_0 == 14795 then'
    repl_data_halo = 'or arg_13_0 == 14795 or arg_13_0 == 14796 then'
    if target_data_halo in data_content:
        data_content = data_content.replace(target_data_halo, repl_data_halo, 1)
        with open(DATA_LUA, 'w', encoding='utf-8') as f:
            f.write(data_content)
        print("[OK] Data.lua monster4Halo updated for 14796")
    else:
        print("[ERR] target_data_halo not found in Data.lua")
else:
    print("[SKIP] Data.lua already has 14796")

# 5. web/src/BattleHelper.lua (Link material candidate and validation for 40748)
BH_LUA = r"D:\yugitauapk\web\src\BattleHelper.lua"
with open(BH_LUA, 'r', encoding='utf-8') as f:
    bh_content = f.read()

# in getLinkCandidates
if 'arg_260_1._infoId == 40748' not in bh_content:
    target_bh_cand = '	if arg_260_1._infoId == 40709 then'
    repl_bh_cand = """	if arg_260_1._infoId == 40748 then
		var_260_1 = B.filterInKeywordCards(var_260_1, 304)
	end

	if arg_260_1._infoId == 40709 then"""
    if target_bh_cand in bh_content:
        bh_content = bh_content.replace(target_bh_cand, repl_bh_cand, 1)
        print("[OK] BattleHelper.lua getLinkCandidates updated for 40748")
    else:
        target_bh_cand_crlf = target_bh_cand.replace('\n', '\r\n')
        if target_bh_cand_crlf in bh_content:
            bh_content = bh_content.replace(target_bh_cand_crlf, repl_bh_cand.replace('\n', '\r\n'), 1)
            print("[OK] BattleHelper.lua (CRLF) getLinkCandidates updated for 40748")
        else:
            print("[ERR] target_bh_cand not found in BattleHelper.lua")

# in canLink validation
bh_canlink_40748 = """		if arg_261_1._infoId == 40748 then
			if #arg_261_2 < 2 then
				return false
			end
			for _, c in ipairs(arg_261_2) do
				if not (c:isKeyword(304) or (c._info and c._info._keyword == 304)) then
					return false
				end
			end
			local function checkSum(idx, curSum)
				if curSum > 3 then return false end
				if idx > #arg_261_2 then return curSum == 3 end
				local card = arg_261_2[idx]
				local linkVal = card:getLink()
				if checkSum(idx + 1, curSum + 1) then return true end
				if linkVal > 1 and checkSum(idx + 1, curSum + linkVal) then return true end
				return false
			end
			if not checkSum(1, 0) then
				return false
			end
			if var_261_4 and #B.filterLinkPosCards(arg_261_2, true) == 0 then
				return false
			end
			return true
		end
"""

if 'if arg_261_1._infoId == 40748 then' not in bh_content:
    target_canlink = '		if arg_261_1._infoId == 40746 then'
    if target_canlink in bh_content:
        bh_content = bh_content.replace(target_canlink, bh_canlink_40748 + target_canlink, 1)
        print("[OK] BattleHelper.lua canLink validation updated for 40748")
    else:
        target_canlink_crlf = target_canlink.replace('\n', '\r\n')
        if target_canlink_crlf in bh_content:
            bh_content = bh_content.replace(target_canlink_crlf, bh_canlink_40748.replace('\n', '\r\n') + target_canlink_crlf, 1)
            print("[OK] BattleHelper.lua (CRLF) canLink validation updated for 40748")
        else:
            print("[ERR] target_canlink not found in BattleHelper.lua")

# in canLink search branch
bh_canlink_search_40748 = """		if arg_261_1._infoId == 40748 then
			local validCards = {}
			for _, c in ipairs(arg_261_2) do
				if c:isKeyword(304) or (c._info and c._info._keyword == 304) then
					table.insert(validCards, c)
				end
			end
			if #validCards < 2 or B.getSumLink(validCards) < 3 then
				return false
			end
			for k = 2, math.min(3, #validCards) do
				local i_comb = 1
				while true do
					local comb = B.combinateTable(validCards, k, i_comb)
					if comb == nil then break end
					if canCardsAchieveLink(comb, 3) and (not var_261_4 or #B.filterLinkPosCards(comb, true) > 0) then
						if arg_261_4 then
							local var_261_6 = arg_261_1:getSkillIndexById(9298) or 1
							local var_261_7 = B.getChoiceByCandidatePos(arg_261_2, comb)
							return true, nil, var_261_6 * BattleData.ChoiceId.stage_3 + var_261_7 * BattleData.ChoiceId.stage_2, comb
						else
							return true
						end
					end
					i_comb = i_comb + 1
					if i_comb > 500 then break end
				end
			end
			return false
		end
"""

if 'B.getSumLink(validCards) < 3' not in bh_content:
    target_search = '		if arg_261_1._infoId == 40746 then'
    # Find the second occurrence of target_search
    pos1 = bh_content.find(target_search)
    if pos1 != -1:
        pos2 = bh_content.find(target_search, pos1 + len(target_search))
        if pos2 != -1:
            bh_content = bh_content[:pos2] + bh_canlink_search_40748 + bh_content[pos2:]
            print("[OK] BattleHelper.lua canLink search branch updated for 40748")
        else:
            print("[ERR] second occurrence of target_search not found in BattleHelper.lua")
    else:
        # Check CRLF
        target_search_crlf = target_search.replace('\n', '\r\n')
        pos1 = bh_content.find(target_search_crlf)
        if pos1 != -1:
            pos2 = bh_content.find(target_search_crlf, pos1 + len(target_search_crlf))
            if pos2 != -1:
                bh_content = bh_content[:pos2] + bh_canlink_search_40748.replace('\n', '\r\n') + bh_content[pos2:]
                print("[OK] BattleHelper.lua (CRLF) canLink search branch updated for 40748")
            else:
                print("[ERR] second occurrence (CRLF) not found")

with open(BH_LUA, 'w', encoding='utf-8') as f:
    f.write(bh_content)

# 6. web/src/BattleCard.lua (getAtk continuous half logic)
BC_LUA = r"D:\yugitauapk\web\src\BattleCard.lua"
with open(BC_LUA, 'r', encoding='utf-8') as f:
    bc_content = f.read()

bc_getatk_wither = """	if arg_282_0._witherDebuffed then
		return arg_282_0._atk
	end
	local owner = arg_282_0._owner
	local oppo = owner and owner._opponent
	local hasWither = (owner and owner._hasWitherOnBoard) or (oppo and oppo._hasWitherOnBoard)
	if hasWither and arg_282_0._status == BattleData.CardStatus.board then
		local isUndead = (arg_282_0._category == 17) or (arg_282_0._info and arg_282_0._info._category == 17)
		if not isUndead then
			return math.floor((arg_282_0._atk or arg_282_0._maxAtk or 0) / 2)
		end
	end
"""

if 'local hasWither = (owner and owner._hasWitherOnBoard)' not in bc_content:
    target_getatk = 'function var_0_0.getAtk(arg_282_0)\n'
    if target_getatk in bc_content:
        bc_content = bc_content.replace(target_getatk, target_getatk + bc_getatk_wither, 1)
        print("[OK] BattleCard.lua getAtk updated with Wither debuff check")
    else:
        target_getatk_crlf = 'function var_0_0.getAtk(arg_282_0)\r\n'
        if target_getatk_crlf in bc_content:
            bc_content = bc_content.replace(target_getatk_crlf, target_getatk_crlf + bc_getatk_wither.replace('\n', '\r\n'), 1)
            print("[OK] BattleCard.lua (CRLF) getAtk updated with Wither debuff check")
        else:
            print("[ERR] target_getatk not found in BattleCard.lua")

with open(BC_LUA, 'w', encoding='utf-8') as f:
    f.write(bc_content)

# 7. web/src/BattleCardStatus.lua (Wither entry & halving)
BCS_LUA = r"D:\yugitauapk\web\src\BattleCardStatus.lua"
with open(BCS_LUA, 'r', encoding='utf-8') as f:
    bcs_content = f.read()

bcs_wither = """			if arg_15_1._infoId == 40748 or arg_15_1:isInfoId(40748) then
				arg_15_0._hasWitherOnBoard = true
				arg_15_0:incShield(arg_15_1, { 12007 }, false, false, arg_15_1._id, 12007, Data.SkillMode.using)
				local oppo = arg_15_0._opponent
				local allBoardCards = B.mergeTable({ arg_15_0:getBoardCards(), oppo and oppo:getBoardCards() or {} })
				for _, c in ipairs(allBoardCards) do
					if c ~= arg_15_1 and (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster) then
						local isUndead = (c._category == 17) or (c._info and c._info._category == 17)
						if not isUndead and not c._witherDebuffed then
							c._witherDebuffed = true
							c._witherDebuffAmt = math.ceil(c._atk / 2)
							c._atk = math.max(0, c._atk - c._witherDebuffAmt)
						end
					end
				end
			elseif (arg_15_0._hasWitherOnBoard or (arg_15_0._opponent and arg_15_0._opponent._hasWitherOnBoard)) then
				if (arg_15_1:isMonster() or arg_15_1:isMonsterRare() or arg_15_1._type == Data.CardType.monster) then
					local isUndead = (arg_15_1._category == 17) or (arg_15_1._info and arg_15_1._info._category == 17)
					if not isUndead and not arg_15_1._witherDebuffed then
						arg_15_1._witherDebuffed = true
						arg_15_1._witherDebuffAmt = math.ceil(arg_15_1._atk / 2)
						arg_15_1._atk = math.max(0, arg_15_1._atk - arg_15_1._witherDebuffAmt)
					end
				end
			end
"""

if 'arg_15_1._infoId == 40748' not in bcs_content:
    target_bcs_wither = '			if arg_15_1._infoId == 12338 or arg_15_1:isInfoId(12338) then'
    if target_bcs_wither in bcs_content:
        bcs_content = bcs_content.replace(target_bcs_wither, bcs_wither + target_bcs_wither, 1)
        print("[OK] BattleCardStatus.lua addCardToBoard updated for Wither 40748")
    else:
        target_bcs_wither_crlf = target_bcs_wither.replace('\n', '\r\n')
        if target_bcs_wither_crlf in bcs_content:
            bcs_content = bcs_content.replace(target_bcs_wither_crlf, bcs_wither.replace('\n', '\r\n') + target_bcs_wither_crlf, 1)
            print("[OK] BattleCardStatus.lua (CRLF) addCardToBoard updated for Wither 40748")
        else:
            print("[ERR] target_bcs_wither not found in BattleCardStatus.lua")

with open(BCS_LUA, 'w', encoding='utf-8') as f:
    f.write(bcs_content)

# 8. web/src/PlayerBattle.lua (Wither leaves board: restore ATK)
PB_LUA = r"D:\yugitauapk\web\src\PlayerBattle.lua"
with open(PB_LUA, 'r', encoding='utf-8') as f:
    pb_content = f.read()

pb_wither_leave = """	-- Card 40748 (Wither) leaves board: restore ATK
	if (arg_7_1:isInfoId(40748) or arg_7_1._infoId == 40748) and (arg_7_1._status == BattleData.CardStatus.board or arg_7_1._status == BattleData.CardStatus.show) and arg_7_2 ~= BattleData.CardStatus.board and arg_7_2 ~= BattleData.CardStatus.show then
		local owner = arg_7_1._owner
		if owner then
			owner._hasWitherOnBoard = false
			local oppo = owner._opponent
			local allBoardCards = B.mergeTable({ owner:getBoardCards(), oppo and oppo:getBoardCards() or {} })
			for _, c in ipairs(allBoardCards) do
				if c._witherDebuffed and c._witherDebuffAmt then
					c._atk = c._atk + c._witherDebuffAmt
					c._witherDebuffed = nil
					c._witherDebuffAmt = nil
				end
			end
		end
	end
"""

if 'Card 40748 (Wither) leaves board' not in pb_content:
    target_pb_leave = '\t-- Card 40535 (R'
    pos = pb_content.find(target_pb_leave)
    if pos != -1:
        pb_content = pb_content[:pos] + pb_wither_leave + pb_content[pos:]
        print("[OK] PlayerBattle.lua updated with Wither ATK restoration on leave")
    else:
        # Check CRLF
        target_pb_leave_crlf = target_pb_leave.replace('\n', '\r\n')
        pos = pb_content.find(target_pb_leave_crlf)
        if pos != -1:
            pb_content = pb_content[:pos] + pb_wither_leave.replace('\n', '\r\n') + pb_content[pos:]
            print("[OK] PlayerBattle.lua (CRLF) updated with Wither ATK restoration on leave")
        else:
            print("[ERR] target_pb_leave not found in PlayerBattle.lua")

with open(PB_LUA, 'w', encoding='utf-8') as f:
    f.write(pb_content)

# 9. web/src/BattleSkill.lua (14796 handling)
BS_LUA = r"D:\yugitauapk\web\src\BattleSkill.lua"
with open(BS_LUA, 'r', encoding='utf-8') as f:
    bs_content = f.read()

bs_cast_14796 = """	elseif var_8_4 == 14796 then
		var_8_13 = true
"""

if 'var_8_4 == 14796' not in bs_content:
    target_bs_14795 = '	elseif var_8_4 == 14795 then'
    if target_bs_14795 in bs_content:
        bs_content = bs_content.replace(target_bs_14795, bs_cast_14796 + target_bs_14795, 1)
        print("[OK] BattleSkill.lua castMonster4HaloSkill updated for 14796")
    else:
        target_bs_14795_crlf = target_bs_14795.replace('\n', '\r\n')
        if target_bs_14795_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_14795_crlf, bs_cast_14796.replace('\n', '\r\n') + target_bs_14795_crlf, 1)
            print("[OK] BattleSkill.lua (CRLF) castMonster4HaloSkill updated for 14796")
        else:
            print("[ERR] target_bs_14795 not found in BattleSkill.lua")

with open(BS_LUA, 'w', encoding='utf-8') as f:
    f.write(bs_content)

# 10. web/src/h5_patch.lua
HP_LUA = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(HP_LUA, 'r', encoding='utf-8') as f:
    hp_content = f.read()

h5_patch_wither = """
			-- Wither (40748)
			if Data._rareInfo and not Data._rareInfo[40748] then
				Data._rareInfo[40748] = {
					_atk = { 3000 },
					_attackEffect = 1,
					_available = 1,
					_bgId = 0,
					_briefNameSid = 57338,
					_category = 17,
					_cost = 0,
					_descSid = 57337,
					_guideSid = 0,
					_hp = { 0 },
					_id = 40748,
					_isHide = 0,
					_joinComponent = { 0 },
					_joinResult = { 0 },
					_keyword = 304,
					_link = { 1, 2, 3 },
					_linkAllCandidates = "0.0",
					_linkCandidate = "0.0",
					_linkCount = "#>=2",
					_linkSelectedCandidates = "0.0",
					_maxCount = 3,
					_nameSid = 57336,
					_nature = 2,
					_option = 8194,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "wither",
					_quality = 4,
					_recruitable = 1,
					_skillId = { 12007, 14796 },
					_skin = { 0 },
					_star = 0,
					_syncComponent = { { 0 } }
				}
			end
			if Data._rareInfo and Data._rareInfo[40748] then
				Data._rareInfo[40748]._quality = 4
				Data._rareInfo[40748]._keyword = 304
				Data._rareInfo[40748]._nameSid = 57336
				Data._rareInfo[40748]._descSid = 57337
				Data._rareInfo[40748]._briefNameSid = 57338
				Data._rareInfo[40748]._skillId = { 12007, 14796 }
			end

			-- Skill 14796
			if Data._skillInfo and not Data._skillInfo[14796] then
				Data._skillInfo[14796] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57340, _effectVal = { 0 }, _id = 14796, _isIgnoreDefend = 1, _modes = { 2, 131, 132 }, _nameSid = 57339, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 4, _refCards = { 0 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
"""

if 'Data._rareInfo[40748]' not in hp_content:
    target_hp = 'Data._rareInfo[40747]._skillId = { 14793 }\n\t\t\tend'
    if target_hp in hp_content:
        hp_content = hp_content.replace(target_hp, target_hp + h5_patch_wither, 1)
        with open(HP_LUA, 'w', encoding='utf-8') as f:
            f.write(hp_content)
        print("[OK] h5_patch.lua updated with Wither 40748 and skill 14796")
    else:
        target_hp_crlf = target_hp.replace('\n', '\r\n')
        if target_hp_crlf in hp_content:
            hp_content = hp_content.replace(target_hp_crlf, target_hp_crlf + h5_patch_wither.replace('\n', '\r\n'), 1)
            with open(HP_LUA, 'w', encoding='utf-8') as f:
                f.write(hp_content)
            print("[OK] h5_patch.lua (CRLF) updated with Wither 40748 and skill 14796")
        else:
            print("[ERR] target_hp not found in h5_patch.lua")

print("[OK] Wither data & source modifications completed successfully!")
