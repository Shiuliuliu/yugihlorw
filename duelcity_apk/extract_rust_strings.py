import re, sys

sys.stdout.reconfigure(encoding='utf-8')

with open(r'D:\yugitauapk\duelcity_apk\libcore.so', 'rb') as f:
    data = f.read()

# Find rust strings: panic messages, crate names, etc.
rust_strings = re.findall(b'/[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+.rs', data)
for s in set(rust_strings):
    print(s.decode('utf-8', 'ignore'))

# Find all printable strings containing 'dc3' or 'cache' or 'decrypt'
matches = re.findall(b'[a-zA-Z0-9_./:-]{4,}', data)
for m in set(matches):
    low = m.lower()
    if any(k in low for k in [b'dc3', b'dcp', b'catalog', b'alllan', b'allbin', b'encrypt', b'cipher', b'secret']):
        print('Match:', m.decode('utf-8', 'ignore'))
