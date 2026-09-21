@echo off
title Yugihlor - Server + Tunnel (yugihlor.online)
color 0A
cls

echo ==================================================
echo   YUGIHLOR - trading "Nap" game
echo   Domain   : https://yugihlor.online
echo   Server   : http://localhost:8080
echo ==================================================
echo.

:: Check if server port is already in use and kill it
echo [1/3] Checking ports 8080 and 8082...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 " ^| findstr "LISTENING"') do (
    echo     Killing old process on port 8080 (PID: %%a)
    taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8082 " ^| findstr "LISTENING"') do (
    echo     Killing old process on port 8082 (PID: %%a)
    taskkill /PID %%a /F >nul 2>&1
)

:: Check if tunnel is already running
echo [2/3] Checking for old cloudflared processes...
taskkill /IM cloudflared.exe /F >nul 2>&1

echo.
echo [3/3] Starting services...
echo.

:: Start shop server in new window
echo     Starting Dedicated Shop Server on port 8082...
start "Yugihlor Shop Server" cmd /k "cd /d D:\yugitauapk && color 0B && python yugioh_shop_server.py"

:: Start web server in new window
echo     Starting Web Server on port 8080...
start "Yugihlor Web Server" cmd /k "cd /d D:\yugitauapk && color 0A && python yugioh_web_server.py"

:: Wait a moment for server to init
timeout /t 2 /nobreak >nul

:: Start cloudflare tunnel in new window for yugihlor.online
echo     Starting Cloudflare Tunnel (yugihlor.online)...
start "Yugihlor Tunnel (yugihlor.online)" cmd /k "cd /d D:\yugitauapk && cloudflared.exe tunnel --config config.yml run"

echo.
echo ==================================================
echo   Web URL  : https://yugihlor.online
echo   Web URL  : https://www.yugihlor.online
echo   Local    : http://localhost:8080
echo ==================================================
echo.
echo [OK] Ca hai dich vu da duoc khoi dong!
echo.
echo Nhan phim bat ky de dong cua so nay...
pause >nul
