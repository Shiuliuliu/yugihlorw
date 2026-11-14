import os
for root, dirs, files in os.walk('D:/yugitauapk/web/src'):
    for f in files:
        if f.endswith('.lua'):
            p = os.path.join(root, f)
            with open(p, 'r', encoding='utf-8', errors='ignore') as file:
                for idx, line in enumerate(file):
                    if 'getChoiceByCandidatePos' in line and 'function' in line:
                        print(f'{f}:{idx+1}: {line}')
