import sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(2385, 2450):
    print(f'{i+1}: {lines[i]}', end='')
