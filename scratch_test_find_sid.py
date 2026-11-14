import os, sys
sys.stdout.reconfigure(encoding='utf-8')

for root, dirs, files in os.walk('D:/yugitauapk/web'):
    for f in files:
        if f.endswith(('.json', '.txt', '.lua', '.js')):
            p = os.path.join(root, f)
            try:
                with open(p, 'r', encoding='utf-8', errors='ignore') as file:
                    content = file.read()
                if '56858' in content:
                    print(f"Found 56858 in {p}")
                    for line in content.splitlines():
                        if '56858' in line:
                            print(f"  {line[:150]}")
            except:
                pass
