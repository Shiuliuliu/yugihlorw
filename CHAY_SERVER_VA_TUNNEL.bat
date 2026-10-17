@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - SERVERS + TUNNEL
color 0A
cls

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE - KHOI DONG HE THONG SERVERS + CLOUDFLARE TUNNEL
echo ===================================================================
echo   1. Database MySQL (XAMPP)       : Port 3306 (DB: yugioh_game)
echo   2. Battle Server Chinh (PvP)    : WS Port 9192
echo   3. Sinh Tu Chien Server         : Port 8085
echo   4. Chat Server                  : Port 8084 va WS 9193
echo   5. Shop Server                  : Port 8082
echo   6. APK Native TCP Proto Server  : Port 9191
echo   7. Cloudflare Tunnel            : https://yugihlor.online
echo   8. Gateway / Lobby / API Server : Port 8080 (Mo pack, Rank, Deck)
echo ===================================================================
echo   * Domain Online (Web) : https://yugihlor.online
echo   * Local Game (Web)    : http://localhost:8080
echo   * APK Native (Android): D:\yugitauapk (Port 9191)
echo   * Database            : yugioh_game @ 127.0.0.1:3306
echo ===================================================================
echo.

echo [1/8] Kiem tra Database MySQL (Port 3306)...
netstat -ano | findstr ":3306 " >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo     -^> MySQL chua bat! Dang tu dong khoi chay MySQL tu XAMPP...
    if exist "C:\xampp\mysql_start.bat" (
        start "MySQL Database Server" /min cmd /c "C:\xampp\mysql_start.bat"
        ping -n 4 127.0.0.1 >nul
    ) else if exist "C:\xampp\mysql\bin\mysqld.exe" (
        start "MySQL Database Server" /min "C:\xampp\mysql\bin\mysqld.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" --standalone
        ping -n 4 127.0.0.1 >nul
    )
    echo     -^> Da khoi dong xong MySQL Database!
) else (
    echo     -^> MySQL dang hoat dong san sang!
)

python -c "import pymysql; conn=pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game')" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [LOI] Khong the ket noi vao database yugioh_game! Vui long kiem tra MySQL.
    pause
    exit /b 1
)
echo     -^> Ket noi database [yugioh_game] THANH CONG!
echo.

echo [2/8] Don dep cac tien trinh cu tren cac cong game va Tunnel...
python cleanup_servers.py
echo.

echo [3/8] Tu dong dong bo ma nguon Lua va du lieu game (sync_game.py)...
python sync_game.py
echo.

echo [4/8] Dang khoi chay Battle Server Chinh tren Port 9192...
start "Yu-Gi-Oh Battle Server [Port 9192]" /d "%~dp0" cmd /k "title BATTLE SERVER [Port 9192] && color 0C && python yugioh_battle_server.py"
ping -n 2 127.0.0.1 >nul

echo [5/8] Dang khoi chay Sinh Tu Chien Server tren Port 8085...
start "Yu-Gi-Oh Survival Server [Port 8085]" /d "%~dp0" cmd /k "title SURVIVAL SERVER [Port 8085] && color 0D && python yugioh_survival_server.py"
ping -n 2 127.0.0.1 >nul

echo [6/8] Dang khoi chay Chat Server tren Port 8084 va 9193...
start "Yu-Gi-Oh Chat Server [Port 8084/9193]" /d "%~dp0" cmd /k "title CHAT SERVER [Port 8084/9193] && color 0E && python yugioh_chat_server.py"
ping -n 2 127.0.0.1 >nul

echo [7/8] Dang khoi chay Dedicated Shop Server tren Port 8082...
start "Yu-Gi-Oh Shop Server [Port 8082]" /d "%~dp0" cmd /k "title SHOP SERVER [Port 8082] && color 0B && python yugioh_shop_server.py"
ping -n 2 127.0.0.1 >nul

echo [8/8] Dang khoi chay APK Native Protobuf Server tren Port 9191...
start "Yu-Gi-Oh APK Native Server [Port 9191]" /d "%~dp0" cmd /k "title APK PROTO SERVER [Port 9191] && color 0A && python yugioh_proto_server.py"
ping -n 2 127.0.0.1 >nul

echo [*] Dang khoi chay Cloudflare Tunnel (yugihlor.online)...
start "Yu-Gi-Oh Cloudflare Tunnel [yugihlor.online]" /d "%~dp0" cmd /k "title CLOUDFLARE TUNNEL [yugihlor.online] && color 09 && cloudflared.exe --edge-ip-version 4 tunnel --config config.yml run"
ping -n 2 127.0.0.1 >nul

echo.
echo ===================================================================
echo   Dang khoi chay Gateway / Lobby / API Web Server tren Port 8080...
echo ===================================================================
echo.
python yugioh_web_server.py

echo.
echo [THONG BAO] Web server da dung. Nhan phim bat ky de thoat...
pause
