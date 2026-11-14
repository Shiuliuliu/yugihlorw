import os
for fname in ['PlayerUi.lua', 'PlayerBattle.lua', 'BattleUi.lua', 'CardSprite.lua']:
    p = os.path.join('D:/yugitauapk/web/src', fname)
    if os.path.exists(p):
        with open(p, 'r', encoding='utf-8', errors='ignore') as file:
            for idx, line in enumerate(file):
                if 'isLink' in line or 'link' in line.lower() and 'summon' in line.lower():
                    print(f'{fname}:{idx+1}: {line.strip()[:100]}')
