# PaolozkyBot Ultra Optimization Script 🚀
# Version: 7.0 - "ABSOLUTE ZERO" (OS Purity, Hibernation & Network Debloat)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v7.0) ---" -ForegroundColor Cyan

# 1. HIBERNATION KILL (Space & SSD Health)
# Elimina el archivo hiberfil.sys (ahorra GBs) y reduce escrituras en disco.
Write-Host "[1/6] Deshabilitando Hibernacion y Fast Startup (Ahorro Masivo)..." -ForegroundColor Yellow
powercfg -h off

# 2. AUTO-MAINTENANCE KILL
# Evita que Windows ejecute tareas de fondo pesadas aleatoriamente.
Write-Host "[2/6] Deteniendo tareas de mantenimiento automatico..." -ForegroundColor Yellow
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f

# 3. SERVICE PURGE - PART 2 (The Heavy Ones)
Write-Host "[3/6] Deshabilitando servicios legacy y de rastreo profundo..." -ForegroundColor Yellow
$extraServices = @("Spooler", "RemoteRegistry", "Fax", "CscService", "vmicguestinterface", "vmicvmsession")
foreach ($svc in $extraServices) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

# 4. NETWORK DEBLOAT (HOSTS File)
# Bloquear telemetria de Microsoft a nivel de red local.
Write-Host "[4/6] Bloqueando dominios de telemetria en el archivo HOSTS..." -ForegroundColor Yellow
$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
$telemetryDomains = @(
    "0.0.0.0 telemetry.microsoft.com",
    "0.0.0.0 statsfe2.update.microsoft.com",
    "0.0.0.0 diagnostics.microsoft.com",
    "0.0.0.0 oca.telemetry.microsoft.com"
)
foreach ($domain in $telemetryDomains) {
    if (!(Get-Content $hostsPath | Select-String -Pattern [regex]::Escape($domain))) {
        Add-Content -Path $hostsPath -Value "`n$domain" -ErrorAction SilentlyContinue
    }
}

# 5. DEV & HACKER TWEAKS (Long Paths & Dev Mode)
Write-Host "[5/6] Activando modo desarrollador y Long Paths (FS Fix)..." -ForegroundColor Yellow
# Enable Long Paths
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Force
# Enable Dev Mode
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Value 1 -Force

# 6. UAC MINIMALISM (Optional but Hacker style)
Write-Host "[6/6] Ajustando UAC a nivel silencioso (Notificaciones minimas)..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0 -Force

Write-Host "`n--- NIVEL DIOS v7.0: ABSOLUTE ZERO COMPLETADA ---" -ForegroundColor Cyan
Write-Host "REINICIO RECOMENDADO PARA LIBERAR EL ESPACIO DE HIBERNACION." -ForegroundColor Red
