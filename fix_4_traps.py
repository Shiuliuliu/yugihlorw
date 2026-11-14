#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os, sys, pymysql

sys.stdout.reconfigure(encoding='utf-8')

print("[*] Starting fix for 4 Trap cards (30598, 30599, 30600, 30601)...")

# 1. Update web/data/skill.lua with skills 20117..20120 if not present
skill_path = r"D:\yugitauapk\web\data\skill.lua"
with open(skill_path, 'r', encoding='utf-8') as f:
    skill_content = f.read()

skills_to_add = """  [20117]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58052,["_effectVal"]={[1]=0,},["_id"]=20117,["_isIgnoreDefend"]=0,["_modes"]={[1]=32,},["_nameSid"]=58050,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=0,},["_refSkills"]={[1]=0,},["_sourceStatus"]=0,["_target"]=1,["_val"]={[1]=0,},},
  [20118]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58057,["_effectVal"]={[1]=0,},["_id"]=20118,["_isIgnoreDefend"]=0,["_modes"]={[1]=32,},["_nameSid"]=58055,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=0,},["_refSkills"]={[1]=0,},["_sourceStatus"]=0,["_target"]=1,["_val"]={[1]=0,},},
  [20119]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58062,["_effectVal"]={[1]=0,},["_id"]=20119,["_isIgnoreDefend"]=0,["_modes"]={[1]=32,},["_nameSid"]=58060,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=0,},["_refSkills"]={[1]=0,},["_sourceStatus"]=0,["_target"]=1,["_val"]={[1]=0,},},
  [20120]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58067,["_effectVal"]={[1]=0,},["_id"]=20120,["_isIgnoreDefend"]=0,["_modes"]={[1]=32,},["_nameSid"]=58065,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=0,},["_refSkills"]={[1]=0,},["_sourceStatus"]=0,["_target"]=1,["_val"]={[1]=0,},},
"""

if "[20117]" not in skill_content:
    idx = skill_content.rfind("}")
    if idx != -1:
        skill_content = skill_content[:idx] + skills_to_add + skill_content[idx:]
        with open(skill_path, 'w', encoding='utf-8') as f:
            f.write(skill_content)
        print("[OK] Added skills 20117..20120 to web/data/skill.lua")
else:
    print("[SKIP] Skills 20117..20120 already in web/data/skill.lua")

# 2. Update h5_patch.lua with Data._trapInfo and Data._skillInfo for 30598..30601 & 20117..20120
patch_path = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(patch_path, 'r', encoding='utf-8') as f:
    patch_content = f.read()

patch_code = """
			-- 4 New Trap Cards: 30598..30601
			if Data._trapInfo then
				if not Data._trapInfo[30598] then
					Data._trapInfo[30598] = {
						_available = 1, _briefNameSid = 58051, _descSid = 58052, _guideSid = 0,
						_id = 30598, _isHide = 0, _isSummon = 0, _keyword = 0, _maxCount = 3,
						_nameSid = 58050, _option = 0, _originId = 0, _packageId = { 0 },
						_picId = 0, _py = "dbarrier", _quality = 4, _recruitable = 1,
						_skillId = { 20117 }, _targetType = 0, _type = 12
					}
				end
				if not Data._trapInfo[30599] then
					Data._trapInfo[30599] = {
						_available = 1, _briefNameSid = 58056, _descSid = 58057, _guideSid = 0,
						_id = 30599, _isHide = 0, _isSummon = 0, _keyword = 0, _maxCount = 3,
						_nameSid = 58055, _option = 0, _originId = 0, _packageId = { 0 },
						_picId = 0, _py = "dimpulse", _quality = 4, _recruitable = 1,
						_skillId = { 20118 }, _targetType = 0, _type = 12
					}
				end
				if not Data._trapInfo[30600] then
					Data._trapInfo[30600] = {
						_available = 1, _briefNameSid = 58061, _descSid = 58062, _guideSid = 0,
						_id = 30600, _isHide = 0, _isSummon = 0, _keyword = 0, _maxCount = 3,
						_nameSid = 58060, _option = 0, _originId = 0, _packageId = { 0 },
						_picId = 0, _py = "dspark", _quality = 4, _recruitable = 1,
						_skillId = { 20119 }, _targetType = 0, _type = 12
					}
				end
				if not Data._trapInfo[30601] then
					Data._trapInfo[30601] = {
						_available = 1, _briefNameSid = 58066, _descSid = 58067, _guideSid = 0,
						_id = 30601, _isHide = 0, _isSummon = 0, _keyword = 0, _maxCount = 3,
						_nameSid = 58065, _option = 0, _originId = 0, _packageId = { 0 },
						_picId = 0, _py = "trapholic", _quality = 4, _recruitable = 1,
						_skillId = { 20120 }, _targetType = 0, _type = 12
					}
				end
			end

			-- Skills 20117..20120
			if Data._skillInfo then
				Data._skillInfo[20117] = {
					_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
					_descSid = 58052, _effectVal = { 0 }, _id = 20117, _isIgnoreDefend = 0,
					_modes = { 32 }, _nameSid = 58050, _needExtraGem = 0, _needNoGem = 0,
					_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 0 },
					_refSkills = { 0 }, _sourceStatus = 0, _target = 1, _val = { 0 }
				}
				Data._skillInfo[20118] = {
					_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
					_descSid = 58057, _effectVal = { 0 }, _id = 20118, _isIgnoreDefend = 0,
					_modes = { 32 }, _nameSid = 58055, _needExtraGem = 0, _needNoGem = 0,
					_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 0 },
					_refSkills = { 0 }, _sourceStatus = 0, _target = 1, _val = { 0 }
				}
				Data._skillInfo[20119] = {
					_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
					_descSid = 58062, _effectVal = { 0 }, _id = 20119, _isIgnoreDefend = 0,
					_modes = { 32 }, _nameSid = 58060, _needExtraGem = 0, _needNoGem = 0,
					_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 0 },
					_refSkills = { 0 }, _sourceStatus = 0, _target = 1, _val = { 0 }
				}
				Data._skillInfo[20120] = {
					_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
					_descSid = 58067, _effectVal = { 0 }, _id = 20120, _isIgnoreDefend = 0,
					_modes = { 32 }, _nameSid = 58065, _needExtraGem = 0, _needNoGem = 0,
					_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 0 },
					_refSkills = { 0 }, _sourceStatus = 0, _target = 1, _val = { 0 }
				}
			end
"""

if "Data._trapInfo[30598]" not in patch_content:
    target_str = "-- Cua dia nguc (30597)"
    if target_str in patch_content:
        patch_content = patch_content.replace(target_str, patch_code + "\n\t\t\t" + target_str)
        with open(patch_path, 'w', encoding='utf-8') as f:
            f.write(patch_content)
        print("[OK] Added 30598..30601 & 20117..20120 definitions to web/src/h5_patch.lua")
    else:
        print("[WARN] Target '-- Cua dia nguc (30597)' not found in h5_patch.lua")
else:
    print("[SKIP] 30598..30601 already in web/src/h5_patch.lua")

# 3. Update BattleSkill.lua:
# a) canUseTrap for 20117..20120
# b) canUseMonster and canUseMonsterSpecial for _dominusImpulseLock & _dominusSparkLock
# c) canTriggerTrapWhenStatusChange for 20119
bs_path = r"D:\yugitauapk\web\src\BattleSkill.lua"
with open(bs_path, 'r', encoding='utf-8') as f:
    bs_content = f.read()

can_use_trap_target = """	if var_27_1 == 5004 then"""
can_use_trap_code = """	if var_27_1 == 20117 then
		-- Dimensional Barrier (30598): 1 luot chi co the dung 1 la
		if (arg_27_0._castedSkillCounts[20117] or 0) > 0 then
			return false
		end
		return true
	elseif var_27_1 == 20118 then
		-- Dominus Impulse (30599): 1 luot 1 lan
		if (arg_27_0._castedSkillCounts[20118] or 0) > 0 then
			return false
		end
		return true
	elseif var_27_1 == 20119 then
		-- Dominus Spark (30600): 1 luot 1 lan
		if (arg_27_0._castedSkillCounts[20119] or 0) > 0 then
			return false
		end
		return true
	elseif var_27_1 == 20120 then
		-- Trap Holic (30601): pha huy 1 bai Phep/Bay phe ta, lay 1 Bay thuong tu bo bai
		local trapsInGrave = arg_27_0:getBattleCardsByType("G", Data.CardType.trap)
		if #trapsInGrave >= 3 and (arg_27_0._castedSkillCounts[20120] or 0) > 0 then
			return false
		end
		local hasTarget = false
		for _, c in ipairs(B.mergeTable({ arg_27_0:getBattleCards("C"), arg_27_0:getBattleCards("S") })) do
			if c ~= arg_27_1 and c:canChangeToGrave() then
				hasTarget = true
				break
			end
		end
		if not hasTarget and arg_27_1._status ~= BattleData.CardStatus.board and arg_27_1._status ~= BattleData.CardStatus.cover then
			return false
		end
		local hasNormalTrapInDeck = false
		for _, c in ipairs(arg_27_0:getBattleCards("P")) do
			if c._type == Data.CardType.trap and c._info and c._info._type == 12 and c._infoId ~= 30601 then
				hasNormalTrapInDeck = true
				break
			end
		end
		return hasNormalTrapInDeck
	else""" + can_use_trap_target[3:]

if "var_27_1 == 20117" not in bs_content:
    if can_use_trap_target in bs_content:
        bs_content = bs_content.replace(can_use_trap_target, can_use_trap_code, 1)
        print("[OK] Added canUseTrap for 20117..20120 in BattleSkill.lua")
    else:
        print("[WARN] can_use_trap_target not found in BattleSkill.lua")
else:
    print("[SKIP] canUseTrap already contains 20117..20120")

# canUseMonster locks for Dominus
dominus_lock_code = """	if arg_15_0._dominusImpulseLock then
		local nat = arg_15_1:getNature()
		if nat == Data.CardNature.light or nat == Data.CardNature.earth or nat == Data.CardNature.wind then
			return false
		end
	end
	if arg_15_0._dominusSparkLock then
		local nat = arg_15_1:getNature()
		if nat == Data.CardNature.earth or nat == Data.CardNature.water or nat == Data.CardNature.fire or nat == Data.CardNature.wind then
			return false
		end
	end
"""

target_monster_lock = """	if arg_15_0._isUseHandCardDisabled then
		return false
	end"""

if "arg_15_0._dominusImpulseLock" not in bs_content:
    if target_monster_lock in bs_content:
        bs_content = bs_content.replace(target_monster_lock, target_monster_lock + "\n" + dominus_lock_code, 1)
        print("[OK] Added Dominus locks to canUseMonster in BattleSkill.lua")
    else:
        print("[WARN] target_monster_lock not found in BattleSkill.lua")
else:
    print("[SKIP] Dominus locks already in canUseMonster")

# canUseMonsterSpecial locks for Dominus
target_special_lock = """	if arg_19_0._princessHandLockedTurn == arg_19_0._round and arg_19_1._status == BattleData.CardStatus.hand then
		return false
	end"""

dominus_special_lock_code = """	if arg_19_0._dominusImpulseLock then
		local nat = arg_19_1:getNature()
		if nat == Data.CardNature.light or nat == Data.CardNature.earth or nat == Data.CardNature.wind then
			return false
		end
	end
	if arg_19_0._dominusSparkLock then
		local nat = arg_19_1:getNature()
		if nat == Data.CardNature.earth or nat == Data.CardNature.water or nat == Data.CardNature.fire or nat == Data.CardNature.wind then
			return false
		end
	end"""

if "arg_19_0._dominusImpulseLock" not in bs_content:
    if target_special_lock in bs_content:
        bs_content = bs_content.replace(target_special_lock, target_special_lock + "\n" + dominus_special_lock_code, 1)
        print("[OK] Added Dominus locks to canUseMonsterSpecial in BattleSkill.lua")
    else:
        print("[WARN] target_special_lock not found in BattleSkill.lua")
else:
    print("[SKIP] Dominus locks already in canUseMonsterSpecial")

# canTriggerTrapWhenStatusChange for 20119
target_trigger = """	elseif var_32_1 == 5076 or var_32_1 == 5249 or var_32_1 == 5405 or var_32_1 == 5531 or var_32_1 == 20118 then
		if var_32_1 == 20118 and arg_32_1._owner._castedSkillCounts[var_32_1] ~= nil then return false end
		return B.isOppoSpecialSummon(arg_32_1, arg_32_2)"""

repl_trigger = """	elseif var_32_1 == 5076 or var_32_1 == 5249 or var_32_1 == 5405 or var_32_1 == 5531 or var_32_1 == 20118 then
		if var_32_1 == 20118 and arg_32_1._owner._castedSkillCounts[var_32_1] ~= nil then return false end
		return B.isOppoSpecialSummon(arg_32_1, arg_32_2)
	elseif var_32_1 == 20119 then
		if arg_32_1._owner._castedSkillCounts[var_32_1] ~= nil then return false end
		local actCard = arg_32_2
		if not actCard or actCard._owner == arg_32_1._owner then return false end
		local srcSt = actCard._sourceStatus or actCard._status
		return isMonsterCard(actCard) and (srcSt == BattleData.CardStatus.hand or srcSt == BattleData.CardStatus.grave)"""

if "var_32_1 == 20119" not in bs_content:
    if target_trigger in bs_content:
        bs_content = bs_content.replace(target_trigger, repl_trigger, 1)
        print("[OK] Added 20119 to canTriggerTrapWhenStatusChange in BattleSkill.lua")
    else:
        print("[WARN] target_trigger not found in BattleSkill.lua")
else:
    print("[SKIP] 20119 already in canTriggerTrapWhenStatusChange")

with open(bs_path, 'w', encoding='utf-8') as f:
    f.write(bs_content)

# 4. Update BattleStep.lua:
# a) In accountTrap: check c:hasSkills({ 20119 }) in hand
# b) In reset loop: reset _roundDimBarrierType = nil
bstep_path = r"D:\yugitauapk\web\src\BattleStep.lua"
with open(bstep_path, 'r', encoding='utf-8') as f:
    bstep_content = f.read()

target_bstep_hand = """				if c:hasSkills({ 20118 }) then
					table.insert(var_73_0, c)
				end"""

repl_bstep_hand = """				if c:hasSkills({ 20118 }) or c:hasSkills({ 20119 }) then
					table.insert(var_73_0, c)
				end"""

if "c:hasSkills({ 20119 })" not in bstep_content:
    if target_bstep_hand in bstep_content:
        bstep_content = bstep_content.replace(target_bstep_hand, repl_bstep_hand, 1)
        print("[OK] Added 20119 hand trap check to BattleStep.lua")
    else:
        print("[WARN] target_bstep_hand not found in BattleStep.lua")
else:
    print("[SKIP] 20119 already in BattleStep.lua")

# Reset _roundDimBarrierType in BattleStep
target_step_reset = """	for lab_sid = 20135, 20193 do
		arg_58_0._castedSkillCounts[lab_sid] = nil
	end"""

repl_step_reset = """	for lab_sid = 20135, 20193 do
		arg_58_0._castedSkillCounts[lab_sid] = nil
	end
	arg_58_0._roundDimBarrierType = nil
	if arg_58_0._opponent then arg_58_0._opponent._roundDimBarrierType = nil end"""

if "arg_58_0._roundDimBarrierType = nil" not in bstep_content:
    if target_step_reset in bstep_content:
        bstep_content = bstep_content.replace(target_step_reset, repl_step_reset, 1)
        print("[OK] Added _roundDimBarrierType reset to BattleStep.lua")
    else:
        print("[WARN] target_step_reset not found in BattleStep.lua")
else:
    print("[SKIP] _roundDimBarrierType reset already in BattleStep.lua")

with open(bstep_path, 'w', encoding='utf-8') as f:
    f.write(bstep_content)

# 5. Update PlayerUi.lua:
# Add title for 20117 in showChoiceNumber
pui_path = r"D:\yugitauapk\web\src\PlayerUi.lua"
with open(pui_path, 'r', encoding='utf-8') as f:
    pui_content = f.read()

target_pui_num = """	if arg_99_1._card:isSkillAtIndex(2964, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then"""
repl_pui_num = """	if arg_99_1._card:isSkillAtIndex(20117, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) or arg_99_1._card:hasSkillFast(20117) then
		var_99_2 = "Chọn loại quái: 1: Nghi Thức, 2: Dung Hợp, 3: Đồng Bộ, 4: XYZ"
	elseif arg_99_1._card:isSkillAtIndex(2964, math.floor(arg_99_5 / BattleData.ChoiceId.stage_3)) then"""

if "20117, math.floor(arg_99_5" not in pui_content:
    if target_pui_num in pui_content:
        pui_content = pui_content.replace(target_pui_num, repl_pui_num, 1)
        print("[OK] Added 20117 choice title to PlayerUi.lua")
    else:
        print("[WARN] target_pui_num not found in PlayerUi.lua")
else:
    print("[SKIP] 20117 choice title already in PlayerUi.lua")

# Also add skill names to BattleInitiativeSkillsDialog.lua if needed
bis_path = r"D:\yugitauapk\web\src\BattleInitiativeSkillsDialog.lua"
with open(bis_path, 'r', encoding='utf-8') as f:
    bis_content = f.read()

target_bis = """	local dbSkillNames = {"""
repl_bis = """	local dbSkillNames = {
		[20117] = "Rào Chắn Không Gian",
		[20118] = "Xung Lực Thống Trị",
		[20119] = "Tia Lửa Thống Trị",
		[20120] = "Nghiện Bẫy","""

if "[20117]" not in bis_content:
    if target_bis in bis_content:
        bis_content = bis_content.replace(target_bis, repl_bis, 1)
        with open(bis_path, 'w', encoding='utf-8') as f:
            f.write(bis_content)
        print("[OK] Added skill names for 20117..20120 to BattleInitiativeSkillsDialog.lua")
else:
    print("[SKIP] Skill names for 20117..20120 already in BattleInitiativeSkillsDialog.lua")

with open(pui_path, 'w', encoding='utf-8') as f:
    f.write(pui_content)

# 6. Grant cards (30598..30601 and 12371..12381) to admin, shiuliuliu, dung1, ttt2006
conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4', autocommit=True)
with conn.cursor() as cur:
    target_users = ['admin', 'shiuliuliu', 'dung1', 'ttt2006']
    cards_to_grant = [30598, 30599, 30600, 30601] + list(range(12371, 12382))
    for u in target_users:
        cur.execute("SELECT id FROM accounts WHERE username = %s", (u,))
        row = cur.fetchone()
        if row:
            acc_id = row[0]
            records = [(acc_id, cid, 3) for cid in cards_to_grant]
            cur.executemany("""
                INSERT INTO user_cards (account_id, card_id, count)
                VALUES (%s, %s, %s)
                ON DUPLICATE KEY UPDATE count = 3
            """, records)
            print(f"[OK] Granted x3 cards 30598..30601 & 12371..12381 to {u} (ID: {acc_id})")

    # Also check if any other account logged in recently in the last 24h and grant them too
    cur.execute("SELECT id, username FROM accounts WHERE last_login >= NOW() - INTERVAL 1 DAY")
    recent_accs = cur.fetchall()
    for acc_id, uname in recent_accs:
        if uname not in target_users:
            records = [(acc_id, cid, 3) for cid in cards_to_grant]
            cur.executemany("""
                INSERT INTO user_cards (account_id, card_id, count)
                VALUES (%s, %s, %s)
                ON DUPLICATE KEY UPDATE count = 3
            """, records)
            print(f"[OK] Granted x3 cards to recent active user {uname} (ID: {acc_id})")

conn.close()

print("\n[*] All logic & data updates for the 4 Traps applied successfully!")
