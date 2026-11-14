with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    for idx, line in enumerate(f):
        if ':onUseCard(' in line or 'function var_0_0.onUseCard' in line:
            print(f'{idx+1}: {line.strip()[:100]}')
