with open('D:/yugitauapk/web/src/BattleUiTouch.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'showChoice' in line or 'castInitiativeSkill' in line or 'isCeremony' in line or 'send_use_card' in line:
            print(f'BattleUiTouch.lua:{idx+1}: {line.strip()[:100]}')
