# PaolozkyBot Ultra Optimization Script 🚀
# Version: 5.0 - "SYSTEM TRANSCENDENCE" (Interrupt Affinity & Power Throttling Kill)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v5.0) ---" -ForegroundColor Cyan

# 1. INTERRUPT AFFINITY (Core Isolation for GPU & NIC)
Write-Host "[1/5] Aislado de interrupciones para GPU y Red (Core Affinity)..." -ForegroundColor Yellow
# GPU: RTX 3080 Ti -> Threads 10 y 11 (Mascara: 3072)
$gpuPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\VEN_10DE&DEV_2208&SUBSYS_220810B0&REV_A1\4&1FC990D7&0&0019\Device Parameters\Interrupt Management\Affinity Policy"
if (-not (Test-Path $gpuPath)) { New-Item -Path $gpuPath -Force | Out-Null }
Set-ItemProperty -Path $gpuPath -Name "DevicePolicy" -Value 4 -Type DWord -Force
Set-ItemProperty -Path $gpuPath -Name "AssignmentSet" -Value 3072 -Type QWord -Force

# NIC: Realtek GbE -> Threads 8 y 9 (Mascara: 768)
$nicPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\VEN_10EC&DEV_8168&SUBSYS_E0001458&REV_0C\01000000684CE00000\Device Parameters\Interrupt Management\Affinity Policy"
if (-not (Test-Path $nicPath)) { New-Item -Path $nicPath -Force | Out-Null }
Set-ItemProperty -Path $nicPath -Name "DevicePolicy" -Value 4 -Type DWord -Force
Set-ItemProperty -Path $nicPath -Name "AssignmentSet" -Value 768 -Type QWord -Force

# 2. POWER THROTTLING KILL (Global Disable)
Write-Host "[2/5] Desactivando Power Throttling global (Zero Background Latency)..." -ForegroundColor Yellow
$powerPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling"
if (-not (Test-Path $powerPath)) { New-Item -Path $powerPath -Force | Out-Null }
Set-ItemProperty -Path $powerPath -Name "PowerThrottlingOff" -Value 1 -Type DWord -Force

# 3. ADVANCED SYSTEM CACHE (Extreme Multitasking)
Write-Host "[3/5] Elevando prioridad de Cache de Sistema y Working Set..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SystemCacheLimit" -Value 1024 -ErrorAction SilentlyContinue

# 4. NETWORK STACK DEEP TUNE (CTCP & ECN)
Write-Host "[4/5] Optimizando Stack de Red (CTCP, ECN y Window Auto-Tuning)..." -ForegroundColor Yellow
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global ecncapability=enabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global initialrto=2000
netsh int tcp set global rsc=enabled
netsh int tcp set global nonsackrttresiliency=disabled

# 5. DNS OPTIMIZATION (Adapter Level)
Write-Host "[5/5] Forzando DNS de Cloudflare/Google para baja latencia..." -ForegroundColor Yellow
Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses ("1.1.1.1", "8.8.8.8") -ErrorAction SilentlyContinue

Write-Host "`n--- NIVEL DIOS v5.0: SYSTEM TRANSCENDENCE COMPLETADA ---" -ForegroundColor Cyan
Write-Host "LOS CAMBIOS DE INTERRUPT AFFINITY REQUIEREN REINICIO PARA SURTIR EFECTO." -ForegroundColor Red
