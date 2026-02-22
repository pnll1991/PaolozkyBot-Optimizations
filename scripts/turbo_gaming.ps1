# PaolozkyBot Ultra Optimization Script 🚀
# Versión: 2.0 - Gaming & Power User
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization ---" -ForegroundColor Cyan

# 1. LATENCIA Y RED (Kernel Level Tweaks)
Write-Host "[1/5] Optimizando Stack de Red y Latencia..." -ForegroundColor Yellow
# Deshabilitar Nagle's Algorithm (TCP No Delay)
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $registryPath | ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -ErrorAction SilentlyContinue
}
# Deshabilitar Throttling de Red
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Force

# 2. PROCESOS Y RENDIMIENTO (Debloat)
Write-Host "[2/5] Deshabilitando telemetría y servicios pesados..." -ForegroundColor Yellow
Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue # Telemetría
Set-Service -Name "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue   # Superfetch (opcional para SSD)
Set-Service -Name "WSearch" -StartupType Manual -ErrorAction SilentlyContinue     # Indexación (mejor manual)

# 3. MODO GAMING EXTREMO
Write-Host "[3/5] Configurando modo Gaming y prioridad de GPU..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" -Name "value" -Value 0 -Force
# Prioridad de GPU para juegos (HAGS - Si es compatible)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -ErrorAction SilentlyContinue

# 4. OPTIMIZACIÓN DE MEMORIA
Write-Host "[4/5] Ajustando gestión de memoria del kernel..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "DisablePagingExecutive" -Value 1 -Force # Mantiene kernel en RAM

# 5. ENERGÍA (Ultimate Performance Forzado)
Write-Host "[5/5] Forzando esquema de energía de Máximo Rendimiento..." -ForegroundColor Yellow
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
$p = powercfg -list | Select-String "Máximo rendimiento"
if ($p) {
    $guid = $p.ToString().Split()[3]
    powercfg -setactive $guid
}

Write-Host "`n--- TODO LISTO. Reinicia para aplicar los cambios en el Kernel. ---" -ForegroundColor Green
