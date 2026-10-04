@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - CHI CHAY GAME SERVER [Port 8080 va 9192]
color 0A
cls

cd /d "%~dp0"

echo ===================================================================
echo           YU-GI-OH ONLINE WEB H5 - CHỈ CHẠY GAME SERVER
echo ===================================================================
echo.

echo [1/3] Don dep tien trinh cu tren Port 8080, 9192 va 8082...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9192 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8082 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)

echo [2/4] Dang khoi chay Dedicated Shop Server tren Port 8082...
start "Yu-Gi-Oh Dedicated Shop Server [Port 8082]" cmd /k "title SHOP SERVER [Port 8082] && color 0B && python yugioh_shop_server.py"

echo [3/4] Dang khoi chay Battle Server Chinh tren Port 9192...
start "Yu-Gi-Oh Battle Server [Port 9192]" cmd /k "title BATTLE SERVER [Port 9192] && color 0C && python yugioh_battle_server.py"

echo [4/4] Dang khoi chay Gateway / Lobby / API Server tren Port 8080...
echo.
echo ===================================================================
echo   Gateway Web Server: http://localhost:8080
echo   PvP Battle Server : ws://localhost:9192 (Dedicated)
echo   Shop Server       : http://localhost:8082
echo ===================================================================
echo.
python yugioh_web_server.py
pause
