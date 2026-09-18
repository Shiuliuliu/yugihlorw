@echo off
chcp 65001 >nul
title Import Database MySQL Yu-Gi-Oh / Quyet Chien Chi Thanh
echo ====================================================================
echo  IMPORT DATABASE MYSQL: yugioh_game
echo ====================================================================
echo.

if exist "C:\xampp\mysql\bin\mysql.exe" (
    echo [OK] Tim thay MySQL tai C:\xampp\mysql\bin\mysql.exe
    echo Dang import file yugioh_game.sql vao MySQL...
    "C:\xampp\mysql\bin\mysql.exe" -u root < "%~dp0yugioh_game.sql"
    if %ERRORLEVEL% equ 0 (
        echo.
        echo ====================================================================
        echo [THANH CONG] Da khoi tao Database 'yugioh_game' hoan tat!
        echo - Bang accounts: Day du tai khoan, vang, gem, da hu vo, the tim, the loi nha
        echo - Bang card_monsters: 2.296 Quai Thu
        echo - Bang card_spells: 1.128 Phep Thuat
        echo - Bang card_traps: 576 Cam Bay
        echo - Bang card_extra: 721 Quai Thu Extra (Dung Hop, Synchro, Xyz, Link)
        echo - Bang user_decks ^& system_decks: Deck luu o dang mang JSON
        echo ====================================================================
    ) else (
        echo.
        echo [CANH BAO] Khong the ket noi MySQL localhost.
        echo Hay dam bao ban da START MySQL trong XAMPP Control Panel truoc khi chay lai!
    )
) else (
    echo Khong tim thay XAMPP MySQL mac dinh.
    echo Ban co the import thu cong bang lenh:
    echo   mysql -u root -p ^< "%~dp0yugioh_game.sql"
)

echo.
pause
