import zipfile

for apk in ['DuelArcana_Web.apk', 'DuelArcana_Local.apk', 'Yugihlor.ipa']:
    try:
        with zipfile.ZipFile('D:/yugitauapk/' + apk, 'r') as z:
            print(f"=== {apk} ===")
            for name in z.namelist()[:10]:
                print(' ', name)
    except Exception as e:
        print(f"=== {apk} === Error:", e)
