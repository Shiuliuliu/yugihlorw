@echo off
chcp 65001 >nul
echo ========================================================
echo   TU DONG CAI DAT QUYET CHIEN CHI THANH + VIET HOA QUA ADB
echo ========================================================
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0cai_dat_tu_dong.ps1"

pause