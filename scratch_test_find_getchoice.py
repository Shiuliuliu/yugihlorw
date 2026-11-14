with open('D:/yugitauapk/web/src/BattleHelper.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'getChoiceByCandidatePos' in line and 'function' in line:
            print(f'{idx+1}: {line}')
