with open('D:/yugitauapk/web/src/Data.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if 'MonsterOption' in line:
        for j in range(idx, idx+30):
            print(f'{j+1}: {lines[j]}', end='')
        break
