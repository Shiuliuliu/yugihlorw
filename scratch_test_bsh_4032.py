with open('D:/yugitauapk/web/src/BattleStaticHelper.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(4031, 4055):
    print(f'{i+1}: {lines[i]}', end='')
