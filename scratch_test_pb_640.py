with open('D:/yugitauapk/web/src/PlayerBattle.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(634, min(len(lines), 705)):
    print(f'{i+1}: {lines[i]}', end='')
