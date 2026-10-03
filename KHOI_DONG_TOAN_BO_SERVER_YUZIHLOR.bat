@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - HE THONG SERVER YUZIHLOR [All Ports: 9191, 9192, 9193, 8080, 8082, 8084, 8085]
color 0A
cls

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE - HỆ THỐNG FULL SERVER TẬP TRUNG (YUZIHLOR)
echo ===================================================================
echo   1. Database MySQL          : yugioh_game @ 127.0.0.1:3306
echo   2. Native TCP Socket Server: Port 9191 (Cho Client Android APK)
echo   3. Web ^& Battle Server      : Port 8080 ^& 9192
echo   4. Dedicated Shop Server   : Port 8082
echo   5. Chat Socket Server      : Port 8084 ^& 9193
echo   6. Sinh Tử Chiến Server    : Port 8085
echo ===================================================================
echo.

echo [1/4] Kiem tra Database MySQL (Port 3306) & Database yugioh_game...
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
)
python -c "import pymysql; conn=pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game'); print('     -> MySQL Database [yugioh_game] KET NOI THANH CONG!')"
if %ERRORLEVEL% neq 0 (
    echo [LOI] Khong the ket noi database yugioh_game!
    pause
    exit /b
)
echo.

echo [2/4] Don dep cac Port cu (9191, 9192, 9193, 8080, 8082, 8084, 8085)...
for %%p in (9191 9192 9193 8080 8082 8084 8085) do (
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%%p "') do (
        if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
    )
)
echo     -^> Don dep cac Port hoan tat!
echo.

echo [3/4] Dang khoi chay cac Service phu tro...
start "Yugioh Chat Server [Port 8084/9193]" cmd /k "title CHAT SERVER [9193] && color 0E && python yugioh_chat_server.py"
start "Yugioh Shop Server [Port 8082]" cmd /k "title SHOP SERVER [8082] && color 0B && python yugioh_shop_server.py"
start "Yugioh Survival Server [Port 8085]" cmd /k "title SURVIVAL SERVER [8085] && color 0D && python yugioh_survival_server.py"
start "Yugioh Native TCP Server [Port 9191]" cmd /k "title NATIVE TCP SERVER [9191] && color 0A && python yugioh_proto_server.py"

echo.
echo [4/4] Dang khoi chay Main Web & Battle Server [Port 8080 / 9192]...
echo ===================================================================
echo   HE THONG SERVER DA SAN SANG!
echo   - Web H5 Client (Chay tren PC): http://localhost:8080
echo   - Native TCP Server (Cho iOS/Android): Port 9191
echo   - Database: yuzihlor
echo ===================================================================
echo.
python yugioh_web_server.py
pause
