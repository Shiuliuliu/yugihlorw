import zipfile

with zipfile.ZipFile('D:/yugitauapk/Yugihlor.apk', 'r') as z:
    for name in z.namelist():
        if 'src/' in name or 'lua' in name or '.bin' in name:
            print(name)
