@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - 5 SERVERS + 1 TUNNEL [APK / ANDROID + WEB H5]
color 0A
cls

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE - KHOI DONG 5 SERVERS + 1 TUNNEL (APK + WEB)
echo ===================================================================
echo   1. Database MySQL (XAMPP)       : Port 3306 (DB: yugioh_game)
echo   2. Sinh Tu Chien Server         : Port 8085
echo   3. Chat Server                  : Port 8084 ^& WS 9193
echo   4. Shop Server                  : Port 8082
echo   5. APK Native TCP Proto Server  : Port 9191
echo   6. Cloudflare Tunnel            : https://yugihlor.online
echo   7. Game ^& Battle Web Server     : Port 8080 ^& WS 9192
echo ===================================================================
echo   * Domain Online (Web) : https://yugihlor.online
echo   * Local Game (Web)    : http://localhost:8080
echo   * APK Native (Android): D:\yugitauapk (Port 9191)
echo   * Database            : yugioh_game @ 127.0.0.1:3306
echo ===================================================================
echo.

echo [1/7] Kiem tra Database MySQL (Port 3306) & Database yugioh_game...
netstat -ano | findstr ":3306 " >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo     -^> MySQL chua bat! Dang tu dong khoi chay MySQL tu XAMPP...
    if exist "C:\xampp\mysql_start.bat" (
        start "MySQL Database Server" /min cmd /c "C:\xampp\mysql_start.bat"
        ping 127.0.0.1 -n 4 >nul
    ) else if exist "C:\xampp\mysql\bin\mysqld.exe" (
        start "MySQL Database Server" /min "C:\xampp\mysql\bin\mysqld.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" --standalone
        ping 127.0.0.1 -n 4 >nul
    )
    echo     -^> Da khoi dong xong MySQL Database!
) else (
    echo     -^> MySQL dang hoat dong san sang!
)

python -c "import pymysql; conn=pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game'); print('     -> Database [yugioh_game] KET NOI THANH CONG!')"
if %ERRORLEVEL% neq 0 (
    echo [LOI] Khong the ket noi vao database yugioh_game! Vui long kiem tra MySQL.
    pause
    exit /b
)
echo.

echo [2/7] Don dep tien trinh cu tren Port 8080, 9192, 8082, 8084, 9193, 8085, 9191 va Tunnel...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9192 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8082 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8084 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9193 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8085 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9191 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
taskkill /IM cloudflared.exe /F >nul 2>&1

echo [3/7] Dang khoi chay Sinh Tu Chien Server tren Port 8085...
start "Yu-Gi-Oh Survival Server [Port 8085]" cmd /k "title SURVIVAL SERVER [Port 8085] && color 0D && python yugioh_survival_server.py"

echo [4/7] Dang khoi chay Chat Server tren Port 8084 ^& 9193...
start "Yu-Gi-Oh Chat Server [Port 8084/9193]" cmd /k "title CHAT SERVER [Port 8084/9193] && color 0E && python yugioh_chat_server.py"

echo [5/7] Dang khoi chay Dedicated Shop Server tren Port 8082...
start "Yu-Gi-Oh Shop Server [Port 8082]" cmd /k "title SHOP SERVER [Port 8082] && color 0B && python yugioh_shop_server.py"

echo [6/7] Dang khoi chay APK Native Protobuf Server tren Port 9191...
start "Yu-Gi-Oh APK Native Server [Port 9191]" cmd /k "title APK PROTO SERVER [Port 9191] && color 0A && python yugioh_proto_server.py"

echo [7/7] Dang khoi chay Cloudflare Tunnel (yugihlor.online)...
start "Yu-Gi-Oh Cloudflare Tunnel [yugihlor.online]" cmd /k "title CLOUDFLARE TUNNEL [yugihlor.online] && color 09 && cloudflared.exe tunnel --config config.yml --protocol http2 run"

echo.
echo ===================================================================
echo   Dang khoi chay Game ^& Battle Server tren Port 8080/9192...
echo ===================================================================
echo.
python yugioh_web_server.py
pause
