# PaolozkyBot Ultra Optimization Script 🚀
# Version: 3.0 - "BEYOND LIMITS" (Kernel, Latency & BCD Edition)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v3.0) ---" -ForegroundColor Cyan

# 1. ENERGIA (Ultimate Performance & CPU Unparking)
Write-Host "[1/7] Configurando Energia y CPU al Limite..." -ForegroundColor Yellow
$ultimateGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -duplicatescheme $ultimateGuid | Out-Null
$targetPlan = powercfg -list | Select-String "Máximo rendimiento" | Select-Object -First 1
if ($targetPlan) {
    $guid = $targetPlan.ToString().Split()[3]
    powercfg -setactive $guid
}
# Deshabilitar CPU Core Parking (via Registry)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" -Name "Attributes" -Value 0

# 2. BCD EDIT (System Timer & Latency)
Write-Host "[2/7] Ajustando BCD para baja latencia..." -ForegroundColor Yellow
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
bcdedit /set tscsyncpolicy Enhanced

# 3. GPU EXTREME (RTX 3080 Ti & MSI Mode)
Write-Host "[3/7] Optimizando RTX 3080 Ti al limite..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -Force
$mpoPath = "HKLM:\SOFTWARE\Microsoft\Windows\Dwm"
if (-not (Test-Path $mpoPath)) { New-Item -Path $mpoPath -Force | Out-Null }
Set-ItemProperty -Path $mpoPath -Name "OverlayTestMode" -Value 5 -Force
# Habilitar MSI Mode para GPU (via Registry)
$gpuDevicePath = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\" -Recurse | Where-Object { $_.Name -like "*VEN_10DE&DEV_*" }
foreach ($gpu in $gpuDevicePath) {
    $msiPath = "$($gpu.PSPath)\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties"
    if (-not (Test-Path $msiPath)) { New-Item -Path $msiPath -Force | Out-Null }
    Set-ItemProperty -Path $msiPath -Name "MSISupported" -Value 1 -Force
}

# 4. LATENCIA DE RED & KERNEL
Write-Host "[4/7] Kernel Level Network Tweaks..." -ForegroundColor Yellow
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $registryPath | ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -ErrorAction SilentlyContinue
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Force

# 5. KERNEL MEMORY & STUTTER FIX
Write-Host "[5/7] Eliminando micro-stuttering..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1 -Force

# 6. DEBLOAT & SERVICES (Xbox, Telemetria, etc)
Write-Host "[6/7] Removiendo basura del sistema..." -ForegroundColor Yellow
$services = @("DiagTrack", "SysMain", "WSearch", "XblAuthManager", "XblGameSave", "XboxNetApiSvc")
foreach ($svc in $services) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

# 7. LIMPIEZA FINAL
Write-Host "[7/7] Limpieza total..." -ForegroundColor Yellow
$tmpPaths = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\Prefetch\*")
foreach ($path in $tmpPaths) { Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue }

Write-Host "`n--- NIVEL DIOS v3.0: BEYOND LIMITS COMPLETADA ---" -ForegroundColor Cyan
Write-Host "REINICIO OBLIGATORIO PARA APLICAR CAMBIOS EN EL BCD Y MSI MODE." -ForegroundColor Red
