# PaolozkyBot Ultra Optimization Script 🚀
# Versión: 2.2 - Gaming, Power User & Debloat (FINAL BEFORE REBOOT)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v2.2) ---" -ForegroundColor Cyan

# 1. ENERGÍA (Ultimate Performance)
Write-Host "[1/8] Activando plan de Máximo Rendimiento..." -ForegroundColor Yellow
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
Write-Host "[2/8] Optimizando Stack de Red y Latencia..." -ForegroundColor Yellow
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $registryPath | ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -ErrorAction SilentlyContinue
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Force

# 3. PROCESOS Y RENDIMIENTO (Debloat Services)
Write-Host "[3/8] Deteniendo telemetría y servicios innecesarios..." -ForegroundColor Yellow
$services = @("DiagTrack", "SysMain", "WSearch", "TabletInputService", "MapsBroker", "XblAuthManager", "XblGameSave", "XboxNetApiSvc")
foreach ($svc in $services) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

# 4. MODO GAMING EXTREMO (DVR & HAGS)
Write-Host "[4/8] Desactivando Game DVR y activando HAGS..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" -Name "value" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -ErrorAction SilentlyContinue

# 5. OPTIMIZACIÓN DE MEMORIA (Kernel en RAM)
Write-Host "[5/8] Forzando Kernel en RAM para evitar stuttering..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -Force

# 6. VISUALES Y UI (Performance over Appearance)
Write-Host "[6/8] Optimizando efectos visuales para rendimiento..." -ForegroundColor Yellow
# Desactivar transparencia y animaciones de ventana (solo registro para velocidad)
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0 -Force

# 7. DEBLOAT APPS (Remover basura pre-instalada)
Write-Host "[7/8] Removiendo aplicaciones pre-instaladas innecesarias..." -ForegroundColor Yellow
$appsToRemove = @("*Microsoft.GetHelp*", "*Microsoft.Getstarted*", "*Microsoft.Messaging*", "*Microsoft.Office.OneNote*", "*Microsoft.OneConnect*", "*Microsoft.People*", "*Microsoft.SkypeApp*", "*Microsoft.ZuneVideo*", "*Microsoft.ZuneMusic*", "*Microsoft.WindowsFeedbackHub*")
foreach ($app in $appsToRemove) {
    Get-AppxPackage $app | Remove-AppxPackage -ErrorAction SilentlyContinue
}

# 8. LIMPIEZA AUTOMÁTICA
Write-Host "[8/8] Ejecutando limpieza de archivos temporales..." -ForegroundColor Yellow
$tmpPaths = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\Prefetch\*")
foreach ($path in $tmpPaths) {
    Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "`n--- OPTIMIZACIÓN NIVEL DIOS v2.2 COMPLETADA ---" -ForegroundColor Cyan
Write-Host "Nota: Los cambios en el registro y servicios requieren REINICIAR el PC." -ForegroundColor Red
