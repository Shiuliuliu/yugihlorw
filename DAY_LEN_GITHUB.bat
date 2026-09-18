@echo off
title Push du an len GitHub (Shiuliuliu/yugihlorw)
chcp 65001 >nul
cd /d "D:\yugitauapk"

echo ====================================================================
echo        DANG TIEN HANH DAY DU AN LEN GITHUB
echo        Repository: https://github.com/Shiuliuliu/yugihlorw.git
echo ====================================================================
echo.
echo Neu day la lan dau tien, trinh duyet se hien thi bang dang nhap GitHub.
echo Ban chi can bam "Sign in with your browser" hoac "Authorize" de xac nhan.
echo.

"C:\tools\Git\cmd\git.exe" push -u origin main

echo.
if %ERRORLEVEL% EQU 0 (
    echo [THANH CONG] Du an da duoc day len GitHub thanh cong!
) else (
    echo [CO LOI] Vui long kiem tra lai thong tin dang nhap hoac quyen ghi tren GitHub.
)
echo.
pause
