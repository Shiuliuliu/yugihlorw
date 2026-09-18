"""
Patch data_dumps.json:
1. Set _available=1 for all cards in monster.bin, magic.bin, trap.bin, rare.bin
2. Set _isHide=0 for all cards (make all visible)
This fixes the card sync issue where 4721 DB cards are not showing in game.
"""
import json, re, sys, io, os
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

DUMPS_PATH = r'D:\yugitauapk\web\data_dumps.json'

print('Loading data_dumps.json...')
with open(DUMPS_PATH, 'r', encoding='utf-8') as f:
    dumps = json.load(f)

total_changed = 0

for binfile in ['monster.bin', 'magic.bin', 'trap.bin', 'rare.bin']:
    s = dumps.get(binfile, '')
    if not s:
        print(f'{binfile}: NOT FOUND')
        continue
    
    # Count before
    before_avail = len(re.findall(r'_available\"\]=1', s))
    before_hide  = len(re.findall(r'_isHide\"\]=0', s))
    
    # Set _available=1 (was 0 for all)
    s2 = re.sub(r'(_available"\])=0', r'\1=1', s)
    
    # Set _isHide=0 (was 1 or 2 for some)
    s2 = re.sub(r'(_isHide"\])=[12]', r'\1=0', s2)
    
    # Count after
    after_avail = len(re.findall(r'_available\"\]=1', s2))
    after_hide  = len(re.findall(r'_isHide\"\]=0', s2))
    changed = (s != s2)
    
    dumps[binfile] = s2
    total_changed += 1 if changed else 0
    print(f'{binfile}: _available 0→1: {after_avail - before_avail} cards, _isHide cleared: {after_hide - before_hide}')

print(f'\nSaving patched data_dumps.json...')
# Backup first
import shutil
backup = DUMPS_PATH + '.bak'
if not os.path.exists(backup):
    shutil.copy2(DUMPS_PATH, backup)
    print(f'Backup saved: {backup}')

with open(DUMPS_PATH, 'w', encoding='utf-8') as f:
    json.dump(dumps, f, ensure_ascii=False, separators=(',', ':'))

size = os.path.getsize(DUMPS_PATH)
print(f'Done! data_dumps.json saved ({size//1024//1024}MB)')
print('All cards are now available and visible in client.')
