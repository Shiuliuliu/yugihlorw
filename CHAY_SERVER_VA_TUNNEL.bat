@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - 4 SERVERS + 1 TUNNEL [yugihlor.online]
color 0A
cls

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE WEB H5 - KHOI DONG 4 SERVERS + 1 TUNNEL
echo ===================================================================
echo   1. Sinh Tu Chien Server     : Port 8085
echo   2. Chat Server              : Port 8084 ^& WS 9193
echo   3. Shop Server              : Port 8082
echo   4. Cloudflare Tunnel        : https://yugihlor.online
echo   5. Game ^& Battle Web Server : Port 8080 ^& WS 9192
echo ===================================================================
echo   * Domain Online : https://yugihlor.online
echo   * Domain WWW    : https://www.yugihlor.online
echo   * Local Game    : http://localhost:8080
echo ===================================================================
echo.

echo [1/5] Don dep tien trinh cu tren Port 8080, 9192, 8082, 8084, 9193, 8085 va Tunnel...
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
taskkill /IM cloudflared.exe /F >nul 2>&1

echo [2/5] Dang khoi chay Sinh Tu Chien Server tren Port 8085...
start "Yu-Gi-Oh Survival Server [Port 8085]" cmd /k "title SURVIVAL SERVER [Port 8085] && color 0D && python yugioh_survival_server.py"

echo [3/5] Dang khoi chay Chat Server tren Port 8084 ^& 9193...
start "Yu-Gi-Oh Chat Server [Port 8084/9193]" cmd /k "title CHAT SERVER [Port 8084/9193] && color 0E && python yugioh_chat_server.py"

echo [4/5] Dang khoi chay Dedicated Shop Server tren Port 8082...
start "Yu-Gi-Oh Shop Server [Port 8082]" cmd /k "title SHOP SERVER [Port 8082] && color 0B && python yugioh_shop_server.py"

echo [5/5] Dang khoi chay Cloudflare Tunnel (yugihlor.online)...
start "Yu-Gi-Oh Cloudflare Tunnel [yugihlor.online]" cmd /k "title CLOUDFLARE TUNNEL [yugihlor.online] && color 09 && cloudflared.exe tunnel --config config.yml run"

echo.
echo ===================================================================
echo   Dang khoi chay Game ^& Battle Server tren Port 8080/9192...
echo ===================================================================
echo.
python yugioh_web_server.py
pause
