@echo off
rem Double-click to install the /ecmis skill on Windows (runs install.ps1)
chcp 65001 >nul
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
echo.
pause
