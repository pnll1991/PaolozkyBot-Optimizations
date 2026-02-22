# PaolozkyBot Ultra Optimizations 🚀

Este repositorio contiene los scripts de optimización definitivos para usuarios avanzados, gamers y desarrolladores.

## 📁 Scripts Incluidos

### 1. `scripts/turbo_gaming.ps1` (Nivel Kernel)
*   **Red:** Deshabilita el algoritmo de Nagle y el throttling de red para reducir el PING.
*   **Kernel:** Fuerza al kernel a permanecer en la RAM (`DisablePagingExecutive`) para evitar tirones (stuttering).
*   **Energía:** Activa y selecciona el plan oculto de **Máximo Rendimiento**.
*   **Debloat:** Detiene telemetría y servicios de rastreo de Windows.
*   **GPU:** Activa la Programación de GPU acelerada por hardware (HAGS).

### 2. `scripts/dev_env_setup.ps1`
*   Instala automáticamente **VS Code, Git, Docker y Node.js** usando `winget`.
*   Configura parámetros globales de Git.

### 3. `scripts/cleanup.ps1`
*   Limpieza profunda de temporales, caché de DNS y archivos de hibernación innecesarios.

## 🚀 Instalación Rápida
Abre PowerShell como Administrador y ejecuta:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\scripts\turbo_gaming.ps1
```

## ⚠️ Requisito
**Es obligatorio reiniciar el PC** después de ejecutar el script de Gaming, ya que modifica parámetros del registro que solo se cargan en el arranque.

---
Hecho con ❤️ por **PaolozkyBot** 💻
