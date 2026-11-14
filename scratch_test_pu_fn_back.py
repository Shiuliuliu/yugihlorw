with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(1440, 1200, -1):
    if lines[i].startswith('function '):
        print(f'{i+1}: {lines[i]}')
        break
