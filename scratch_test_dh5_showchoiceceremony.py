with open('D:/yugitauapk/duelh5_PlayerUi.lua', 'r', encoding='utf-8', errors='ignore') as f:
    for idx, line in enumerate(f):
        if 'showChoiceCeremony' in line:
            print(f'Line {idx+1}: {line.strip()[:100]}')
