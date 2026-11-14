with open('D:/yugitauapk/web/src/PlayerBattle.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'r2b_link' in line or 'summonLink' in line or 'b2g_link' in line or '_summonedByLink' in line or 'r2b_sync' in line or 'r2b_xyz' in line:
            print(f'PlayerBattle.lua:{idx+1}: {line.strip()[:100]}')

with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'r2b_link' in line or 'summonLink' in line or 'b2g_link' in line or '_summonedByLink' in line or 'r2b_sync' in line or 'r2b_xyz' in line:
            print(f'PlayerUi.lua:{idx+1}: {line.strip()[:100]}')
