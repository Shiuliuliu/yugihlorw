import sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/web/src/PlayerBattle.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(638, min(len(lines), 710)):
    print(f'{i+1}: {lines[i]}', end='')
