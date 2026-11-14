import zipfile

with zipfile.ZipFile('D:/yugitauapk/Yugihlor.apk', 'r') as z:
    for name in z.namelist()[:30]:
        print(name)
