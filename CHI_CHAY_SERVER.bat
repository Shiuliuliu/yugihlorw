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

echo [1/2] Don dep tien trinh cu tren Port 8080 va 9192...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9192 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)

echo [2/2] Dang khoi chay Game Server...
echo.
echo ===================================================================
echo   Local Web : http://localhost:8080
echo   WebSocket : ws://localhost:9192
echo ===================================================================
echo.
python yugioh_web_server.py
pause
