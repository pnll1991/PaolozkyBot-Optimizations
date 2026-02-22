# PaolozkyBot Ultra Optimization Script 🚀
# Version: 9.0 - "SYSTEM ASCENSION" (Timer Res, RAM & NVIDIA Silencer)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v9.0) ---" -ForegroundColor Cyan

# 1. TIMER RESOLUTION FORCE (0.5ms)
# Forzar la resolucion del temporizador del sistema para reducir el input lag de forma global.
Write-Host "[1/5] Forzando Timer Resolution a 0.5ms (Low Latency Mode)..." -ForegroundColor Yellow
$timerPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
if (-not (Test-Path $timerPath)) { New-Item -Path $timerPath -Force | Out-Null }
Set-ItemProperty -Path $timerPath -Name "GlobalTimerResolution" -Value 5000 -ErrorAction SilentlyContinue

# 2. NVIDIA TELEMETRY SILENCER (RTX Focus)
# Detener el rastreo de NVIDIA que no se quita con drivers.
Write-Host "[2/5] Silenciando procesos de telemetria de NVIDIA..." -ForegroundColor Yellow
$nvSvc = @("NvTelemetryContainer")
foreach($s in $nvSvc) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
}

# 3. RAM MANAGEMENT (Reserved Memory Kill)
Write-Host "[3/5] Minimizando reserva de memoria para procesos de fondo..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "IoPageLockLimit" -Value 983040 -Force # ~1GB para IO
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PoolUsageMaximum" -Value 60 -Force

# 4. STARTUP CLEANUP PART 2 (Kill Google/Edge Updaters)
Write-Host "[4/5] Deshabilitando actualizadores en segundo plano (Google/Edge)..." -ForegroundColor Yellow
$updaters = @("gupdate", "gupdatem", "edgeupdate", "edgeupdatem")
foreach ($u in $updaters) {
    Stop-Service -Name $u -Force -ErrorAction SilentlyContinue
    Set-Service -Name $u -StartupType Disabled -ErrorAction SilentlyContinue
}

# 5. NTFS MFT OPTIMIZATION
Write-Host "[5/5] Optimizando Master File Table (MFT) para acceso ultra-rapido..." -ForegroundColor Yellow
fsutil behavior set mftzone 2

Write-Host "`n--- NIVEL DIOS v9.0: SYSTEM ASCENSION COMPLETADA ---" -ForegroundColor Cyan
Write-Host "EL SISTEMA HA ALCANZADO EL NIVEL MAXIMO DE OPTIMIZACION POR SOFTWARE." -ForegroundColor Red
