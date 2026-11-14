with open('D:/yugitauapk/duelh5_PlayerUi.lua', 'r', encoding='utf-8', errors='ignore') as f:
    dh5_lines = f.readlines()

with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8', errors='ignore') as f:
    loc_lines = f.readlines()

print("DH5 lines around 3780-3810:")
for i in range(3780, 3810):
    print(f"{i+1}: {dh5_lines[i]}", end='')

print("\nLoc lines around 4440-4475:")
for i in range(4440, 4475):
    print(f"{i+1}: {loc_lines[i]}", end='')
