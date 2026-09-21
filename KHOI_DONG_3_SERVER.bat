@echo off
chcp 65001 >nul
title YU-GI-OH ONLINE - HE THONG 3 SERVER DOC LAP [Game: 8080/9192 - Shop: 8082 - Chat: 8084/9193]
color 0A
cls

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE WEB H5 - HỆ THỐNG 3 MÁY CHỦ RIÊNG BIỆT
echo ===================================================================
echo   1. Máy Chủ Game ^& Chiến Đấu (Battle / WebSocket) : Port 8080 ^& 9192
echo   2. Máy Chủ Cửa Hàng / Gói Bài (Shop / Gacha)    : Port 8082
echo   3. Máy Chủ Chat Trò Chuyện (Chat / WebSocket)   : Port 8084 ^& 9193
echo   4. Máy Chủ Sinh Tử Chiến (Survival Server)      : Port 8085
echo ===================================================================
echo   * Chế độ nội bộ: Tạm không bật Tunnel Cloudflare.
echo ===================================================================
echo.

echo [1/5] Dọn dẹp tiến trình cũ trên Port 8080, 9192, 8082, 8084, 9193, 8085...
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

echo [2/5] Đang khởi chạy Sinh Tử Chiến Server trên Port 8085...
start "Yu-Gi-Oh Survival Server [Port 8085]" cmd /k "title SURVIVAL SERVER [Port 8085] && color 0D && python yugioh_survival_server.py"

echo [3/5] Đang khởi chạy Chat Server trên Port 8084 ^& 9193...
start "Yu-Gi-Oh Chat Server [Port 8084/9193]" cmd /k "title CHAT SERVER [Port 8084/9193] && color 0E && python yugioh_chat_server.py"

echo [4/5] Đang khởi chạy Dedicated Shop Server trên Port 8082...
start "Yu-Gi-Oh Dedicated Shop Server [Port 8082]" cmd /k "title SHOP SERVER [Port 8082] && color 0B && python yugioh_shop_server.py"

echo [5/5] Đang khởi chạy Game ^& Battle Server trên Port 8080/9192...
python yugioh_web_server.py
pause
