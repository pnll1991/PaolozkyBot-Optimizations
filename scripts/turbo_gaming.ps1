# PaolozkyBot Ultra Optimization Script 🚀
# Versión: 2.1 - Gaming & Power User (PROD READY)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization ---" -ForegroundColor Cyan

# 1. ENERGÍA (Ultimate Performance)
Write-Host "[1/6] Activando plan de Máximo Rendimiento..." -ForegroundColor Yellow
$ultimateGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -duplicatescheme $ultimateGuid | Out-Null
$currentPlans = powercfg -list
$targetPlan = $currentPlans | Select-String "Máximo rendimiento" | Select-Object -First 1
if ($targetPlan) {
    $guid = $targetPlan.ToString().Split()[3]
    powercfg -setactive $guid
    Write-Host "[OK] Plan 'Máximo Rendimiento' activado." -ForegroundColor Green
}

# 2. LATENCIA Y RED (Kernel Level Tweaks)
Write-Host "[2/6] Optimizando Stack de Red y Latencia..." -ForegroundColor Yellow
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $registryPath | ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -ErrorAction SilentlyContinue
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Force

# 3. PROCESOS Y RENDIMIENTO (Debloat)
Write-Host "[3/6] Deteniendo telemetría y servicios innecesarios..." -ForegroundColor Yellow
$services = @("DiagTrack", "SysMain", "WSearch")
foreach ($svc in $services) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

# 4. MODO GAMING EXTREMO
Write-Host "[4/6] Desactivando Game DVR y activando HAGS..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" -Name "value" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -ErrorAction SilentlyContinue

# 5. OPTIMIZACIÓN DE MEMORIA (Kernel en RAM)
Write-Host "[5/6] Forzando Kernel en RAM para evitar stuttering..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -Force

# 6. LIMPIEZA AUTOMÁTICA
Write-Host "[6/6] Ejecutando limpieza de archivos temporales..." -ForegroundColor Yellow
$tmpPaths = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\Prefetch\*")
foreach ($path in $tmpPaths) {
    Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "`n--- OPTIMIZACIÓN NIVEL DIOS COMPLETADA ---" -ForegroundColor Cyan
Write-Host "Nota: Algunos cambios requieren REINICIAR el PC para activarse en el Kernel." -ForegroundColor Red
