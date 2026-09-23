import json
import sys
sys.stdout.reconfigure(encoding='utf-8')

forbidden_cids = {
    20841, 20842, 20843, 20844, 20845, # Mắt Đỏ-Chiến Đao I..V
    20961, 20962, 20963, 20964, 20965, # Lưỡi Thần Nộ I..V
    20981, 20982, 20983, 20984, 20985, # Kiếm Diệt Chủng I..V
    20525,                              # Kỵ Binh·Kỵ Sĩ Rồng Quyền Trượng II
    20804, 20805, 20806, 20807, 20808, 20809, 20810, # Substitute Crystal Beast spells
    30439, 11309,
    20233,                              # Cú Đấm Thần Thánh
    20236,                              # Trao Đổi Linh Hồn
    11753,                              # Token Link
}

files = ['char_cards_map.json', 'liya_cards_map.json', 'extra_cards_map.json', 'expansion_cards_map.json']
violations = []
for fn in files:
    with open(fn, 'r', encoding='utf-8') as f:
        data = json.load(f)
    for k, cids in data.items():
        for cid in cids:
            if cid in forbidden_cids:
                violations.append((fn, k, cid))

with open('pack_quality_distribution.json', 'r', encoding='utf-8') as f:
    qmap = json.load(f)
for k, qdata in qmap.items():
    for qk in ['GR', 'UR_ANCIENT', 'UR', 'SR', 'R', 'N']:
        for cid in qdata[qk]:
            if cid in forbidden_cids:
                violations.append(('pack_quality_distribution', k, qk, cid))

if violations:
    print(f"FAILED! Found {len(violations)} forbidden cards:", violations)
else:
    print("SUCCESS: 0 FORBIDDEN CARDS FOUND ACROSS ALL PACKS AND QUALITY MAPS!")
