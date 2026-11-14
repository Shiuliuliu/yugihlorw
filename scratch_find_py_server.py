import os
for fname in os.listdir('D:/yugitauapk'):
    if fname.endswith('.py'):
        p = os.path.join('D:/yugitauapk', fname)
        with open(p, 'r', encoding='utf-8', errors='ignore') as f:
            for idx, line in enumerate(f):
                if 'getSyncCandidates' in line or '3851' in line or 'r2b_sync' in line:
                    print(f'{fname}:{idx+1}: {line.strip()[:100]}')
