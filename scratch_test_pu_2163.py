import sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for target in [2163, 7811]:
    print(f"=== Target {target} ===")
    for i in range(target-10, target+20):
        print(f'{i+1}: {lines[i]}', end='')
