import zipfile, re

with zipfile.ZipFile('D:/yugitauapk/Yugihlor.apk', 'r') as z:
    dex_data = z.read('classes.dex')

urls = set(re.findall(b'https?://[a-zA-Z0-9.-]+(?::[0-9]+)?/[^ \t\r\n\'\"<>]*', dex_data))
for u in sorted(urls):
    print(u.decode('ascii', errors='ignore'))
