with open('D:/yugitauapk/duelh5_PlayerUi.lua', 'r', encoding='utf-8', errors='ignore') as f:
    dh5_lines = f.readlines()

with open('D:/yugitauapk/web/src/PlayerUi.lua', 'r', encoding='utf-8', errors='ignore') as f:
    loc_lines = f.readlines()

print("DH5 lines around 1320-1345:")
for i in range(1320, 1345):
    print(f"{i+1}: {dh5_lines[i]}", end='')

print("\nLoc lines around 1470-1495:")
for i in range(1470, 1495):
    print(f"{i+1}: {loc_lines[i]}", end='')
