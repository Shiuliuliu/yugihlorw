import sys
from build_mysql_db import raw_traps, get_text

sys.stdout.reconfigure(encoding='utf-8')

for t in raw_traps:
    name = get_text(t['_nameSid'])
    for k in ['bảy công cụ', 'phán quyết', 'tuyên cáo', 'phản đòn', 'vô hiệu hóa', 'thánh', 'thần']:
        if k in name.lower():
            print(f"ID: {t['_id']}, Type: {t['_type']}, Name: {name}")
            break
