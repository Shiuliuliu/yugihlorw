with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

in_func = False
for idx, line in enumerate(lines):
    if 'function var_0_0.onChoiceGrave' in line:
        in_func = True
    elif in_func and line.startswith('function '):
        break
    if in_func:
        if any(x in line.lower() for x in ['ceremony', '14644', '21138', '12316']):
            print(f'{idx+1}: {line.strip()[:100]}')
