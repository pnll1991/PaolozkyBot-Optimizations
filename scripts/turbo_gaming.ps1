# PaolozkyBot Ultra Optimization Script 🚀
# Version: 3.1 - "OMNIPOTENCE" (File System & Advanced Network Offloading)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v3.1) ---" -ForegroundColor Cyan

# 1. ENERGIA Y CPU (Unparking & Ultimate)
Write-Host "[1/8] Maximizando entrega de potencia..." -ForegroundColor Yellow
$ultimateGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -duplicatescheme $ultimateGuid | Out-Null
$targetPlan = powercfg -list | Select-String "Máximo rendimiento" | Select-Object -First 1
if ($targetPlan) { $guid = $targetPlan.ToString().Split()[3]; powercfg -setactive $guid }
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" -Name "Attributes" -Value 0

# 2. BCD EDIT (System Timer)
Write-Host "[2/8] Ajustando BCD para baja latencia..." -ForegroundColor Yellow
bcdedit /set disabledynamictick yes; bcdedit /set useplatformtick yes; bcdedit /set tscsyncpolicy Enhanced

# 3. GPU EXTREME (RTX 3080 Ti)
Write-Host "[3/8] Optimizando RTX 3080 Ti..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -Force
$mpoPath = "HKLM:\SOFTWARE\Microsoft\Windows\Dwm"
if (-not (Test-Path $mpoPath)) { New-Item -Path $mpoPath -Force | Out-Null }
Set-ItemProperty -Path $mpoPath -Name "OverlayTestMode" -Value 5 -Force

# 4. SISTEMA DE ARCHIVOS (NTFS Speed Up)
Write-Host "[4/8] Optimizando NTFS y acceso a disco..." -ForegroundColor Yellow
# Deshabilitar creación de nombres cortos 8.3 (mejora rendimiento de directorios)
fsutil behavior set disable8dot3 1
# Deshabilitar actualización de último acceso (evita escrituras constantes innecesarias)
fsutil behavior set disablelastaccess 1
# Aumentar tamaño de memoria de caché NTFS
fsutil behavior set memoryusage 2

# 5. RED AVANZADA (Hardware Offloading)
Write-Host "[5/8] Configurando Offloading de Red..." -ForegroundColor Yellow
# Forzar a la placa de red a procesar Checksums (libera CPU)
Get-NetAdapter | Set-NetAdapterAdvancedProperty -DisplayName "IPv4 Checksum Offload" -DisplayValue "Rx & Tx Enabled" -ErrorAction SilentlyContinue
Get-NetAdapter | Set-NetAdapterAdvancedProperty -DisplayName "TCP Checksum Offload (IPv4)" -DisplayValue "Rx & Tx Enabled" -ErrorAction SilentlyContinue
# Deshabilitar interrupciones moderadas (Reduce latencia, aumenta ligeramente uso de CPU)
Get-NetAdapter | Set-NetAdapterAdvancedProperty -DisplayName "Interrupt Moderation" -DisplayValue "Disabled" -ErrorAction SilentlyContinue

# 6. KERNEL MEMORY
Write-Host "[6/8] Eliminando micro-stuttering..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -Force

# 7. DEBLOAT & SERVICES
Write-Host "[7/8] Removiendo procesos basura..." -ForegroundColor Yellow
$services = @("DiagTrack", "SysMain", "WSearch", "XblAuthManager", "XblGameSave", "XboxNetApiSvc")
foreach ($svc in $services) { Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue; Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue }

# 8. LIMPIEZA FINAL
Write-Host "[8/8] Limpieza total..." -ForegroundColor Yellow
$tmpPaths = @("$env:TEMP\*", "C:\Windows\Temp\*", "C:\Windows\Prefetch\*")
foreach ($path in $tmpPaths) { Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue }

Write-Host "`n--- NIVEL DIOS v3.1: OMNIPOTENCE COMPLETADA ---" -ForegroundColor Cyan
Write-Host "EL SISTEMA ESTA EN SU PUNTO MAXIMO. REINICIA AHORA." -ForegroundColor Red
