import sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/web/src/h5_patch.lua', 'r', encoding='utf-8') as f:
    for line in f:
        if '56858' in line or '56862' in line or '56857' in line:
            print(line.strip())
