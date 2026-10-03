import re

with open('web/data/magic.lua', 'r', encoding='utf-8') as f:
    text = f.read()

for cid in [20276, 21101, 21108, 21113, 21115, 21126]:
    pos = text.find(f"[{cid}]=")
    if pos != -1:
        chunk = text[pos:pos+400]
        # find matching brace
        print(f"=== Card {cid} ===")
        print(chunk[:chunk.find("},")+2])
    else:
        print(f"Card {cid} NOT FOUND")
