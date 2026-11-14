import os
import subprocess
import sys

sys.stdout.reconfigure(encoding='utf-8')

OLD_VER = '20261111v043500'
NEW_VER = '20261111v054500'

print(f"[*] Updating version from {OLD_VER} to {NEW_VER}...")

# 1. Update index.html
index_path = r"D:\yugitauapk\web\index.html"
with open(index_path, 'r', encoding='utf-8') as f:
    index_content = f.read()

if OLD_VER in index_content:
    index_content = index_content.replace(OLD_VER, NEW_VER)
    with open(index_path, 'w', encoding='utf-8') as f:
        f.write(index_content)
    print(f"[OK] Updated {index_path}")
else:
    print(f"[WARN] {OLD_VER} not found in {index_path}")

# 2. Update sw.js
sw_path = r"D:\yugitauapk\web\sw.js"
with open(sw_path, 'r', encoding='utf-8') as f:
    sw_content = f.read()

if OLD_VER in sw_content:
    sw_content = sw_content.replace(OLD_VER, NEW_VER)
    with open(sw_path, 'w', encoding='utf-8') as f:
        f.write(sw_content)
    print(f"[OK] Updated {sw_path}")
else:
    print(f"[WARN] {OLD_VER} not found in {sw_path}")

# 3. Run sync_game.py
print("\n[*] Running sync_game.py...")
res = subprocess.run([sys.executable, r"D:\yugitauapk\sync_game.py"], capture_output=True, text=True, encoding='utf-8')
print(res.stdout)
if res.stderr:
    print("STDERR:", res.stderr)

print("\n[*] All sync completed!")
