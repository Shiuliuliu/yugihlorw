import os
for fname in ['BattleSkill.lua', 'BattleHelper.lua', 'PlayerBattle.lua', 'Player.lua']:
    p = os.path.join('D:/yugitauapk/web/src', fname)
    if os.path.exists(p):
        with open(p, 'r', encoding='utf-8', errors='ignore') as file:
            for idx, line in enumerate(file):
                if 'getSyncCandidatesByTriggerCard' in line or 'getXYZCandidatesByTriggerCard' in line or 'getLinkCandidatesByTriggerCard' in line:
                    print(f'{fname}:{idx+1}: {line.strip()[:100]}')
