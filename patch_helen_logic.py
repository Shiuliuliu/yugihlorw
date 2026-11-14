# -*- coding: utf-8 -*-
BS_PATH = r"D:\yugitauapk\web\src\BattleSkill.lua"

print("[*] Starting patch_helen_logic.py...")

with open(BS_PATH, 'r', encoding='utf-8') as f:
    bs = f.read()

# 1. canUseInitiativeSkill
target_can_use = "arg_36_2._id == 20232 or arg_36_2._id == 20233"
repl_can_use = "arg_36_2._id == 20232 or arg_36_2._id == 20233 or arg_36_2._id == 20235"

if target_can_use in bs:
    bs = bs.replace(target_can_use, repl_can_use, 1)
    print("[OK] canUseInitiativeSkill updated with 20235.")
elif "20235" in bs and "canUseInitiativeSkill1" in bs:
    print("[SKIP] 20235 already in canUseInitiativeSkill.")
else:
    print("[WARN] target_can_use not found in BattleSkill.lua!")

# 2. canUseInitiativeSkill1
target_can_use_1 = """		return hasDeckLiqi"""

repl_can_use_1 = """		return hasDeckLiqi
	elseif var_37_0 == 20235 then
		-- HELEN (12386): Chu dong tay: LP phe ta thap hon doi phuong -> trieu hoi dac biet len san
		if arg_37_1._status ~= BattleData.CardStatus.hand then
			return false
		end

		if arg_37_0._isSummonDisabled or arg_37_0._isSpecialSummonDisabled or not arg_37_0:canSpecialSummon(arg_37_1) then
			return false
		end

		if #arg_37_0:filterCanChangeToBoardCards({
			arg_37_1
		}) == 0 then
			return false
		end

		local selfHp = arg_37_0._fortress and arg_37_0._fortress._hp or 0
		local oppoHp = arg_37_0._opponent and arg_37_0._opponent._fortress and arg_37_0._opponent._fortress._hp or 0

		return selfHp < oppoHp"""

if "var_37_0 == 20235" not in bs:
    if target_can_use_1 in bs:
        bs = bs.replace(target_can_use_1, repl_can_use_1, 1)
        print("[OK] canUseInitiativeSkill1 updated with 20235.")
    else:
        print("[WARN] target_can_use_1 not found in BattleSkill.lua!")
else:
    print("[SKIP] 20235 already in canUseInitiativeSkill1.")

# 3. castMonsterSpellSkill for 20235
target_cast_20235 = "elseif var_4_4 == 14794 or var_4_4 == 20222 then"
repl_cast_20235 = "elseif var_4_4 == 14794 or var_4_4 == 20222 or var_4_4 == 20235 then"

if target_cast_20235 in bs:
    bs = bs.replace(target_cast_20235, repl_cast_20235, 1)
    print("[OK] castMonsterSpellSkill updated with 20235.")
elif "var_4_4 == 20235" in bs:
    print("[SKIP] 20235 already in castMonsterSpellSkill.")
else:
    print("[WARN] target_cast_20235 not found in BattleSkill.lua!")

# 4. castMonsterSpellSkill for 20236
target_cast_20236 = """		if oppoLp > 0 and pOwner._opponent and pOwner._opponent._fortress then
			arg_4_0:incHp(pOwner._opponent._fortress, oppoLp, false, var_4_5, var_4_4, arg_4_3)
		end
		var_4_13 = true"""

repl_cast_20236 = target_cast_20236 + """
	elseif var_4_4 == 20236 then
		-- HELEN (12386): Khi len san, phe ta tang 500 LP, neu doi phuong co nhieu hon phe ta 4000 LP thi tang them 500 LP nua
		local helenCard = var_4_1 or arg_4_1
		local pOwner = (helenCard and helenCard._owner) or arg_4_0
		local selfHp = pOwner._fortress and pOwner._fortress._hp or 0
		local oppoHp = pOwner._opponent and pOwner._opponent._fortress and pOwner._opponent._fortress._hp or 0

		local healAmount = 500
		if (oppoHp - selfHp) > 4000 then
			healAmount = healAmount + 500
		end

		if healAmount > 0 and pOwner._fortress then
			arg_4_0:incHp(pOwner._fortress, healAmount, false, var_4_5, var_4_4, arg_4_3)
			var_4_13 = true
		end"""

if "var_4_4 == 20236" not in bs:
    if target_cast_20236 in bs:
        bs = bs.replace(target_cast_20236, repl_cast_20236, 1)
        print("[OK] castMonsterSpellSkill updated with 20236.")
    else:
        print("[WARN] target_cast_20236 not found in BattleSkill.lua!")
else:
    print("[SKIP] 20236 already in castMonsterSpellSkill.")

with open(BS_PATH, 'w', encoding='utf-8') as f:
    f.write(bs)

print("[*] Finished patch_helen_logic.py!")
