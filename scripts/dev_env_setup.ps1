# Dev & Power User Setup Script
Write-Host "Instalando herramientas esenciales de desarrollo..." -ForegroundColor Cyan

# 1. Verificar/Instalar Chocolatey o Winget
# Usaremos Winget por ser nativo de Windows 10/11
$apps = @("Git.Git", "Microsoft.VisualStudioCode", "Docker.DockerDesktop", "Nodejs.LTS")

foreach ($app in $apps) {
    Write-Host "Instalando $app..."
    winget install --id $app --silent --accept-package-agreements --accept-source-agreements
}

# 2. Configuración de Git
git config --global core.autocrlf true
git config --global init.defaultBranch main

Write-Host "Entorno de desarrollo base configurado." -ForegroundColor Green
