# Script cai dat Quyet Chien Chi Thanh + Goi Viet Hoa qua ADB
$ErrorActionPreference = "Continue"

$adbCandidates = @(
    "C:\Program Files\Netease\MuMuPlayer\nx_device\15.0\shell\adb.exe",
    "C:\Program Files\Netease\MuMuPlayer\nx_main\adb.exe",
    "C:\LDPlayer\LDPlayer9\adb.exe",
    "adb.exe"
)

$adb = $null
foreach ($cand in $adbCandidates) {
    if (Test-Path $cand) {
        $adb = $cand
        break
    }
}

if (-not $adb) {
    $adb = "adb"
}

Write-Host "Su dung ADB tai: $adb" -ForegroundColor Cyan

# Ket noi cac cong gia lap thong dung
& $adb connect 127.0.0.1:16384 | Out-Null
& $adb connect 127.0.0.1:16416 | Out-Null
& $adb connect 127.0.0.1:7555 | Out-Null
& $adb connect 127.0.0.1:5555 | Out-Null

$devicesOutput = & $adb devices
Write-Host $devicesOutput

$deviceList = @()
foreach ($line in ($devicesOutput -split "`r?`n")) {
    if ($line -match "^([a-zA-Z0-9\.\:\-]+)\s+device$") {
        $deviceList += $matches[1]
    }
}

if ($deviceList.Count -eq 0) {
    Write-Host "[ERROR] Khong tim thay thiet bi Android / Gia lap nao dang chay!" -ForegroundColor Red
    Write-Host "Vui long mo MuMu Player hoac LDPlayer len truoc." -ForegroundColor Yellow
    Exit 1
}

Write-Host "Cac thiet bi duoc tim thay: $($deviceList -join ', ')" -ForegroundColor Green
$targetDevice = $deviceList[0]
Write-Host "Chon thiet bi cai dat: $targetDevice" -ForegroundColor Cyan

# Kiem tra ABI thiet bi
$abis = & $adb -s $targetDevice shell getprop ro.product.cpu.abilist
Write-Host "Kien truc CPU cua gia lap: $abis" -ForegroundColor Gray

if ($abis -notmatch "armeabi") {
    Write-Host "[CANH BAO] Gia lap nay ($targetDevice) khong ho tro 32-bit armeabi!" -ForegroundColor Red
    Write-Host "Neu gap loi INSTALL_FAILED_NO_MATCHING_ABIS, ban can dung MuMu (Android 12) hoac LDPlayer 9." -ForegroundColor Yellow
}

$apkPath = "D:\yugitauapk\QuyetChienChiThanh_base_sign_1.apk"
$tarPath = "D:\yugitauapk\1.0.7.tar"

Write-Host "`n[BUOC 1] Dang cai dat APK: $apkPath ..." -ForegroundColor Cyan
& $adb -s $targetDevice install -r $apkPath

Write-Host "`n[BUOC 2] Khoi dong game 1 lan de tao thu muc data..." -ForegroundColor Cyan
& $adb -s $targetDevice shell monkey -p com.tuoyin.jdzc.android.guopan -c android.intent.category.LAUNCHER 1 | Out-Null
Start-Sleep -Seconds 5
& $adb -s $targetDevice shell am force-stop com.tuoyin.jdzc.android.guopan | Out-Null

Write-Host "`n[BUOC 3] Bat quyen Root va chép goi Viet hoa..." -ForegroundColor Cyan
& $adb -s $targetDevice root | Out-Null
Start-Sleep -Seconds 2

& $adb -s $targetDevice shell mkdir -p /data/data/com.tuoyin.jdzc.android.guopan/files
& $adb -s $targetDevice push $tarPath /data/local/tmp/1.0.7.tar
& $adb -s $targetDevice shell "tar -xf /data/local/tmp/1.0.7.tar -C /data/data/com.tuoyin.jdzc.android.guopan/files/"
& $adb -s $targetDevice shell rm -f /data/local/tmp/1.0.7.tar

Write-Host "`n[BUOC 4] Phan quyen 777 cho thu muc Viet hoa..." -ForegroundColor Cyan
& $adb -s $targetDevice shell "chmod -R 777 /data/data/com.tuoyin.jdzc.android.guopan/files"

Write-Host "`n[BUOC 5] Khoi dong game..." -ForegroundColor Cyan
& $adb -s $targetDevice shell monkey -p com.tuoyin.jdzc.android.guopan -c android.intent.category.LAUNCHER 1

Write-Host "`n[HOAN TAT] Da cai dat va chép Viet hoa thanh cong!" -ForegroundColor Green