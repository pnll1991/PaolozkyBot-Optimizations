# PaolozkyBot Ultra Optimizer - Master GUI Interface
# Versión: 1.1 (Con Reporte Comparativo)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Función para obtener métricas actuales ---
function Get-SystemMetrics {
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
}

# --- Captura de Estado Inicial ---
$Global:StateBefore = Get-SystemMetrics

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "PaolozkyBot Ultra Optimizer 🚀"
$Form.Size = New-Object System.Drawing.Size(500,650)
$Form.StartPosition = "CenterScreen"
$Form.BackColor = [System.Drawing.Color]::FromArgb(10, 10, 10)
$Form.ForeColor = [System.Drawing.Color]::LimeGreen
$Form.Font = New-Object System.Drawing.Font("Consolas", 10)

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "NIVEL DIOS OPTIMIZER"
$Label.Font = New-Object System.Drawing.Font("Consolas", 20, [System.Drawing.FontStyle]::Bold)
$Label.Size = New-Object System.Drawing.Size(450, 40)
$Label.Location = New-Object System.Drawing.Point(25, 20)
$Label.TextAlign = "MiddleCenter"
$Form.Controls.Add($Label)

# --- Checkboxes de Módulos ---
$Y = 80
$Scripts = @(
    @{ Name = "Turbo Gaming (Kernel & Red)"; File = "turbo_gaming.ps1" },
    @{ Name = "Minimalist Hacker (Interfaz)"; File = "minimalist_hacker.ps1" },
    @{ Name = "Absolute Zero (Pureza OS)"; File = "absolute_zero.ps1" },
    @{ Name = "Ghost Protocol (Privacidad)"; File = "ghost_protocol.ps1" },
    @{ Name = "System Ascension (Latencia)"; File = "system_ascension.ps1" },
    @{ Name = "Limpieza de Archivos"; File = "cleanup.ps1" }
)
$Checkboxes = @()
foreach ($S in $Scripts) {
    $CB = New-Object System.Windows.Forms.CheckBox
    $CB.Text = $S.Name
    $CB.Size = New-Object System.Drawing.Size(400, 30)
    $CB.Location = New-Object System.Drawing.Point(50, $Y)
    $CB.Checked = $true
    $CB.Tag = $S.File
    $Form.Controls.Add($CB)
    $Checkboxes += $CB
    $Y += 35
}

$RunBtn = New-Object System.Windows.Forms.Button
$RunBtn.Text = "¡OPTIMIZAR AHORA!"
$RunBtn.Size = New-Object System.Drawing.Size(400, 50)
$RunBtn.Location = New-Object System.Drawing.Point(45, $Y + 20)
$RunBtn.BackColor = [System.Drawing.Color]::FromArgb(20, 80, 20)
$RunBtn.FlatStyle = "Flat"
$RunBtn.Cursor = "Hand"

$RunBtn.Add_Click({
    $Selected = $Checkboxes | Where-Object { $_.Checked }
    if ($Selected.Count -eq 0) { return }

    $Form.Enabled = $false
    $RunBtn.Text = "HACKEANDO WINDOWS..."
    
    foreach ($CB in $Selected) {
        $FilePath = Join-Path $PSScriptRoot "scripts/$($CB.Tag)"
        if (Test-Path $FilePath) {
            powershell.exe -ExecutionPolicy Bypass -File $FilePath
        }
    }

    # --- Captura de Estado Final ---
    $StateAfter = Get-SystemMetrics

    # --- Ventana de Resultados ---
    $ResForm = New-Object System.Windows.Forms.Form
    $ResForm.Text = "Reporte de Operación"
    $ResForm.Size = New-Object System.Drawing.Size(480, 450)
    $ResForm.BackColor = [System.Drawing.Color]::Black
    $ResForm.ForeColor = [System.Drawing.Color]::White
    $ResForm.StartPosition = "CenterParent"

    $ResTxt = New-Object System.Windows.Forms.Label
    $ResTxt.Font = New-Object System.Drawing.Font("Consolas", 10)
    $ResTxt.Size = New-Object System.Drawing.Size(440, 300)
    $ResTxt.Location = New-Object System.Drawing.Point(20, 20)
    $ResTxt.Text = @"
>>> AUDITORÍA TÉCNICA COMPLETADA <<<

MÉTRICA        | ANTES            | DESPUÉS
--------------------------------------------------
Energía        | $($Global:StateBefore.Power.PadRight(15)) | $($StateAfter.Power)
Kernel         | $($Global:StateBefore.Kernel.PadRight(15)) | $($StateAfter.Kernel)
Red            | $($Global:StateBefore.Network.PadRight(15)) | $($StateAfter.Network)
Seguridad VBS  | $($Global:StateBefore.Security.PadRight(15)) | $($StateAfter.Security)
Timers         | $($Global:StateBefore.Timer.PadRight(15)) | $($StateAfter.Timer)

--------------------------------------------------
[!] CAMBIOS PENDIENTES DE REINICIO:
- Afinidad de Interrupciones (GPU/NIC)
- Modo MSI y BCD Edit
- Limpieza de Hibernación

>>> REINICIA EL EQUIPO PARA APLICAR EL NIVEL DIOS <<<
"@
    $ResForm.Controls.Add($ResTxt)

    $CloseBtn = New-Object System.Windows.Forms.Button
    $CloseBtn.Text = "ENTENDIDO (REINICIAR LUEGO)"
    $CloseBtn.Size = New-Object System.Drawing.Size(400, 40)
    $CloseBtn.Location = New-Object System.Drawing.Point(35, 340)
    $CloseBtn.Add_Click({ $ResForm.Close(); $Form.Close() })
    $ResForm.Controls.Add($CloseBtn)

    $ResForm.ShowDialog()
})

$Form.Controls.Add($RunBtn)

$Footer = New-Object System.Windows.Forms.Label
$Footer.Text = "System Optimizer by PaolozkyBot 💻"
$Footer.Size = New-Object System.Drawing.Size(450, 20)
$Footer.Location = New-Object System.Drawing.Point(25, 580)
$Footer.TextAlign = "MiddleCenter"
$Form.Controls.Add($Footer)

$Form.ShowDialog()
