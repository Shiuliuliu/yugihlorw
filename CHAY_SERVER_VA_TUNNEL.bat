@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - SERVER + TUNNEL (yugihlor.online)
color 0A
cls

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE WEB H5 - KHOI DONG CA SERVER VA TUNNEL
echo ===================================================================
echo.

echo [1/4] Don dep tien trinh cu tren Port 8080 va 9192...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9192 "') do (
    if not "%%a"=="0" taskkill /PID %%a /F >nul 2>&1
)

echo [2/4] Don dep tien trinh Cloudflare Tunnel cu...
taskkill /IM cloudflared.exe /F >nul 2>&1

echo [3/4] Dang khoi chay Game Server tren Port 8080 va 9192...
start "Yu-Gi-Oh Game Server" cmd /k "title Yu-Gi-Oh Game Server && python yugioh_web_server.py"

echo     -^> Cho server khoi dong trong 2 giay...
ping 127.0.0.1 -n 3 >nul

echo [4/4] Dang khoi chay Cloudflare Tunnel cho yugihlor.online...
start "Yu-Gi-Oh Cloudflare Tunnel" cmd /k "title Yu-Gi-Oh Cloudflare Tunnel && cloudflared.exe tunnel --config config.yml run"

echo.
echo ===================================================================
echo   KHOI DONG THANH CONG CA SERVER VA TUNNEL!
echo ===================================================================
echo   Domain Online : https://yugihlor.online
echo   Domain WWW    : https://www.yugihlor.online
echo   Local Web     : http://localhost:8080
echo   WebSocket     : ws://localhost:9192
echo ===================================================================
echo.
echo Nhan phim bat ky de dong cua so nay (Server va Tunnel van tiep tuc chay)...
pause >nul
