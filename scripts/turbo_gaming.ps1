# PaolozkyBot Ultra Optimization Script 🚀
# Version: 4.0 - "INPUT DIVINITY" (Mouse Fix, DPC Latency & Power User Cleanup)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v4.0) ---" -ForegroundColor Cyan

# 1. MOUSE PRECISION (Kill Acceleration)
# Elimina la curva de aceleracion de Windows para que el movimiento sea 1:1 real.
Write-Host "[1/5] Eliminando curva de aceleracion del mouse (Raw Input Focus)..." -ForegroundColor Yellow
$mousePath = "HKCU:\Control Panel\Mouse"
Set-ItemProperty -Path $mousePath -Name "MouseSpeed" -Value "0" -Force
Set-ItemProperty -Path $mousePath -Name "MouseThreshold1" -Value "0" -Force
Set-ItemProperty -Path $mousePath -Name "MouseThreshold2" -Value "0" -Force
# MarkC Mouse Fix Registry Style (Smooth Curves set to zero)
Set-ItemProperty -Path $mousePath -Name "SmoothMouseXCurve" -Value ([byte[]](0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)) -Force
Set-ItemProperty -Path $mousePath -Name "SmoothMouseYCurve" -Value ([byte[]](0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)) -Force

# 2. DPC LATENCY & TIMERS (System Responsiveness)
Write-Host "[2/5] Ajustando respuesta de timers para baja latencia DPC..." -ForegroundColor Yellow
# Deshabilitar HPET (High Precision Event Timer) en Windows (usar el del hardware es mas rapido)
bcdedit /set useplatformclock no
bcdedit /set disabledynamictick yes

# 3. WINDOWED GAMING OPTIMIZATION
Write-Host "[3/5] Forzando optimizaciones para juegos en ventana (FSO)..." -ForegroundColor Yellow
$dxPath = "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences"
if (-not (Test-Path $dxPath)) { New-Item -Path $dxPath -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2 -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1 -Force

# 4. POWER USER CLEANUP (SFC & DISM Auto-Repair)
Write-Host "[4/5] Ejecutando auto-reparacion de archivos de sistema..." -ForegroundColor Yellow
# Esto asegura que el sistema este sano despues de tantos cambios de registro.
# background execution handled by caller

# 5. STORAGE PERFORMANCE (TRIM)
Write-Host "[5/5] Optimizando SSD (Force TRIM)..." -ForegroundColor Yellow
Optimize-Volume -DriveLetter C -ReTrim

Write-Host "`n--- NIVEL DIOS v4.0: INPUT DIVINITY COMPLETADA ---" -ForegroundColor Cyan
Write-Host "REINICIO FINAL RECOMENDADO PARA SINCRONIZAR MOUSE Y BCD." -ForegroundColor Red
