@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - KHỞI ĐỘNG 4 MÁY CHỦ + CLOUDFLARE TUNNEL
color 0A
cls

cd /d "%~dp0"

echo ==============================================================================
echo       YU-GI-OH ONLINE WEB H5 - KHỞI ĐỘNG 4 SERVER + 1 TUNNEL
echo ==============================================================================
echo   1. Game & Battle Server    : Port 8080 ^& WS 9192
echo   2. Shop & Gacha Server     : Port 8082
echo   3. Chat Server             : Port 8084 ^& WS 9193
echo   4. Survival Server         : Port 8085
echo   5. Cloudflare Tunnel       : https://yugihlor.online (config.yml)
echo ==============================================================================
echo.

echo [1/3] Đang dọn dẹp các tiến trình cũ trên các cổng và Cloudflare...
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

echo     -> Đã dọn dẹp xong các cổng và tiến trình cũ!
echo.

echo [2/3] Đang khởi động 4 Server độc lập...
echo   - Khởi động Survival Server (Port 8085)...
start "Yu-Gi-Oh Survival Server [Port 8085]" cmd /k "title SURVIVAL SERVER [Port 8085] && color 0D && python yugioh_survival_server.py"

echo   - Khởi động Chat Server (Port 8084 / WS 9193)...
start "Yu-Gi-Oh Chat Server [Port 8084/9193]" cmd /k "title CHAT SERVER [Port 8084/9193] && color 0E && python yugioh_chat_server.py"

echo   - Khởi động Dedicated Shop Server (Port 8082)...
start "Yu-Gi-Oh Shop Server [Port 8082]" cmd /k "title SHOP SERVER [Port 8082] && color 0B && python yugioh_shop_server.py"

echo   - Khởi động Game & Battle Server (Port 8080 / WS 9192)...
start "Yu-Gi-Oh Game & Battle Server [Port 8080/9192]" cmd /k "title GAME SERVER [Port 8080/9192] && color 0A && python yugioh_web_server.py"

echo.
echo     -> Đợi 3 giây để các máy chủ sẵn sàng trước khi kết nối Tunnel...
timeout /t 3 /nobreak >nul

echo [3/3] Đang khởi động Cloudflare Tunnel cho domain yugihlor.online...
start "Yu-Gi-Oh Cloudflare Tunnel [yugihlor.online]" cmd /k "title CLOUDFLARE TUNNEL [yugihlor.online] && color 09 && cloudflared.exe tunnel --config config.yml run"

echo.
echo ==============================================================================
echo   ĐÃ KHỞI CHẠY THÀNH CÔNG 4 SERVER VÀ 1 CLOUDFLARE TUNNEL!
echo ==============================================================================
echo   [Online Domain] : https://yugihlor.online
echo   [Online WWW]    : https://www.yugihlor.online
echo   [Local Game]    : http://localhost:8080
echo   [Local Shop]    : http://localhost:8082
echo   [Local Chat]    : http://localhost:8084
echo   [Local Sinh Tử] : http://localhost:8085
echo ==============================================================================
echo.
echo Nhấn phím bất kỳ để đóng cửa sổ quản lý này (4 Server và Tunnel vẫn tiếp tục chạy độc lập)...
pause >nul
