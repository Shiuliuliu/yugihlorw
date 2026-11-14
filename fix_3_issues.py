# -*- coding: utf-8 -*-
import os, sys

print("[*] Starting fix_3_issues.py...")

# =========================================================================
# FIX 1: 21173 / 20214 - Buff khiên và +300 ATK cho quái Labrynth khi có mặt Labyrinth
# =========================================================================
BC_PATH = r"D:\yugitauapk\web\src\BattleCard.lua"
with open(BC_PATH, 'r', encoding='utf-8') as f:
    bc_code = f.read()

# 1.a) Improve hasLab check in BattleCard.lua
old_check_lab = """			local hasLab = (owner._fieldCard and (owner._fieldCard:isInfoId(21173) or owner._fieldCard._infoId == 21173 or owner._fieldCard:hasSkillFast(20214)))
			if not hasLab and owner._boardCards then
				for _, bc in ipairs(owner._boardCards) do
					if bc and (bc:isInfoId(21173) or bc._infoId == 21173 or bc:hasSkillFast(20214)) then
						hasLab = true
						break
					end
				end
			end"""

new_check_lab = """			local hasLab = (owner._fieldCard and (owner._fieldCard:isInfoId(21173) or owner._fieldCard._infoId == 21173 or owner._fieldCard:hasSkillFast(20214)))
			if not hasLab and owner._boardCards then
				for _, bc in ipairs(owner._boardCards) do
					if bc and (bc:isInfoId(21173) or bc._infoId == 21173 or bc:hasSkillFast(20214)) then
						hasLab = true
						break
					end
				end
			end
			if not hasLab and owner._magicCards then
				for _, mc in ipairs(owner._magicCards) do
					if mc and (mc:isInfoId(21173) or mc._infoId == 21173 or mc:hasSkillFast(20214)) then
						hasLab = true
						break
					end
				end
			end
			if not hasLab and owner.getBattleCards then
				for _, sc in ipairs(owner:getBattleCards("C")) do
					if sc and (sc:isInfoId(21173) or sc._infoId == 21173 or sc:hasSkillFast(20214)) then
						hasLab = true
						break
					end
				end
				if not hasLab then
					for _, sc in ipairs(owner:getBattleCards("S")) do
						if sc and (sc:isInfoId(21173) or sc._infoId == 21173 or sc:hasSkillFast(20214)) then
							hasLab = true
							break
						end
					end
				end
			end"""

if old_check_lab in bc_code:
    # Replace all occurrences in BattleCard.lua
    bc_code = bc_code.replace(old_check_lab, new_check_lab)
    with open(BC_PATH, 'w', encoding='utf-8') as f:
        f.write(bc_code)
    print("[OK] BattleCard.lua: Updated hasLab check in all occurrences.")
else:
    print("[WARN] old_check_lab not found in BattleCard.lua")

# 1.b) Add on-summon buff in BattleCardStatus.lua
BCS_PATH = r"D:\yugitauapk\web\src\BattleCardStatus.lua"
with open(BCS_PATH, 'r', encoding='utf-8') as f:
    bcs_code = f.read()

target_bcs_board = """	arg_15_1._status = BattleData.CardStatus.board

	if not arg_15_1._isBorrowed then
		lc.clearTable(arg_15_1._saved)
	end"""

repl_bcs_board = target_bcs_board + """

	-- Labrynth Labyrinth (21173 / 20214): Khi co mat: Quai Labrynth len san nhan Khien Chan Quai/Phep/Bay va tang 300 tan cong
	if (arg_15_1:isKeyword(308) or (arg_15_1._info and arg_15_1._info._keyword == 308)) then
		local var_owner = arg_15_1._owner or arg_15_0
		local hasLab21173 = false
		if var_owner then
			if var_owner._fieldCard and (var_owner._fieldCard:isInfoId(21173) or var_owner._fieldCard._infoId == 21173 or var_owner._fieldCard:hasSkillFast(20214)) then
				hasLab21173 = true
			end
			if not hasLab21173 and var_owner._magicCards then
				for _, mc in ipairs(var_owner._magicCards) do
					if mc and (mc:isInfoId(21173) or mc._infoId == 21173 or mc:hasSkillFast(20214)) then
						hasLab21173 = true
						break
					end
				end
			end
			if not hasLab21173 and var_owner.getBattleCards then
				for _, sc in ipairs(var_owner:getBattleCards("C")) do
					if sc and (sc:isInfoId(21173) or sc._infoId == 21173 or sc:hasSkillFast(20214)) then
						hasLab21173 = true
						break
					end
				end
				if not hasLab21173 then
					for _, sc in ipairs(var_owner:getBattleCards("S")) do
						if sc and (sc:isInfoId(21173) or sc._infoId == 21173 or sc:hasSkillFast(20214)) then
							hasLab21173 = true
							break
						end
					end
				end
			end
		end

		if hasLab21173 then
			-- Tang 300 ATK
			arg_15_1._atk = (arg_15_1._atk or arg_15_1._maxAtk or 0) + 300
			arg_15_1._maxAtk = (arg_15_1._maxAtk or 0) + 300
			arg_15_0:incPositiveStatus(arg_15_1, { BattleData.PositiveType.extraAtk }, false, 21173, 20214, Data.SkillMode.using)
			arg_15_0:incPositiveValue(arg_15_1, BattleData.PositiveType.extraAtk, 300, Data.AggregateType.sum, 21173, 20214, Data.SkillMode.using)

			-- Nhan Khien Chan Quai / Phep / Bay
			arg_15_0:incPositiveStatus(arg_15_1, {
				BattleData.PositiveType.shieldMonster,
				BattleData.PositiveType.shieldMagic,
				BattleData.PositiveType.shieldTrap
			}, true, 21173, 20214, Data.SkillMode.using)
			arg_15_1:addBuff(true, BattleData.PositiveType.shieldMonster, 1)
			arg_15_1:addBuff(true, BattleData.PositiveType.shieldMagic, 1)
			arg_15_1:addBuff(true, BattleData.PositiveType.shieldTrap, 1)
		end
	end"""

if "Labrynth Labyrinth (21173 / 20214)" not in bcs_code:
    if target_bcs_board in bcs_code:
        bcs_code = bcs_code.replace(target_bcs_board, repl_bcs_board, 1)
        print("[OK] BattleCardStatus.lua: Added on-summon buff for Labrynth monsters.")
    else:
        print("[WARN] target_bcs_board not found in BattleCardStatus.lua")
else:
    print("[SKIP] BattleCardStatus.lua already has on-summon buff.")

# =========================================================================
# FIX 3: 30598 (Dimensional Barrier) - Chuyển sang cơ chế ÚP thay vì kích hoạt trực tiếp
# =========================================================================
# 3.a) In BattleCardStatus.lua: Do NOT trigger 30598 from hand, ONLY from cover / board ST!
target_bcs_dbarrier_hand = """				if not dBarrierCard then
					for _, c in ipairs(oppo:getBattleCards("H")) do
						if (c:isInfoId(30598) or c._infoId == 30598 or c:hasSkillFast(20117)) and c._status == BattleData.CardStatus.hand then
							dBarrierCard = c
							break
						end
					end
				end"""

repl_bcs_dbarrier_hand = """				-- Dimensional Barrier (30598): Chi kich hoat tu the bai UP tren san (cover), khong kich hoat tu tay!"""

if target_bcs_dbarrier_hand in bcs_code:
    bcs_code = bcs_code.replace(target_bcs_dbarrier_hand, repl_bcs_dbarrier_hand, 1)
    print("[OK] BattleCardStatus.lua: Removed hand auto-trigger for 30598.")
else:
    print("[SKIP] Hand trigger already removed from BattleCardStatus.lua.")

# Also make sure search in CS checks for cover / not in hand
target_bcs_cs = """				for _, c in ipairs(oppo:getBattleCards("CS")) do
					if (c:isInfoId(30598) or c._infoId == 30598 or c:hasSkillFast(20117)) and c._status ~= BattleData.CardStatus.grave and c._status ~= BattleData.CardStatus.leave then
						dBarrierCard = c
						break
					end
				end"""

repl_bcs_cs = """				for _, c in ipairs(oppo:getBattleCards("CS")) do
					if (c:isInfoId(30598) or c._infoId == 30598 or c:hasSkillFast(20117)) and (c._status == BattleData.CardStatus.cover or c._status == BattleData.CardStatus.magic or c._status == BattleData.CardStatus.trap) then
						dBarrierCard = c
						break
					end
				end"""

if target_bcs_cs in bcs_code:
    bcs_code = bcs_code.replace(target_bcs_cs, repl_bcs_cs, 1)
    print("[OK] BattleCardStatus.lua: Restricted 30598 to cover/CS status.")

with open(BCS_PATH, 'w', encoding='utf-8') as f:
    f.write(bcs_code)

# 3.b) In BattleStep.lua: Remove 30598 from direct hand-activation list so it SETS (COVERS) instead!
STEP_PATH = r"D:\yugitauapk\web\src\BattleStep.lua"
with open(STEP_PATH, 'r', encoding='utf-8') as f:
    step_code = f.read()

target_step_30598 = "or (arg_52_1._infoId >= 30598 and arg_52_1._infoId <= 30605 and arg_52_1._infoId ~= 30603)"
repl_step_30598 = "or (arg_52_1._infoId >= 30599 and arg_52_1._infoId <= 30605 and arg_52_1._infoId ~= 30603)"

if target_step_30598 in step_code:
    step_code = step_code.replace(target_step_30598, repl_step_30598, 1)
    with open(STEP_PATH, 'w', encoding='utf-8') as f:
        f.write(step_code)
    print("[OK] BattleStep.lua: 30598 removed from hand-activate list -> now SETS (COVERS) on use!")
else:
    print("[SKIP] BattleStep.lua already updated for 30598.")

# =========================================================================
# FIX 2: 30601 (Trap Holic) - Chọn mục tiêu phá hủy là bài Phép/Bẫy phe ta
# =========================================================================
# 2.a) PlayerUi.lua
PUI_PATH = r"D:\yugitauapk\web\src\PlayerUi.lua"
with open(PUI_PATH, 'r', encoding='utf-8') as f:
    pui_code = f.read()

target_pui_30601 = """	elseif arg_55_2._id == 20120 then
		local cands = {}
		local oppo = arg_55_0._player._opponent
		local allFieldCards = B.mergeTable({
			arg_55_0._player:getBoardCards(),
			arg_55_0._player:getBattleCards("C"),
			arg_55_0._player:getBattleCards("S"),
			(oppo and oppo:getBoardCards() or {}),
			(oppo and oppo:getBattleCards("C") or {}),
			(oppo and oppo:getBattleCards("S") or {})
		})
		for _, c in ipairs(allFieldCards) do
			if c ~= arg_55_1 and c:canChangeToGrave() then
				table.insert(cands, c)
			end
		end"""

repl_pui_30601 = """	elseif arg_55_2._id == 20120 then
		-- TRAP HOLIC (30601): Chon 1 la bai Phep/Bay phe ta de pha huy
		local cands = {}
		local myST = B.mergeTable({
			arg_55_0._player:getBattleCards("C"),
			arg_55_0._player:getBattleCards("S")
		})
		for _, c in ipairs(myST) do
			if c ~= arg_55_1 and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) and c:canChangeToGrave() then
				table.insert(cands, c)
			end
		end"""

if target_pui_30601 in pui_code:
    pui_code = pui_code.replace(target_pui_30601, repl_pui_30601, 1)
    print("[OK] PlayerUi.lua: 30601 candidate list changed to our S/T cards.")
else:
    print("[SKIP] PlayerUi.lua already has updated 30601 candidate list.")

target_pui_title_30601 = 'var_85_1 = "Chọn 1 lá bài trên sân đối thủ để đưa vào Mộ"'
repl_pui_title_30601 = 'var_85_1 = "Chọn 1 lá bài Phép/Bẫy phe ta để phá hủy"'

if target_pui_title_30601 in pui_code:
    pui_code = pui_code.replace(target_pui_title_30601, repl_pui_title_30601, 1)
    print("[OK] PlayerUi.lua: 30601 title changed to 'Chọn 1 lá bài Phép/Bẫy phe ta để phá hủy'.")
else:
    print("[SKIP] PlayerUi.lua already has updated title for 30601.")

with open(PUI_PATH, 'w', encoding='utf-8') as f:
    f.write(pui_code)

# 2.b) BattleSkill.lua: canTriggerTrap for 20120
BS_PATH = r"D:\yugitauapk\web\src\BattleSkill.lua"
with open(BS_PATH, 'r', encoding='utf-8') as f:
    bs_code = f.read()

target_bs_can_30601 = """	elseif var_27_1 == 20120 then
		local trapsInGrave = arg_27_0:getBattleCardsByType("G", Data.CardType.trap)
		if #trapsInGrave >= 3 and (arg_27_0._castedSkillCounts[20120] or 0) > 0 then return false end
		local hasTarget = false
		if arg_27_0._opponent then
			if #arg_27_0._opponent:getBoardCards() > 0 or #arg_27_0._opponent:getBattleCards("C") > 0 or #arg_27_0._opponent:getBattleCards("S") > 0 or #arg_27_0._opponent:getBattleCards("F") > 0 then
				hasTarget = true
			end
		end
		if not hasTarget and arg_27_1._status ~= BattleData.CardStatus.board and arg_27_1._status ~= BattleData.CardStatus.cover then
			return false
		end"""

repl_bs_can_30601 = """	elseif var_27_1 == 20120 then
		local trapsInGrave = arg_27_0:getBattleCardsByType("G", Data.CardType.trap)
		if #trapsInGrave >= 3 and (arg_27_0._castedSkillCounts[20120] or 0) > 0 then return false end
		local hasTarget = false
		for _, c in ipairs(B.mergeTable({ arg_27_0:getBattleCards("C"), arg_27_0:getBattleCards("S") })) do
			if c ~= arg_27_1 and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) and c:canChangeToGrave() then
				hasTarget = true
				break
			end
		end
		if not hasTarget then
			return false
		end"""

if target_bs_can_30601 in bs_code:
    bs_code = bs_code.replace(target_bs_can_30601, repl_bs_can_30601, 1)
    print("[OK] BattleSkill.lua: canTriggerTrap first occurrence updated for 30601.")

target_bs_can_30601_2 = """	elseif var_27_1 == 20120 then
		-- Trap Holic (30601): chon 1 la tren san doi thu dua vao mo, lay 1 Bay thuong tu bo bai
		local trapsInGrave = arg_27_0:getBattleCardsByType("G", Data.CardType.trap)
		if #trapsInGrave >= 3 and (arg_27_0._castedSkillCounts[20120] or 0) > 0 then
			return false
		end
		local hasTarget = false
		if arg_27_0._opponent then
			if #arg_27_0._opponent:getBoardCards() > 0 or #arg_27_0._opponent:getBattleCards("S") > 0 or #arg_27_0._opponent:getBattleCards("F") > 0 then
				hasTarget = true
			end
		end
		if not hasTarget and arg_27_1._status ~= BattleData.CardStatus.board and arg_27_1._status ~= BattleData.CardStatus.cover then
			return false
		end"""

repl_bs_can_30601_2 = """	elseif var_27_1 == 20120 then
		-- Trap Holic (30601): chon 1 la Phep/Bay phe ta de pha huy, lay 1 Bay thuong tu bo bai
		local trapsInGrave = arg_27_0:getBattleCardsByType("G", Data.CardType.trap)
		if #trapsInGrave >= 3 and (arg_27_0._castedSkillCounts[20120] or 0) > 0 then
			return false
		end
		local hasTarget = false
		for _, c in ipairs(B.mergeTable({ arg_27_0:getBattleCards("C"), arg_27_0:getBattleCards("S") })) do
			if c ~= arg_27_1 and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) and c:canChangeToGrave() then
				hasTarget = true
				break
			end
		end
		if not hasTarget then
			return false
		end"""

if target_bs_can_30601_2 in bs_code:
    bs_code = bs_code.replace(target_bs_can_30601_2, repl_bs_can_30601_2, 1)
    print("[OK] BattleSkill.lua: canTriggerTrap second occurrence updated for 30601.")

with open(BS_PATH, 'w', encoding='utf-8') as f:
    f.write(bs_code)

print("[*] Finished fix_3_issues.py successfully!")
