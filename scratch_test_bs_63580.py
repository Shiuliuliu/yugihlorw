import sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/web/src/BattleSkill.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(63580, 63640):
    print(f'{i+1}: {lines[i]}', end='')
