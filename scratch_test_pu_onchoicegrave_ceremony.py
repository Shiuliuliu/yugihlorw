with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i in range(4340, 4440):
    if 'ceremony' in lines[i].lower() or '14644' in lines[i] or '21138' in lines[i]:
        print(f'{i+1}: {lines[i]}', end='')
