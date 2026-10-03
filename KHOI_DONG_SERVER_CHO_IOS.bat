@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - SERVER CHO CLIENT IOS [PORT 9191]
color 0A
cls

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE - DEDICATED TCP SERVER CHO CLIENT IOS
echo ===================================================================
echo   1. Database MySQL (XAMPP)       : Port 3306
echo   2. iOS Native TCP Proto Server  : Port 9191
echo   3. iOS Client Package           : D:\yugitauios\YugiTauKhua_ServerReady.ipa
echo ===================================================================
echo.

echo [1/3] Kiem tra Database MySQL (Port 3306)...
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
echo.

echo [2/3] Don dep Port 9191 neu dang bi chiem dung...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9191 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)

echo.
echo [3/3] Dang khoi chay Server TCP Protobuf tren Port 9191...
echo ===================================================================
echo   IP LAN hien tai: 192.168.1.2:9191
echo   Iphone / Ipad ket noi cung mang Wi-Fi de vao game!
echo ===================================================================
echo.
python yugioh_proto_server.py
pause
