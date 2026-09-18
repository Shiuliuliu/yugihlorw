@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE WEB H5 - KHOI DONG GAME
color 0A

echo ===================================================================
echo         QUYET CHIEN CHI THANH - YU-GI-OH ONLINE WEB H5
echo ===================================================================
echo.
echo [1/3] Dang kiem tra Database MySQL...
python -c "import pymysql; conn=pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game'); print(' -> MySQL ket noi thanh cong!')" 2>nul
if %errorlevel% neq 0 (
    echo [CANH BAO] Khong the ket noi MySQL yugioh_game tren 127.0.0.1:3306!
    echo Hay dam bao XAMPP / WampServer / MySQL dang chay.
    echo.
)

echo [2/3] Dang khoi dong Web Server (Port 8080)...
cd /d "D:\yugitauapk"
start "Yu-Gi-Oh Web Server" cmd /k "python yugioh_web_server.py"

echo [3/3] Dang mo game tren trinh duyet...
timeout /t 2 /nobreak >nul
start http://localhost:8080

echo.
echo ===================================================================
echo  GAME DA DUOC MO TREN TRINH DUYET!
echo  Dia chi: http://localhost:8080 (Port: 8080)
echo.
echo  Tai khoan co san trong database MySQL:
echo    - admin / admin123 (Yugi Muto - Cap 100, 300 the bai)
echo    - kaiba / kaiba123 (Seto Kaiba - Cap 99, 40 the bai)
echo    - joey  / joey123  (Jonouchi  - Cap 50, 39 the bai)
echo.
echo  Hoac bam tab 'Dang ky' de tao tai khoan moi!
echo ===================================================================
echo.
pause
