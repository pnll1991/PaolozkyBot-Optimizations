# PaolozkyBot Ultra Optimization Script 🚀
# Version: 8.0 - "GHOST PROTOCOL" (Deep Privacy, GPU Cache & OS Reliability)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v8.0) ---" -ForegroundColor Cyan

# 1. GPU SHADER CACHE (RTX 3080 Ti Focus)
# Aumentar el tamaño del cache de shaders ayuda a evitar tirones al cargar texturas nuevas.
Write-Host "[1/6] Configurando Shader Cache de NVIDIA a Ilimitado..." -ForegroundColor Yellow
$nvPath = "HKLM:\SOFTWARE\NVIDIA Corporation\Global\NVSmart"
if (-not (Test-Path $nvPath)) { New-Item -Path $nvPath -Force | Out-Null }
Set-ItemProperty -Path $nvPath -Name "ShaderCacheSize" -Value 0xFFFFFFFF -Force

# 2. DEEP PRIVACY (Ghost Mode)
# Bloqueo de telemetria que no se quita con los ajustes normales.
Write-Host "[2/6] Deshabilitando recoleccion de datos profunda (Tailored Experiences)..." -ForegroundColor Yellow
$privacyPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
)
foreach($p in $privacyPaths) {
    if (-not (Test-Path $p)) { New-Item -Path $p -Force | Out-Null }
    Set-ItemProperty -Path $p -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0 -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $p -Name "SubscribedContent-338387Enabled" -Value 0 -Force -ErrorAction SilentlyContinue # Tips
}

# 3. WINDOWS UPDATE (Control Total)
# Evita que Windows se reinicie solo o descargue drivers viejos encima de los tuyos.
Write-Host "[3/6] Configurando Windows Update (No auto-drivers/No auto-reboot)..." -ForegroundColor Yellow
$wuPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
if (-not (Test-Path $wuPath)) { New-Item -Path $wuPath -Force | Out-Null }
Set-ItemProperty -Path $wuPath -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -Force
$auPath = "$wuPath\AU"
if (-not (Test-Path $auPath)) { New-Item -Path $auPath -Force | Out-Null }
Set-ItemProperty -Path $auPath -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -Force

# 4. BACKGROUND APPS KILL (Global)
# Detiene todas las apps de la Microsoft Store de correr en segundo plano.
Write-Host "[4/6] Bloqueando ejecucion de apps en segundo plano..." -ForegroundColor Yellow
$bgPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
if (-not (Test-Path $bgPath)) { New-Item -Path $bgPath -Force | Out-Null }
Set-ItemProperty -Path $bgPath -Name "GlobalUserDisabled" -Value 1 -Force

# 5. SEARCH INDEXER TUNE (Low Impact)
# El indexador es util pero pesado. Lo limitamos para que no use el disco al 100%.
Write-Host "[5/6] Ajustando Search Indexer para bajo impacto..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Search" -Name "BackgroundActivityModerator" -Value 1 -Force

# 6. WINSXS CLEANUP (Limpieza de componentes obsoletos)
Write-Host "[6/6] Iniciando limpieza de componentes obsoletos de Windows (WinSXS)..." -ForegroundColor Yellow
# handled via exec

Write-Host "`n--- NIVEL DIOS v8.0: GHOST PROTOCOL COMPLETADA ---" -ForegroundColor Cyan
Write-Host "SISTEMA INVISIBLE Y OPTIMIZADO AL EXTREMO." -ForegroundColor Red
