with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'function' in line and 'use' in line.lower() and 'card' in line.lower():
            print(f'{idx+1}: {line.strip()[:100]}')
