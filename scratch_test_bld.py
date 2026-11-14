with open('D:/yugitauapk/web/src/BattleListDialog.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if 'onChoice' in line or 'onConfirm' in line or 'Mode.sync' in line:
        for j in range(max(0, idx-5), min(len(lines), idx+20)):
            print(f'{j+1}: {lines[j]}', end='')
        print("-------------")
