with open('D:/yugitauapk/web/src/PlayerBattle.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for start, end in [(710, 735), (1075, 1120), (1370, 1395)]:
    print(f"=== Lines {start}-{end} ===")
    for i in range(start-1, min(len(lines), end)):
        print(f'{i+1}: {lines[i]}', end='')
