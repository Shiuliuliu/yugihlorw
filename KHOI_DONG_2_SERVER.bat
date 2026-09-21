@echo off
cd /d "%~dp0"
call KHOI_DONG_3_SERVER.bat
exit /b

cd /d "%~dp0"

echo ===================================================================
echo     YU-GI-OH ONLINE WEB H5 - HỆ THỐNG 2 MÁY CHỦ RIÊNG BIỆT
echo ===================================================================
echo   1. Máy Chủ Game & Chiến Đấu (Battle / WebSocket) : Port 8080 ^& 9192
echo   2. Máy Chủ Cửa Hàng / Mua Gói Bài (Shop / Gacha) : Port 8082
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

echo [2/3] Dang khoi chay Dedicated Shop Server tren Port 8082...
start "Yu-Gi-Oh Dedicated Shop Server [Port 8082]" cmd /k "title SHOP SERVER [Port 8082] && color 0B && python yugioh_shop_server.py"

echo [3/3] Dang khoi chay Game & Battle Server tren Port 8080/9192...
python yugioh_web_server.py
pause
