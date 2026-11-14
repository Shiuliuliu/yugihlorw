with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for start, end in [(1465, 1490), (4425, 4475)]:
    print(f"=== Lines {start}-{end} ===")
    for i in range(start-1, min(len(lines), end)):
        print(f'{i+1}: {lines[i]}', end='')
