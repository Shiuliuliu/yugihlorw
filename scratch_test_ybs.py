import sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/yugioh_battle_server.py', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if 'class ' in line or 'def ' in line:
        if idx < 150:
            print(f'{idx+1}: {line.strip()}')
