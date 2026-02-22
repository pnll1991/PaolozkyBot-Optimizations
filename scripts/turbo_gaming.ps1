# PaolozkyBot Ultra Optimization Script 🚀
# Version: 3.5 - "GOD MODE" (VBS Fix, Priority & Memory Management)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v3.5) ---" -ForegroundColor Cyan

# 1. SEGURIDAD VS RENDIMIENTO (VBS & Memory Integrity)
# Nota: Esto mejora el rendimiento pero reduce una capa de seguridad.
Write-Host "[1/5] Deshabilitando Virtualization-Based Security (VBS) y HVCI..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -Value 0 -Force

# 2. PRIORIDAD DE PROCESOS (Win32PrioritySeparation)
# Valor 26 (hex: 1A) da prioridad máxima a las aplicaciones en primer plano (juegos)
Write-Host "[2/5] Optimizando separacion de prioridad Win32 (Gaming Focus)..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 26 -Force

# 3. MEMORIA Y CACHE (Ajustes avanzados de RAM)
Write-Host "[3/5] Ajustando limites de cache de sistema y reservacion de RAM..." -ForegroundColor Yellow
# Reducir el tiempo de espera para matar procesos que no responden (Cierre mas rapido)
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Value "2000" -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "2000" -Force

# 4. DEBLOAT DE PRIVACIDAD (Cortar telemetria profunda)
Write-Host "[4/5] Cortando rastreo de publicidad y telemetria de usuario..." -ForegroundColor Yellow
$regPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost"
)
foreach($p in $regPaths) {
    if (-not (Test-Path $p)) { New-Item -Path $p -Force | Out-Null }
    Set-ItemProperty -Path $p -Name "Enabled" -Value 0 -Force -ErrorAction SilentlyContinue
}

# 5. OPTIMIZACION DE INICIO (Menos demora al arrancar)
Write-Host "[5/5] Eliminando el retraso de inicio de aplicaciones..." -ForegroundColor Yellow
$serializePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
if (-not (Test-Path $serializePath)) { New-Item -Path $serializePath -Force | Out-Null }
Set-ItemProperty -Path $serializePath -Name "StartupDelayInMSec" -Value 0 -Force

Write-Host "`n--- NIVEL DIOS v3.5: CONFIGURACION TERMINADA ---" -ForegroundColor Cyan
Write-Host "DEBES REINICIAR PARA QUE EL KERNEL DESACTIVE VBS Y APLIQUE LA NUEVA PRIORIDAD." -ForegroundColor Red
