with open('D:/yugitauapk/web/src/BattleHelper.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(6750, 6790):
    print(f'{i+1}: {lines[i]}', end='')
