with open('D:/yugitauapk/duelh5_PlayerUi.lua', 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if 'getSyncCandidatesByTriggerCard' in line:
        print(f"Line {idx+1}: {line.strip()[:100]}")
        for j in range(max(0, idx-2), min(len(lines), idx+10)):
            print(f'  {j+1}: {lines[j]}', end='')
        print("-------------")
