import sys
sys.stdout.reconfigure(encoding='utf-8')

with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'getValidCeremonyResultCardsByTriggerCard' in line or 'showChoiceCeremony' in line:
            print(f'PlayerUi.lua:{idx+1}: {line.strip()[:100]}')
