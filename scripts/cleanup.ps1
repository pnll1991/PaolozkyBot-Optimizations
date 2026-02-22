# Windows Cleanup Script
Write-Host "Iniciando limpieza de sistema..." -ForegroundColor Cyan

$paths = @(
    "$env:TEMP\*",
    "C:\Windows\Temp\*",
    "C:\Windows\Prefetch\*",
    "C:\Windows\SoftwareDistribution\Download\*"
)

foreach ($path in $paths) {
    Write-Host "Limpiando: $path"
    try {
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    } catch {}
}

Write-Host "Limpieza terminada." -ForegroundColor Green
