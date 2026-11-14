with open('D:/yugitauapk/web/src/BattleListDialog.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(420, 470):
    print(f'{i+1}: {lines[i]}', end='')
