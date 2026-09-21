import re
import sys

sys.stdout.reconfigure(encoding='utf-8')
c_info = open('web/data/character_info.lua', encoding='utf-8').read()
lines = open('extend_lan.txt', encoding='utf-8', errors='ignore').readlines()

def get_str(sid):
    return lines[sid-1].strip() if 1 <= sid <= len(lines) else str(sid)

print("=== Characters ===")
for m in re.finditer(r'\[(\d+)\]=\s*\{.*?\["_id"\]=(\d+).*?\["_nameSid"\]=(\d+)', c_info):
    cid = int(m.group(1))
    sid = int(m.group(3))
    print(f"Char ID {cid}: {get_str(sid)}")
