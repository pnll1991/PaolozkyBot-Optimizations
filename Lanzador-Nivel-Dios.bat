@echo off
setlocal
:: Comprobar privilegios de administrador
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Este script requiere permisos de Administrador.
    echo Intentando elevar privilegios...
    powershell Start-Process -FilePath "%0" -Verb RunAs
    exit /b
)

cd /d "%~dp0"
echo --------------------------------------------------
echo    PaolozkyBot Ultra Optimizer - Lanzador
echo --------------------------------------------------
echo.
powershell -ExecutionPolicy Bypass -File "Optimizer-GUI.ps1"
pause
