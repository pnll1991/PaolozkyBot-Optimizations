# PaolozkyBot Ultra Optimization Script 🚀
# Version: 6.0 - "MINIMALIST HACKER" (Interface, Debloat & Context Menu)
Write-Host "--- Iniciando PaolozkyBot Ultra Optimization (v6.0) ---" -ForegroundColor Cyan

# 1. MENU CONTEXTUAL CLASICO (Hacker Style)
# Elimina el menu de Windows 11 "Mostrar mas opciones" y restaura el clasico de Windows 10
Write-Host "[1/5] Restaurando menu contextual clasico (Sin 'Mostrar mas opciones')..." -ForegroundColor Yellow
$contextPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
if (-not (Test-Path $contextPath)) { New-Item -Path $contextPath -Force | Out-Null }
Set-ItemProperty -Path $contextPath -Name "(Default)" -Value "" -Force

# 2. TASKBAR MINIMALISTA
Write-Host "[2/5] Limpiando barra de tareas (Minimalist Focus)..." -ForegroundColor Yellow
$taskbarPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $taskbarPath -Name "TaskbarAl" -Value 0 -Force # Alinear a la izquierda (Classic)
Set-ItemProperty -Path $taskbarPath -Name "ShowTaskViewButton" -Value 0 -Force # Quitar Vista de tareas
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -Force # Quitar buscador
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0 -Force # Quitar Chat/Widgets

# 3. MODO OSCURO PURO (Dark Mode Everywhere)
Write-Host "[3/5] Forzando Modo Oscuro total en el sistema..." -ForegroundColor Yellow
$personalizePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
Set-ItemProperty -Path $personalizePath -Name "SystemUsesLightTheme" -Value 0 -Force
Set-ItemProperty -Path $personalizePath -Name "AppsUseLightTheme" -Value 0 -Force

# 4. DEBLOAT DE EXPLORADOR (Minimalist Explorer)
Write-Host "[4/5] Limpiando 'Este Equipo' y el Explorador..." -ForegroundColor Yellow
# Quitar carpetas innecesarias de "Este Equipo" (3D Objects, etc - solo registro)
$explorerPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $explorerPath -Name "LaunchTo" -Value 1 -Force # Abrir en "Este Equipo" en lugar de "Inicio"
Set-ItemProperty -Path $explorerPath -Name "ShowSyncNotifications" -Value 0 -Force # Quitar anuncios de OneDrive

# 5. KILL BING SEARCH (Start Menu Cleanup)
Write-Host "[5/5] Deshabilitando busqueda de Bing en el menu Inicio..." -ForegroundColor Yellow
$searchPath = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
if (-not (Test-Path $searchPath)) { New-Item -Path $searchPath -Force | Out-Null }
Set-ItemProperty -Path $searchPath -Name "DisableSearchBoxSuggestions" -Value 1 -Force

Write-Host "`n--- NIVEL DIOS v6.0: MINIMALIST HACKER COMPLETADA ---" -ForegroundColor Cyan
Write-Host "DEBES REINICIAR EXPLORER.EXE O EL PC PARA VER LOS CAMBIOS." -ForegroundColor Red
