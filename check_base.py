import zipfile, struct
with zipfile.ZipFile(r"D:\yugitauapk\QuyetChienChiThanh_base_sign_1.apk") as z:
    data = z.read("assets/res/lan.lcres")
v1, v2 = struct.unpack("<II", data[4:12])
print(f"base APK lan.lcres: v1={v1}, v2={v2}, len={len(data)}")