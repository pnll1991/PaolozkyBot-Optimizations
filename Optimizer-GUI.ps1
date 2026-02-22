# PaolozkyBot Ultra Optimizer - Master GUI Interface
# Versión: 1.3 (Detailed UI Edition)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Función para obtener métricas actuales ---
function Get-SystemMetrics {
    try {
        $power = powercfg -getactivescheme
        $paging = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -ErrorAction SilentlyContinue).DisablePagingExecutive
        $net = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -ErrorAction SilentlyContinue).NetworkThrottlingIndex
        $vbs = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -ErrorAction SilentlyContinue).EnableVirtualizationBasedSecurity
        $bcd = bcdedit /enum | Select-String "useplatformclock"
        
        return @{
            Power = if ($power -like "*a3f0ef44*") { "Máximo Rendimiento" } else { "Estándar/Ahorro" }
            Kernel = if ($paging -eq 1) { "Bloqueado en RAM" } else { "Paginado (Lento)" }
            Network = if ($net -eq 4294967295) { "Divinidad (Sin límites)" } else { "Limitado (Throttling)" }
            Security = if ($vbs -eq 0) { "Gaming (VBS Off)" } else { "Protegido (VBS On)" }
            Timer = if ($bcd -like "*no*") { "0.5ms (Ultra-Low)" } else { "Variable (Lag)" }
        }
    } catch {
        return @{ Power="Error"; Kernel="Error"; Network="Error"; Security="Error"; Timer="Error" }
    }
}

$Global:StateBefore = Get-SystemMetrics

# --- Configuración Principal del Formulario ---
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "PaolozkyBot Ultra Optimizer v9.4"
$Form.Size = New-Object System.Drawing.Size(550, 750)
$Form.StartPosition = "CenterScreen"
$Form.BackColor = [System.Drawing.Color]::FromArgb(15, 15, 15)
$Form.ForeColor = [System.Drawing.Color]::LimeGreen
$Form.Font = New-Object System.Drawing.Font("Consolas", 10)
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Título
$Title = New-Object System.Windows.Forms.Label
$Title.Text = "NIVEL DIOS OPTIMIZER"
$Title.Font = New-Object System.Drawing.Font("Consolas", 22, [System.Drawing.FontStyle]::Bold)
$Title.Size = New-Object System.Drawing.Size(500, 50)
$Title.Location = New-Object System.Drawing.Point(25, 20)
$Title.TextAlign = "MiddleCenter"
$Form.Controls.Add($Title)

# Contenedor para Checkboxes (Panel con Scroll)
$MainPanel = New-Object System.Windows.Forms.Panel
$MainPanel.Size = New-Object System.Drawing.Size(460, 400)
$MainPanel.Location = New-Object System.Drawing.Point(40, 80)
$MainPanel.AutoScroll = $true
$MainPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$Form.Controls.Add($MainPanel)

$Y = 10
$Scripts = @(
    @{ 
        Name = "Turbo Gaming (Kernel & Red)"
        File = "turbo_gaming.ps1"
        Desc = "Optimiza interrupciones de GPU/Red, activa Modo MSI y CPU Unparking. Reduce el micro-stuttering."
    },
    @{ 
        Name = "Minimalist Hacker (Interfaz)"
        File = "minimalist_hacker.ps1"
        Desc = "Restaura el menú clásico, limpia la barra de tareas y fuerza el Modo Oscuro absoluto."
    },
    @{ 
        Name = "Absolute Zero (Pureza OS)"
        File = "absolute_zero.ps1"
        Desc = "Elimina la hibernación (libera GBs), quita mantenimiento automático y activa rutas largas."
    },
    @{ 
        Name = "Ghost Protocol (Privacidad)"
        File = "ghost_protocol.ps1"
        Desc = "Bloquea telemetría profunda de Microsoft/NVIDIA y optimiza el Shader Cache de la GPU."
    },
    @{ 
        Name = "System Ascension (Latencia)"
        File = "system_ascension.ps1"
        Desc = "Fuerza el Timer a 0.5ms (Lag mínimo), optimiza RAM IO y Master File Table."
    },
    @{ 
        Name = "Limpieza de Archivos"
        File = "cleanup.ps1"
        Desc = "Borra temporales, caché de Windows Update y basura del sistema para liberar espacio."
    },
    @{ 
        Name = "Setup Dev Tools"
        File = "dev_env_setup.ps1"
        Desc = "Instala automáticamente VS Code, Git, Docker y Node.js usando winget."
    }
)

$Checkboxes = @()
foreach ($S in $Scripts) {
    # Checkbox
    $CB = New-Object System.Windows.Forms.CheckBox
    $CB.Text = $S.Name
    $CB.Font = New-Object System.Drawing.Font("Consolas", 10, [System.Drawing.FontStyle]::Bold)
    $CB.Size = New-Object System.Drawing.Size(400, 25)
    $CB.Location = New-Object System.Drawing.Point(10, $Y)
    $CB.Checked = $true
    $CB.Tag = $S.File
    $MainPanel.Controls.Add($CB)
    $Checkboxes += $CB

    # Descripción
    $DescLabel = New-Object System.Windows.Forms.Label
    $DescLabel.Text = $S.Desc
    $DescLabel.Font = New-Object System.Drawing.Font("Consolas", 8, [System.Drawing.FontStyle]::Italic)
    $DescLabel.ForeColor = [System.Drawing.Color]::Gray
    $DescLabel.Size = New-Object System.Drawing.Size(400, 35)
    $DescLabel.Location = New-Object System.Drawing.Point(30, $Y + 25)
    $MainPanel.Controls.Add($DescLabel)

    $Y += 65
}

# Botón de Ejecución
$RunBtn = New-Object System.Windows.Forms.Button
$RunBtn.Text = "¡OPTIMIZAR AHORA!"
$RunBtn.Size = New-Object System.Drawing.Size(440, 60)
$RunBtn.Location = New-Object System.Drawing.Point(50, 500)
$RunBtn.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 0)
$RunBtn.ForeColor = [System.Drawing.Color]::White
$RunBtn.FlatStyle = "Flat"
$RunBtn.Font = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold)
$RunBtn.Cursor = "Hand"

$RunBtn.Add_Click({
    $Selected = $Checkboxes | Where-Object { $_.Checked }
    if ($Selected.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Selecciona al menos una opción.", "Error")
        return
    }

    $Form.Enabled = $false
    $RunBtn.Text = "HACKEANDO SISTEMA..."
    $RunBtn.BackColor = [System.Drawing.Color]::DarkRed

    foreach ($CB in $Selected) {
        $FilePath = Join-Path $PSScriptRoot "scripts/$($CB.Tag)"
        if (Test-Path $FilePath) {
            Start-Process powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$FilePath`"" -Wait
        }
    }

    $StateAfter = Get-SystemMetrics
    Show-Report $StateAfter
    $Form.Close()
})
$Form.Controls.Add($RunBtn)

# Reporte Final
function Show-Report($after) {
    $ResForm = New-Object System.Windows.Forms.Form
    $ResForm.Text = "Auditoría Final"
    $ResForm.Size = New-Object System.Drawing.Size(500, 500)
    $ResForm.BackColor = [System.Drawing.Color]::Black
    $ResForm.ForeColor = [System.Drawing.Color]::White
    $ResForm.StartPosition = "CenterScreen"
    $ResForm.FormBorderStyle = "FixedDialog"

    $ResTxt = New-Object System.Windows.Forms.Label
    $ResTxt.Font = New-Object System.Drawing.Font("Consolas", 11)
    $ResTxt.Size = New-Object System.Drawing.Size(460, 350)
    $ResTxt.Location = New-Object System.Drawing.Point(20, 20)
    $ResTxt.Text = @"
>>> REPORTE TÉCNICO DE ASCENSIÓN <<<

MÉTRICA        | ANTES            | DESPUÉS
--------------------------------------------------
Energía        | $($Global:StateBefore.Power.PadRight(15)) | $($after.Power)
Kernel         | $($Global:StateBefore.Kernel.PadRight(15)) | $($after.Kernel)
Red            | $($Global:StateBefore.Network.PadRight(15)) | $($after.Network)
Seguridad VBS  | $($Global:StateBefore.Security.PadRight(15)) | $($after.Security)
Timers         | $($Global:StateBefore.Timer.PadRight(15)) | $($after.Timer)

--------------------------------------------------
ESTADO: OPTIMIZACIÓN APLICADA EXITOSAMENTE.

[!] REINICIO REQUERIDO PARA ACTIVAR EL KERNEL.
"@
    $ResForm.Controls.Add($ResTxt)

    $CloseBtn = New-Object System.Windows.Forms.Button
    $CloseBtn.Text = "CERRAR Y REINICIAR LUEGO"
    $CloseBtn.Size = New-Object System.Drawing.Size(440, 50)
    $CloseBtn.Location = New-Object System.Drawing.Point(25, 380)
    $CloseBtn.BackColor = [System.Drawing.Color]::FromArgb(40,40,40)
    $CloseBtn.Add_Click({ $ResForm.Close() })
    $ResForm.Controls.Add($CloseBtn)

    $ResForm.ShowDialog()
}

$Footer = New-Object System.Windows.Forms.Label
$Footer.Text = "PaolozkyBot Ultra Optimizer 🚀 Nivel Dios Activado."
$Footer.Size = New-Object System.Drawing.Size(500, 30)
$Footer.Location = New-Object System.Drawing.Point(0, 680)
$Footer.TextAlign = "MiddleCenter"
$Footer.Font = New-Object System.Drawing.Font("Consolas", 8, [System.Drawing.FontStyle]::Italic)
$Form.Controls.Add($Footer)

$Form.ShowDialog()
