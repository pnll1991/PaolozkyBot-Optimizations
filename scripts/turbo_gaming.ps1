# PaolozkyBot Ultra Optimization Script 🚀
# Versión: 2.3 - GPU Extreme & System Debloat (RTX 3080 Ti Edition)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v2.3) ---" -ForegroundColor Cyan

# 1. ENERGÍA (Ultimate Performance)
Write-Host "[1/9] Activando plan de Máximo Rendimiento..." -ForegroundColor Yellow
$ultimateGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -duplicatescheme $ultimateGuid | Out-Null
$currentPlans = powercfg -list
$targetPlan = $currentPlans | Select-String "Máximo rendimiento" | Select-Object -First 1
if ($targetPlan) {
    $guid = $targetPlan.ToString().Split()[3]
    powercfg -setactive $guid
    Write-Host "[OK] Plan 'Máximo Rendimiento' activado." -ForegroundColor Green
}

# 2. GPU EXTREME (RTX 3080 Ti Optimizations)
Write-Host "[2/9] Optimizando RTX 3080 Ti y Stack de Video..." -ForegroundColor Yellow
# Activar HAGS (Hardware Accelerated GPU Scheduling)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -Force
# Deshabilitar MPO (Multi-Plane Overlay) - Corrige stuttering y flickering en NVIDIA
$mpoPath = "HKLM:\SOFTWARE\Microsoft\Windows\Dwm"
if (-not (Test-Path $mpoPath)) { New-Item -Path $mpoPath -Force | Out-Null }
Set-ItemProperty -Path $mpoPath -Name "OverlayTestMode" -Value 00000005 -Force
# Prioridad de GPU para DWM (Desktop Window Manager)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Value 8 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Value 6 -Force

# 3. LATENCIA Y RED (Kernel Level Tweaks)
Write-Host "[3/9] Optimizando Stack de Red y Latencia..." -ForegroundColor Yellow
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $registryPath | ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -ErrorAction SilentlyContinue
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Force

# 4. PROCESOS Y RENDIMIENTO (Debloat Services)
Write-Host "[4/9] Deteniendo telemetría y servicios innecesarios..." -ForegroundColor Yellow
$services = @("DiagTrack", "SysMain", "WSearch", "TabletInputService", "MapsBroker", "XblAuthManager", "XblGameSave", "XboxNetApiSvc")
foreach ($svc in $services) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

# 5. MODO GAMING EXTREMO (DVR)
Write-Host "[5/9] Desactivando Game DVR..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" -Name "value" -Value 0 -Force

# 6. OPTIMIZACIÓN DE MEMORIA (Kernel en RAM)
Write-Host "[6/9] Forzando Kernel en RAM para evitar stuttering..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -Force

# 7. VISUALES Y UI
Write-Host "[7/9] Optimizando efectos visuales..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0 -Force

# 8. DEBLOAT APPS
Write-Host "[8/9] Removiendo aplicaciones basura..." -ForegroundColor Yellow
$appsToRemove = @("*Microsoft.GetHelp*", "*Microsoft.Getstarted*", "*Microsoft.Messaging*", "*Microsoft.Office.OneNote*", "*Microsoft.OneConnect*", "*Microsoft.People*", "*Microsoft.SkypeApp*", "*Microsoft.ZuneVideo*", "*Microsoft.ZuneMusic*", "*Microsoft.WindowsFeedbackHub*")
foreach ($app in $appsToRemove) {
    Get-AppxPackage $app | Remove-AppxPackage -ErrorAction SilentlyContinue
}

# 9. LIMPIEZA AUTOMÁTICA
Write-Host "[9/9] Limpieza final de temporales..." -ForegroundColor Yellow
$tmpPaths = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\Prefetch\*")
foreach ($path in $tmpPaths) {
    Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "--- OPTIMIZACIÓN NIVEL DIOS v2.3 (GPU Edition) COMPLETADA ---" -ForegroundColor Cyan
Write-Host "REINICIAR EL PC AHORA PARA ACTIVAR EL MODO RTX EXTREME." -ForegroundColor Red
