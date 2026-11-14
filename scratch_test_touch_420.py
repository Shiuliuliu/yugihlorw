with open('D:/yugitauapk/web/src/BattleUiTouch.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(405, 440):
    print(f'{i+1}: {lines[i]}', end='')
