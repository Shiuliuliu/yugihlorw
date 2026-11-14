import sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/web/src/BattleSkill.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for start, end in [(63340, 63405), (79170, 79200)]:
    print(f"=== Lines {start}-{end} ===")
    for i in range(start-1, min(len(lines), end)):
        print(f'{i+1}: {lines[i]}', end='')
