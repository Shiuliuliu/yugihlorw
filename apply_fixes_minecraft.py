# -*- coding: utf-8 -*-
import os, sys

def replace_exact(path, old_str, new_str):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    c_norm = content.replace('\r\n', '\n')
    o_norm = old_str.replace('\r\n', '\n')
    n_norm = new_str.replace('\r\n', '\n')
    if o_norm not in c_norm:
        print(f"[FAIL] Target string not found in {os.path.basename(path)}")
        return False
    replaced = c_norm.replace(o_norm, n_norm, 1)
    if '\r\n' in content:
        replaced = replaced.replace('\n', '\r\n')
    with open(path, 'w', encoding='utf-8', newline='') as f:
        f.write(replaced)
    print(f"[OK] Patched {os.path.basename(path)}")
    return True

print("=== Starting Minecraft Card Fixes ===")

# ==========================================
# 1. BattleHelper.lua
# ==========================================
p_bh = r"D:\yugitauapk\web\src\BattleHelper.lua"

bh_isWither = """function var_0_0.isWitherOnField(arg_player)
	if not arg_player then return false end
	local oppo = arg_player._opponent
	local b1 = arg_player._boardCards
	if b1 then
		for i = 1, Data.MAX_CARD_COUNT_ON_BOARD do
			local c = b1[i]
			if c and (c._infoId == 40748 or (c.isInfoId and c:isInfoId(40748))) and (c._status == BattleData.CardStatus.board or c._status == BattleData.CardStatus.show) and c._destStatus ~= BattleData.CardStatus.grave and c._destStatus ~= BattleData.CardStatus.leave then
				return true
			end
		end
	end
	if oppo then
		local b2 = oppo._boardCards
		if b2 then
			for i = 1, Data.MAX_CARD_COUNT_ON_BOARD do
				local c = b2[i]
				if c and (c._infoId == 40748 or (c.isInfoId and c:isInfoId(40748))) and (c._status == BattleData.CardStatus.board or c._status == BattleData.CardStatus.show) and c._destStatus ~= BattleData.CardStatus.grave and c._destStatus ~= BattleData.CardStatus.leave then
					return true
				end
			end
		end
	end
	return false
end

function var_0_0.getLinkCandidatesByTriggerCard("""

replace_exact(p_bh, "function var_0_0.getLinkCandidatesByTriggerCard(", bh_isWither)

bh_cand_old = """	if arg_260_1._infoId == 40748 then
		if #var_260_1 < 2 then
			return {}
		end
	else"""

bh_cand_new = """	if arg_260_1._infoId == 40748 then
		if #var_260_1 < 2 or var_260_2 < 3 then
			return {}
		end
	else"""

replace_exact(p_bh, bh_cand_old, bh_cand_new)

bh_linkcomp_old = """	if arg_261_1._infoId == 40748 then
		if #arg_261_2 < 2 then
			return false
		end
	elseif var_261_1 > B.getSumLink(arg_261_2) then
		return false
	end"""

bh_linkcomp_new = """	if arg_261_1._infoId == 40748 then
		if #arg_261_2 < 2 or #arg_261_2 > 3 then
			return false
		end
		if var_261_1 > B.getSumLink(arg_261_2) then
			return false
		end
	elseif var_261_1 > B.getSumLink(arg_261_2) then
		return false
	end"""

replace_exact(p_bh, bh_linkcomp_old, bh_linkcomp_new)

bh_detail_old = """		if arg_261_1._infoId == 40748 then
			if #arg_261_2 < 2 or #arg_261_2 > 3 then
				return false
			end
			for _, c in ipairs(arg_261_2) do
				if not (c:isKeyword(304) or (c._info and c._info._keyword == 304) or c._keyword == 304) then
					return false
				end
			end
			return true
		end"""

bh_detail_new = """		if arg_261_1._infoId == 40748 then
			if #arg_261_2 < 2 or #arg_261_2 > 3 then
				return false
			end
			for _, c in ipairs(arg_261_2) do
				if not (c:isKeyword(304) or (c._info and c._info._keyword == 304) or c._keyword == 304) then
					return false
				end
			end
			local function checkSum(idx, curSum)
				if curSum > 3 then return false end
				if idx > #arg_261_2 then return curSum == 3 end
				local card = arg_261_2[idx]
				local linkVal = (card and card.getLink and card:getLink()) or 1
				if checkSum(idx + 1, curSum + 1) then return true end
				if linkVal > 1 and checkSum(idx + 1, curSum + linkVal) then return true end
				return false
			end
			if not checkSum(1, 0) then
				return false
			end
			return true
		end"""

replace_exact(p_bh, bh_detail_old, bh_detail_new)

# ==========================================
# 2. BattleSkill.lua
# ==========================================
p_bs = r"D:\yugitauapk\web\src\BattleSkill.lua"

# A. Remove Enderman special summon from canUseMonsterSpecial
bs_ss_old = """	if (arg_19_1._infoId == 12338 or arg_19_1:hasSkillFast(14794)) then
		local boardCards = arg_19_0:getBoardCards()
		local canSS = (#boardCards == 0)
		if not canSS then
			for _, c in ipairs(boardCards) do
				if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster) and (c:isKeyword(304) or (c._info and c._info._keyword == 304) or c._keyword == 304) then
					canSS = true
					break
				end
			end
		end
		if canSS and not arg_19_0._isSummonDisabled and not arg_19_0._isSpecialSummonDisabled and arg_19_0:getEmptyBoardPos(arg_19_1) ~= nil then
			local var_s12338 = arg_19_1:getSkillById(14794) or arg_19_1._skills[2] or arg_19_1._skills[1]
			return true, nil, var_19_0, var_s12338
		end
	end"""

replace_exact(p_bs, bs_ss_old, "")

# B. Fix setCardStatus calls: remove 7th argument (pos) so futureSourceStatus is not corrupted!
bs_sk14793_old = """		local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
		if emptyPos then
			pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, arg_4_1._id, 14793, arg_4_3, BattleData.CardStatusVal.r2b_sync, emptyPos)
		end
		var_4_13 = true"""

bs_sk14793_new = """		local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
		if emptyPos then
			arg_4_1._saved._pos = emptyPos
			pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, arg_4_1._id, 14793, arg_4_3, BattleData.CardStatusVal.r2b_sync)
		end
		var_4_13 = true"""

replace_exact(p_bs, bs_sk14793_old, bs_sk14793_new)

bs_sk14794_old = """	elseif var_4_4 == 14794 then
		local ownerCard = var_4_1 or arg_4_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_4_0
		if arg_4_3 == Data.SkillMode.initiative_hand or arg_4_1._status == BattleData.CardStatus.hand then
			local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
			if emptyPos then
				pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.h2b_special, emptyPos)
				var_4_13 = true
			end
		end"""

bs_sk14794_new = """	elseif var_4_4 == 14794 then
		local ownerCard = var_4_1 or arg_4_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_4_0
		if arg_4_3 == Data.SkillMode.initiative_hand or arg_4_1._status == BattleData.CardStatus.hand then
			local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
			if emptyPos then
				arg_4_1._saved._pos = emptyPos
				pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.h2b_special)
				var_4_13 = true
			end
		end"""

replace_exact(p_bs, bs_sk14794_old, bs_sk14794_new)

bs_sk14798_old = """	elseif var_4_4 == 14798 then
		local ownerCard = var_4_1 or arg_4_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_4_0
		if arg_4_3 == Data.SkillMode.initiative_hand or arg_4_1._status == BattleData.CardStatus.hand then
			local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
			if emptyPos then
				pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.h2b_special, emptyPos)
				var_4_13 = true
			end
		end"""

bs_sk14798_new = """	elseif var_4_4 == 14798 then
		local ownerCard = var_4_1 or arg_4_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_4_0
		if arg_4_3 == Data.SkillMode.initiative_hand or arg_4_1._status == BattleData.CardStatus.hand then
			local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
			if emptyPos then
				arg_4_1._saved._pos = emptyPos
				pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.h2b_special)
				var_4_13 = true
			end
		end"""

replace_exact(p_bs, bs_sk14798_old, bs_sk14798_new)

bs_sk14804_old = """		if targetCard then
			local targetPos = pOwner:getEmptyBoardPos(targetCard) or emptyPos
			local sVal = BattleData.CardStatusVal.h2b_special
			if targetCard._status == BattleData.CardStatus.pile then
				sVal = BattleData.CardStatusVal.p2b_special
			elseif targetCard._status == BattleData.CardStatus.grave then
				sVal = BattleData.CardStatusVal.g2b_special
			end
			pOwner:setCardStatus(targetCard, BattleData.CardStatus.board, ownerCard._id, 14804, arg_4_3, sVal, targetPos)
		end"""

bs_sk14804_new = """		if targetCard then
			local targetPos = pOwner:getEmptyBoardPos(targetCard) or emptyPos
			local sVal = BattleData.CardStatusVal.h2b_special
			if targetCard._status == BattleData.CardStatus.pile then
				sVal = BattleData.CardStatusVal.p2b_special
			elseif targetCard._status == BattleData.CardStatus.grave then
				sVal = BattleData.CardStatusVal.g2b_special
			end
			targetCard._saved._pos = targetPos
			pOwner:setCardStatus(targetCard, BattleData.CardStatus.board, ownerCard._id, 14804, arg_4_3, sVal)
		end"""

replace_exact(p_bs, bs_sk14804_old, bs_sk14804_new)


# ==========================================
# 3. PlayerUi.lua
# ==========================================
p_pu = r"D:\yugitauapk\web\src\PlayerUi.lua"

# A. In castInitiativeSkill: handle skill 14794 directly
pu_cast_old = """	local pOwner = arg_55_1._owner or arg_55_0._player
	local var_55_1, var_55_2, var_55_3 = pOwner:isGraveSkill(arg_55_2, nil, true)"""

pu_cast_new = """	if arg_55_2 and arg_55_2._id == 14794 then
		local skillIdx = arg_55_1:getSkillIndexById(14794) or 2
		return arg_55_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_55_1,
			_choice = skillIdx * BattleData.ChoiceId.stage_3
		})
	end

	local pOwner = arg_55_1._owner or arg_55_0._player
	local var_55_1, var_55_2, var_55_3 = pOwner:isGraveSkill(arg_55_2, nil, true)"""

replace_exact(p_pu, pu_cast_old, pu_cast_new)

# B. In showChoiceSummon: remove 12338 / 14794 from special summon choice via drag
pu_summon_old = """or var_72_0._card._infoId == 12333 or var_72_0._card._infoId == 12338 or var_72_0._card:hasSkillFast(14794) then"""
pu_summon_new = """or var_72_0._card._infoId == 12333 then"""

replace_exact(p_pu, pu_summon_old, pu_summon_new)

# C. In onChoiceGrave: ensure Skeleton 40747 choice is sent with skillIdx * ChoiceId.stage_3
pu_choicegrave_old = """	if arg_89_2._card:hasSkillFast(14716) or arg_89_2._card:isInfoId(21140) or arg_89_2._card:hasSkillFast(14723) or arg_89_2._card:hasSkillFast(14724) or arg_89_2._card:isInfoId(12328) or arg_89_2._card:isInfoId(12329) or arg_89_2._card:hasSkillFast(14731) or arg_89_2._card:hasSkillFast(14732) or arg_89_2._card:hasSkillFast(14738) or arg_89_2._card:isInfoId(21141) or arg_89_2._card:hasSkillFast(14742) or arg_89_2._card:hasSkillFast(14748) or arg_89_2._card:isInfoId(12334) or arg_89_2._card:isInfoId(21145) or arg_89_2._card:hasSkillFast(14752) or arg_89_2._card:isInfoId(21146) or arg_89_2._card:hasSkillFast(14757) or arg_89_2._card:hasSkillFast(14761) or arg_89_2._card:isInfoId(30595) or arg_89_2._card:hasSkillFast(14758) or arg_89_2._card:hasSkillFast(14759) or arg_89_2._card:hasSkillFast(14756) or arg_89_2._card:isInfoId(30594) or arg_89_2._card:hasSkillFast(14774) or arg_89_2._card:isInfoId(40742) or arg_89_2._card:hasSkillFast(14776) or arg_89_2._card:isInfoId(40743) or arg_89_2._card:hasSkillFast(14779) or arg_89_2._card:isInfoId(11961) or arg_89_2._card:hasSkillFast(14781) or arg_89_2._card:isInfoId(11959) or arg_89_2._card:hasSkillFast(14783) or arg_89_2._card:isInfoId(11960) or arg_89_2._card:hasSkillFast(14784) or arg_89_2._card:hasSkillFast(14786) or arg_89_2._card:isInfoId(40744) or arg_89_2._card:hasSkillFast(14793) or arg_89_2._card:isInfoId(40747) or (arg_89_1._choiceBase ~= nil and arg_89_2._card:isSkillAtIndex(14793, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3))) then
		if var_89_0 and #var_89_0 > 0 then
			var_89_1 = var_89_0[1]._id
		end

		return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_89_2._card,
			_target = arg_89_3 ~= nil and arg_89_3._card or nil,
			_choice = var_89_1 * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
		})
	end"""

pu_choicegrave_new = """	if arg_89_2._card:isInfoId(40747) or arg_89_2._card:hasSkillFast(14793) then
		if var_89_0 and #var_89_0 > 0 then
			var_89_1 = var_89_0[1]._id
		end
		local skillIdx = arg_89_2._card:getSkillIndexById(14793) or 1
		local baseChoice = (arg_89_1._choiceBase and arg_89_1._choiceBase >= BattleData.ChoiceId.stage_3) and arg_89_1._choiceBase or (skillIdx * BattleData.ChoiceId.stage_3)
		return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_89_2._card,
			_target = arg_89_3 ~= nil and arg_89_3._card or nil,
			_choice = var_89_1 * BattleData.ChoiceId.stage_2 + baseChoice
		})
	end

	if arg_89_2._card:hasSkillFast(14716) or arg_89_2._card:isInfoId(21140) or arg_89_2._card:hasSkillFast(14723) or arg_89_2._card:hasSkillFast(14724) or arg_89_2._card:isInfoId(12328) or arg_89_2._card:isInfoId(12329) or arg_89_2._card:hasSkillFast(14731) or arg_89_2._card:hasSkillFast(14732) or arg_89_2._card:hasSkillFast(14738) or arg_89_2._card:isInfoId(21141) or arg_89_2._card:hasSkillFast(14742) or arg_89_2._card:hasSkillFast(14748) or arg_89_2._card:isInfoId(12334) or arg_89_2._card:isInfoId(21145) or arg_89_2._card:hasSkillFast(14752) or arg_89_2._card:isInfoId(21146) or arg_89_2._card:hasSkillFast(14757) or arg_89_2._card:hasSkillFast(14761) or arg_89_2._card:isInfoId(30595) or arg_89_2._card:hasSkillFast(14758) or arg_89_2._card:hasSkillFast(14759) or arg_89_2._card:hasSkillFast(14756) or arg_89_2._card:isInfoId(30594) or arg_89_2._card:hasSkillFast(14774) or arg_89_2._card:isInfoId(40742) or arg_89_2._card:hasSkillFast(14776) or arg_89_2._card:isInfoId(40743) or arg_89_2._card:hasSkillFast(14779) or arg_89_2._card:isInfoId(11961) or arg_89_2._card:hasSkillFast(14781) or arg_89_2._card:isInfoId(11959) or arg_89_2._card:hasSkillFast(14783) or arg_89_2._card:isInfoId(11960) or arg_89_2._card:hasSkillFast(14784) or arg_89_2._card:hasSkillFast(14786) or arg_89_2._card:isInfoId(40744) then
		if var_89_0 and #var_89_0 > 0 then
			var_89_1 = var_89_0[1]._id
		end

		return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_89_2._card,
			_target = arg_89_3 ~= nil and arg_89_3._card or nil,
			_choice = var_89_1 * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
		})
	end"""

replace_exact(p_pu, pu_choicegrave_old, pu_choicegrave_new)


# ==========================================
# 4. BattleStep.lua
# ==========================================
p_bstep = r"D:\yugitauapk\web\src\BattleStep.lua"

bstep_usecard_old = """	elseif arg_52_1._status == BattleData.CardStatus.show or arg_52_1._status == BattleData.CardStatus.field or arg_52_1._status == BattleData.CardStatus.grave or arg_52_1._status == BattleData.CardStatus.rare or arg_52_1._status == BattleData.CardStatus.leave then
		local var_52_34 = arg_52_1._choice and math.floor(arg_52_1._choice / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0

		if var_52_34 > 0 then"""

bstep_usecard_new = """	elseif arg_52_1._status == BattleData.CardStatus.show or arg_52_1._status == BattleData.CardStatus.field or arg_52_1._status == BattleData.CardStatus.grave or arg_52_1._status == BattleData.CardStatus.rare or arg_52_1._status == BattleData.CardStatus.leave then
		local var_52_34 = arg_52_1._choice and math.floor(arg_52_1._choice / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0

		if var_52_34 == 0 and (arg_52_1._infoId == 40747 or arg_52_1:hasSkillFast(14793)) then
			var_52_34 = 1
		end

		if var_52_34 > 0 then"""

replace_exact(p_bstep, bstep_usecard_old, bstep_usecard_new)


# ==========================================
# 5. BattleCardStatus.lua
# ==========================================
p_bcs = r"D:\yugitauapk\web\src\BattleCardStatus.lua"

bcs_wither_old = """			if arg_15_1._infoId == 40748 or arg_15_1:isInfoId(40748) then
				arg_15_0._hasWitherOnBoard = true
				arg_15_0:incShield(arg_15_1, { 12007 }, false, false, arg_15_1._id, 12007, Data.SkillMode.using)
				local oppo = arg_15_0._opponent
				local allBoardCards = B.mergeTable({ arg_15_0:getBoardCards(), oppo and oppo:getBoardCards() or {} })
				for _, c in ipairs(allBoardCards) do
					if c ~= arg_15_1 and (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster) then
						local isUndead = c:isCategory(17)
						if not isUndead and not c._witherDebuffed then
							c._witherDebuffed = true
							c._witherDebuffAmt = math.ceil(c._atk / 2)
							c._atk = math.max(0, c._atk - c._witherDebuffAmt)
							local cOwner = c._owner
							local cUi = cOwner and cOwner._ownerUi
							local spr = cUi and cUi:getCardSprite(c)
							if spr and spr.updateAtkHp then
								spr:updateAtkHp()
							end
						end
					end
				end
			elseif (arg_15_0._hasWitherOnBoard or (arg_15_0._opponent and arg_15_0._opponent._hasWitherOnBoard)) then
				if (arg_15_1:isMonster() or arg_15_1:isMonsterRare() or arg_15_1._type == Data.CardType.monster) then
					local isUndead = arg_15_1:isCategory(17)
					if not isUndead and not arg_15_1._witherDebuffed then
						arg_15_1._witherDebuffed = true
						arg_15_1._witherDebuffAmt = math.ceil(arg_15_1._atk / 2)
						arg_15_1._atk = math.max(0, arg_15_1._atk - arg_15_1._witherDebuffAmt)
						local cOwner = arg_15_1._owner
						local cUi = cOwner and cOwner._ownerUi
						local spr = cUi and cUi:getCardSprite(arg_15_1)
						if spr and spr.updateAtkHp then
							spr:updateAtkHp()
						end
					end
				end
			end"""

bcs_wither_new = """			if arg_15_1._infoId == 40748 or arg_15_1:isInfoId(40748) then
				arg_15_0:incShield(arg_15_1, { 12007 }, false, false, arg_15_1._id, 12007, Data.SkillMode.using)
			end"""

replace_exact(p_bcs, bcs_wither_old, bcs_wither_new)


# ==========================================
# 6. PlayerBattle.lua
# ==========================================
p_pb = r"D:\yugitauapk\web\src\PlayerBattle.lua"

pb_wither_leave_old = """	-- Card 40748 (Wither) leaves board: restore ATK
	if (arg_7_1:isInfoId(40748) or arg_7_1._infoId == 40748) and (arg_7_1._status == BattleData.CardStatus.board or arg_7_1._status == BattleData.CardStatus.show) and arg_7_2 ~= BattleData.CardStatus.board and arg_7_2 ~= BattleData.CardStatus.show then
		local owner = arg_7_1._owner
		if owner then
			owner._hasWitherOnBoard = false
			local oppo = owner._opponent
			if oppo then oppo._hasWitherOnBoard = false end
			local allBoardCards = B.mergeTable({ owner:getBoardCards(), oppo and oppo:getBoardCards() or {} })
			for _, c in ipairs(allBoardCards) do
				if c._witherDebuffed and c._witherDebuffAmt then
					c._atk = c._atk + c._witherDebuffAmt
					c._witherDebuffed = nil
					c._witherDebuffAmt = nil
					local cOwner = c._owner
					local cUi = cOwner and cOwner._ownerUi
					local spr = cUi and cUi:getCardSprite(c)
					if spr and spr.updateAtkHp then
						spr:updateAtkHp()
					end
				end
			end
		end
	end"""

pb_wither_leave_new = """	-- Card 40748 (Wither) leaves or enters board: trigger account
	if (arg_7_1:isInfoId(40748) or arg_7_1._infoId == 40748) and (arg_7_2 == BattleData.CardStatus.board or arg_7_1._status == BattleData.CardStatus.board) then
		arg_7_0:account()
		if arg_7_0._opponent then
			arg_7_0._opponent:account()
		end
	end"""

replace_exact(p_pb, pb_wither_leave_old, pb_wither_leave_new)

pb_account_old = """		arg_38_1._atk = math.max(math.min(var_38_32, var_38_31 + var_38_4), var_38_24)
		arg_38_1._atkInc = arg_38_1._atkInc + (arg_38_1._atk - var_38_32)"""

pb_account_new = """		arg_38_1._atk = math.max(math.min(var_38_32, var_38_31 + var_38_4), var_38_24)
		arg_38_1._atkInc = arg_38_1._atkInc + (arg_38_1._atk - var_38_32)

		local cardOwner = arg_38_1._owner or arg_38_0
		if B.isWitherOnField(cardOwner) and arg_38_1._status == BattleData.CardStatus.board and (arg_38_1:isMonster() or arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.monster) then
			local isUndead = arg_38_1:isCategory(17) or (arg_38_1._info and arg_38_1._info._category == 17)
			if not isUndead then
				arg_38_1._atk = math.floor(arg_38_1._atk / 2)
			end
		end"""

replace_exact(p_pb, pb_account_old, pb_account_new)


# ==========================================
# 7. BattleCard.lua
# ==========================================
p_bc = r"D:\yugitauapk\web\src\BattleCard.lua"

bc_resetatk_old = """	if arg_29_0._updateAtk ~= nil then
		arg_29_0._atk = arg_29_0._updateAtk
		arg_29_0._atkInc = arg_29_0._atk - arg_29_0._maxAtk
	end"""

bc_resetatk_new = """	if arg_29_0._updateAtk ~= nil then
		arg_29_0._atk = arg_29_0._updateAtk
		arg_29_0._atkInc = arg_29_0._atk - arg_29_0._maxAtk
	end

	local owner = arg_29_0._owner
	if B.isWitherOnField(owner) and arg_29_0._status == BattleData.CardStatus.board and (arg_29_0:isMonster() or arg_29_0:isMonsterRare() or arg_29_0._type == Data.CardType.monster) then
		local isUndead = arg_29_0:isCategory(17) or (arg_29_0._info and arg_29_0._info._category == 17)
		if not isUndead then
			arg_29_0._atk = math.floor(arg_29_0._atk / 2)
		end
	end"""

replace_exact(p_bc, bc_resetatk_old, bc_resetatk_new)

bc_getatk_old = """function var_0_0.getAtk(arg_282_0)
	if arg_282_0._witherDebuffed then
		return arg_282_0._atk
	end
	local owner = arg_282_0._owner
	local oppo = owner and owner._opponent
	local hasWither = (owner and owner._hasWitherOnBoard) or (oppo and oppo._hasWitherOnBoard)
	if hasWither and arg_282_0._status == BattleData.CardStatus.board then
		local isUndead = arg_282_0:isCategory(17)
		if not isUndead then
			return math.floor((arg_282_0._atk or arg_282_0._maxAtk or 0) / 2)
		end
	end"""

bc_getatk_new = """function var_0_0.getAtk(arg_282_0)
	if arg_282_0._atk ~= nil then
		return arg_282_0._atk
	end
	local owner = arg_282_0._owner
	local baseAtk = arg_282_0._maxAtk or 0
	if B.isWitherOnField(owner) and arg_282_0._status == BattleData.CardStatus.board and (arg_282_0:isMonster() or arg_282_0:isMonsterRare() or arg_282_0._type == Data.CardType.monster) then
		local isUndead = arg_282_0:isCategory(17) or (arg_282_0._info and arg_282_0._info._category == 17)
		if not isUndead then
			return math.floor(baseAtk / 2)
		end
	end"""

replace_exact(p_bc, bc_getatk_old, bc_getatk_new)

print("=== All patches processed! ===")
