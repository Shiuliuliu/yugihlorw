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

echo [1/4] Don dep tien trinh cu tren Port 8080, 9192, 8082, 8084, 9193, 8085...
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

echo [2/4] Don dep tien trinh Cloudflare Tunnel cu...
taskkill /IM cloudflared.exe /F >nul 2>&1

echo [3/4] Dang khoi chay Survival (8085), Chat (8084/9193), Shop (8082) va Game Server (8080/9192)...
start "Yu-Gi-Oh Survival Server" cmd /k "title Yu-Gi-Oh Survival Server [Port 8085] && color 0D && python yugioh_survival_server.py"
start "Yu-Gi-Oh Chat Server" cmd /k "title Yu-Gi-Oh Chat Server [Port 8084/9193] && color 0E && python yugioh_chat_server.py"
start "Yu-Gi-Oh Shop Server" cmd /k "title Yu-Gi-Oh Shop Server [Port 8082] && color 0B && python yugioh_shop_server.py"
start "Yu-Gi-Oh Game Server" cmd /k "title Yu-Gi-Oh Game Server [Port 8080/9192] && color 0A && python yugioh_web_server.py"

echo     -> Cho server khoi dong trong 2 giay...
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
