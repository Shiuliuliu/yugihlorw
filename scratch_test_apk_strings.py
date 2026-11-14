import zipfile, re

with zipfile.ZipFile('D:/yugitauapk/Yugihlor.apk', 'r') as z:
    so_data = z.read('lib/arm64-v8a/libDuelArcana.so')

urls = set(re.findall(b'https?://[a-zA-Z0-9.-]+(?::[0-9]+)?/[^ \t\r\n\'\"<>]*', so_data))
for u in sorted(urls):
    print(u.decode('ascii', errors='ignore'))
