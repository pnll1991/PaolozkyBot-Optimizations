# Turbo Gaming Optimization Script
Write-Host "Iniciando optimización para Gaming..." -ForegroundColor Cyan

# 1. Establecer plan de energía de Máximo Rendimiento
# Intentar activar el plan de Máximo Rendimiento (Ultimate Performance)
try {
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    Write-Host "[OK] Esquema de máximo rendimiento activado." -ForegroundColor Green
} catch {
    Write-Host "[!] No se pudo activar Ultimate Performance, usando Alto Rendimiento." -ForegroundColor Yellow
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
}

# 2. Desactivar limitación de red para juegos (Network Throttling)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0 -ErrorAction SilentlyContinue

# 3. Optimizar Game Bar y Game Mode
Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "UseNexusForGameBarEnabled" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0 -ErrorAction SilentlyContinue

Write-Host "Optimización completada. Se recomienda reiniciar." -ForegroundColor Yellow
