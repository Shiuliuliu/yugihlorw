@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - CHI CHAY CLOUDFLARE TUNNEL (yugihlor.online)
color 0B
cls

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE WEB H5 - CHỈ CHẠY CLOUDFLARE TUNNEL
echo ===================================================================
echo.

echo [1/2] Don dep tien trinh Cloudflare Tunnel cu...
taskkill /IM cloudflared.exe /F >nul 2>&1

echo [2/2] Kiem tra trang thai Game Server tren Port 8080...
netstat -ano | findstr ":8080 " >nul
if %errorlevel% neq 0 (
    echo [CANH BAO] Game Server tren Port 8080 hien chua chay!
    echo           Hay nho chay Game Server (file CHI_CHAY_SERVER.bat) truoc nhe.
    echo.
) else (
    echo [OK] Game Server tren Port 8080 dang hoat dong binh thuong!
    echo.
)

echo ===================================================================
echo   Dang ket noi Cloudflare Tunnel...
echo   Domain Online : https://yugihlor.online
echo   Domain WWW    : https://www.yugihlor.online
echo ===================================================================
echo.
cloudflared.exe tunnel --config config.yml run
pause
