with open('D:/yugitauapk/web/src/BattleHelper.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if 'function var_0_0.isValidCeremonyComponents' in line:
        for j in range(idx, idx+30):
            print(f'{j+1}: {lines[j]}', end='')
        break
