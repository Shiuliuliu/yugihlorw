with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if 'setChoiceFunction' in line:
            print(f'{idx+1}: {line.strip()[:100]}')
