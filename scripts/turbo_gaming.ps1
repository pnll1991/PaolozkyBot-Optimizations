# PaolozkyBot Ultra Optimization Script 🚀
# Version: 10.0 - "UNIVERSAL ASCENSION" (Hardware Agnostic Edition)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v10.0) ---" -ForegroundColor Cyan

# --- LÓGICA DE DETECCIÓN DE HARDWARE ---
$CPU = Get-CimInstance Win32_Processor
$Threads = $CPU.NumberOfLogicalProcessors
Write-Host "[INFO] Detectados $Threads hilos de CPU." -ForegroundColor Gray

# Calcular Máscaras de Afinidad (Usar los últimos hilos para evitar conflictos con Core 0)
# GPU: Últimos 2 hilos
$GPUMask = [Math]::Pow(2, $Threads - 1) + [Math]::Pow(2, $Threads - 2)
# NIC: Penúltimos 2 hilos
$NICMask = [Math]::Pow(2, $Threads - 3) + [Math]::Pow(2, $Threads - 4)

# 1. INTERRUPT AFFINITY & MSI MODE (Universal)
Write-Host "[1/5] Optimizando Afinidad de Interrupciones y MSI Mode..." -ForegroundColor Yellow

# --- Buscar GPU NVIDIA ---
$GPU = Get-PnpDevice -Class Display | Where-Object { $_.Manufacturer -like "*NVIDIA*" -and $_.Status -eq "OK" }
if ($GPU) {
    foreach ($dev in $GPU) {
        $Instance = $dev.InstanceId
        Write-Host "[GPU] Aplicando afinidad a: $($dev.FriendlyName)" -ForegroundColor Green
        
        # MSI Mode Enable
        $msiPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$Instance\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties"
        if (-not (Test-Path $msiPath)) { New-Item -Path $msiPath -Force | Out-Null }
        Set-ItemProperty -Path $msiPath -Name "MSISupported" -Value 1 -Force
        
        # Affinity Policy
        $affPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$Instance\Device Parameters\Interrupt Management\Affinity Policy"
        if (-not (Test-Path $affPath)) { New-Object -TypeName PSObject | Out-Null; New-Item -Path $affPath -Force | Out-Null }
        Set-ItemProperty -Path $affPath -Name "DevicePolicy" -Value 4 -Force # IrqPolicySpecifiedProcessors
        Set-ItemProperty -Path $affPath -Name "AssignmentSet" -Value $GPUMask -Type QWord -Force
    }
}

# --- Buscar Adaptador de Red Principal ---
$NIC = Get-PnpDevice -Class Net | Where-Object { $_.Status -eq "OK" -and ($_.FriendlyName -like "*Ethernet*" -or $_.FriendlyName -like "*GbE*" -or $_.FriendlyName -like "*Wi-Fi*") }
if ($NIC) {
    $dev = $NIC | Select-Object -First 1 # Solo el principal
    $Instance = $dev.InstanceId
    Write-Host "[NET] Aplicando afinidad a: $($dev.FriendlyName)" -ForegroundColor Green
    
    $affPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$Instance\Device Parameters\Interrupt Management\Affinity Policy"
    if (-not (Test-Path $affPath)) { New-Item -Path $affPath -Force | Out-Null }
    Set-ItemProperty -Path $affPath -Name "DevicePolicy" -Value 4 -Force
    Set-ItemProperty -Path $affPath -Name "AssignmentSet" -Value $NICMask -Type QWord -Force
}

# 2. POWER THROTTLING & UNPARKING (Universal)
Write-Host "[2/5] Desactivando Power Throttling y Core Parking..." -ForegroundColor Yellow
$ptPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling"
if (-not (Test-Path $ptPath)) { New-Item -Path $ptPath -Force | Out-Null }
Set-ItemProperty -Path $ptPath -Name "PowerThrottlingOff" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" -Name "Attributes" -Value 0

# 3. KERNEL & ENERGY (Ultimate Performance)
Write-Host "[3/5] Forzando Kernel en RAM y Ultimate Performance..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -Force
$ultimateGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -duplicatescheme $ultimateGuid | Out-Null
$targetPlan = powercfg -list | Select-String "Máximo rendimiento" | Select-Object -First 1
if ($targetPlan) { $guid = $targetPlan.ToString().Split()[3]; powercfg -setactive $guid }

# 4. NETWORK STACK (Universal Tuning)
Write-Host "[4/5] Optimizando Stack de Red y DNS..." -ForegroundColor Yellow
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global ecncapability=enabled
netsh int tcp set global timestamps=disabled
Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses ("1.1.1.1", "8.8.8.8") -ErrorAction SilentlyContinue

# 5. PRIORIDAD AUTOMATICA (Arena Breakout Fix)
Write-Host "[5/5] Configurando prioridades de CPU para juegos..." -ForegroundColor Yellow
$imagePath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\UAGame.exe\PerfOptions"
if (-not (Test-Path $imagePath)) { New-Item -Path $imagePath -Force | Out-Null }
Set-ItemProperty -Path $imagePath -Name "CpuPriorityClass" -Value 3 -Force # 3 = High

Write-Host "`n--- NIVEL DIOS v10.0: UNIVERSAL ASCENSION COMPLETADA ---" -ForegroundColor Cyan
