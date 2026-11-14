with open('D:/yugitauapk/web/src/BattleListDialog.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'Mode.ceremony' in line or 'ceremony' in line.lower() and 'star' in line.lower():
            print(f'{idx+1}: {line.strip()[:100]}')
