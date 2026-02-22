# PaolozkyBot Ultra Optimizer - Master GUI Interface
# Versión: 1.5 (User Experience & Eye-Candy Edition)

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
$Form.Text = "PaolozkyBot Ultra Optimizer v9.5"
$Form.Size = New-Object System.Drawing.Size(600, 850)
$Form.StartPosition = "CenterScreen"
$Form.BackColor = [System.Drawing.Color]::FromArgb(10, 10, 12)
$Form.ForeColor = [System.Drawing.Color]::White
$Form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Título con estilo Hacker
$Title = New-Object System.Windows.Forms.Label
$Title.Text = "PAOLOZKYBOT ULTRA"
$Title.Font = New-Object System.Drawing.Font("Consolas", 24, [System.Drawing.FontStyle]::Bold)
$Title.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 128)
$Title.Size = New-Object System.Drawing.Size(550, 50)
$Title.Location = New-Object System.Drawing.Point(25, 20)
$Title.TextAlign = "MiddleCenter"
$Form.Controls.Add($Title)

$SubTitle = New-Object System.Windows.Forms.Label
$SubTitle.Text = "The God-Mode Suite for Gamers & Hackers"
$SubTitle.Font = New-Object System.Drawing.Font("Consolas", 10, [System.Drawing.FontStyle]::Italic)
$SubTitle.ForeColor = [System.Drawing.Color]::Gray
$SubTitle.Size = New-Object System.Drawing.Size(550, 20)
$SubTitle.Location = New-Object System.Drawing.Point(25, 65)
$SubTitle.TextAlign = "MiddleCenter"
$Form.Controls.Add($SubTitle)

# Contenedor para Checkboxes
$MainPanel = New-Object System.Windows.Forms.Panel
$MainPanel.Size = New-Object System.Drawing.Size(500, 380)
$MainPanel.Location = New-Object System.Drawing.Point(50, 100)
$MainPanel.AutoScroll = $true
$MainPanel.BackColor = [System.Drawing.Color]::FromArgb(20, 20, 25)
$Form.Controls.Add($MainPanel)

$Y = 10
$Scripts = @(
    @{ Name = "Turbo Gaming"; File = "turbo_gaming.ps1"; Desc = "Kernel tweaks, MSI Mode, Interrupt Affinity & CPU Unparking." },
    @{ Name = "Minimalist Hacker"; File = "minimalist_hacker.ps1"; Desc = "Dark Mode, Classic Context Menu & Taskbar cleanup." },
    @{ Name = "Absolute Zero"; File = "absolute_zero.ps1"; Desc = "Kill Hibernation, Auto-Maintenance & legacy services." },
    @{ Name = "Ghost Protocol"; File = "ghost_protocol.ps1"; Desc = "Deep privacy, NVIDIA Shader Cache & Telemetry kill." },
    @{ Name = "System Ascension"; File = "system_ascension.ps1"; Desc = "0.5ms Timer, RAM IO & NTFS Master File Table boost." },
    @{ Name = "Cleanup Master"; File = "cleanup.ps1"; Desc = "Purge temp files, Windows Update cache & registry junk." }
)

$Checkboxes = @()
foreach ($S in $Scripts) {
    $CB = New-Object System.Windows.Forms.CheckBox
    $CB.Text = $S.Name
    $CB.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
    $CB.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 128)
    $CB.Size = New-Object System.Drawing.Size(450, 30)
    $CB.Location = New-Object System.Drawing.Point(15, $Y)
    $CB.Checked = $true
    $CB.Tag = $S.File
    $MainPanel.Controls.Add($CB)
    $Checkboxes += $CB

    $DescLabel = New-Object System.Windows.Forms.Label
    $DescLabel.Text = $S.Desc
    $DescLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $DescLabel.ForeColor = [System.Drawing.Color]::LightGray
    $DescLabel.Size = New-Object System.Drawing.Size(450, 25)
    $DescLabel.Location = New-Object System.Drawing.Point(35, $Y + 30)
    $MainPanel.Controls.Add($DescLabel)
    $Y += 65
}

# --- ELEMENTOS DE FEEDBACK (Ansiedad-Buster) ---
$ProgressLabel = New-Object System.Windows.Forms.Label
$ProgressLabel.Text = "Esperando inicio..."
$ProgressLabel.Size = New-Object System.Drawing.Size(500, 25)
$ProgressLabel.Location = New-Object System.Drawing.Point(50, 490)
$ProgressLabel.ForeColor = [System.Drawing.Color]::White
$Form.Controls.Add($ProgressLabel)

$ProgressBar = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Size = New-Object System.Drawing.Size(500, 30)
$ProgressBar.Location = New-Object System.Drawing.Point(50, 520)
$ProgressBar.Style = "Continuous"
$Form.Controls.Add($ProgressBar)

$LogBox = New-Object System.Windows.Forms.TextBox
$LogBox.Multiline = $true
$LogBox.ReadOnly = $true
$LogBox.BackColor = [System.Drawing.Color]::Black
$LogBox.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 0)
$LogBox.Font = New-Object System.Drawing.Font("Consolas", 8)
$LogBox.Size = New-Object System.Drawing.Size(500, 120)
$LogBox.Location = New-Object System.Drawing.Point(50, 560)
$LogBox.ScrollBars = "Vertical"
$Form.Controls.Add($LogBox)

# Botón Principal
$RunBtn = New-Object System.Windows.Forms.Button
$RunBtn.Text = "INITIALIZE ASCENSION"
$RunBtn.Size = New-Object System.Drawing.Size(500, 60)
$RunBtn.Location = New-Object System.Drawing.Point(50, 700)
$RunBtn.BackColor = [System.Drawing.Color]::FromArgb(0, 100, 50)
$RunBtn.ForeColor = [System.Drawing.Color]::White
$RunBtn.FlatStyle = "Flat"
$RunBtn.Font = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold)
$RunBtn.Cursor = "Hand"

$RunBtn.Add_Click({
    $Selected = $Checkboxes | Where-Object { $_.Checked }
    if ($Selected.Count -eq 0) { return }

    $Form.Enabled = $false
    $RunBtn.Text = "SYSTEM REWIRING IN PROGRESS..."
    $RunBtn.BackColor = [System.Drawing.Color]::DarkRed
    $ProgressBar.Maximum = $Selected.Count
    $ProgressBar.Value = 0
    
    $counter = 0
    foreach ($CB in $Selected) {
        $counter++
        $ProgressLabel.Text = "Ejecutando: $($CB.Text) ($counter de $($Selected.Count))..."
        $LogBox.AppendText("[$(Get-Date -Format 'HH:mm:ss')] Iniciando módulo: $($CB.Text)...`r`n")
        $LogBox.ScrollToCaret()
        [System.Windows.Forms.Application]::DoEvents()

        $FilePath = Join-Path $PSScriptRoot "scripts/$($CB.Tag)"
        if (Test-Path $FilePath) {
            $process = Start-Process powershell -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$FilePath`"" -PassThru -Wait
            if ($process.ExitCode -eq 0) {
                $LogBox.AppendText("[SUCCESS] $($CB.Text) aplicado correctamente.`r`n")
            } else {
                $LogBox.AppendText("[ERROR] $($CB.Text) falló con código $($process.ExitCode).`r`n")
            }
        }
        $ProgressBar.Value = $counter
        [System.Windows.Forms.Application]::DoEvents()
    }

    $ProgressLabel.Text = "¡Optimización Finalizada! Generando reporte..."
    Start-Sleep -Seconds 1
    $StateAfter = Get-SystemMetrics
    Show-Report $StateAfter
    $Form.Close()
})
$Form.Controls.Add($RunBtn)

# Reporte Final con más "Amor"
function Show-Report($after) {
    $ResForm = New-Object System.Windows.Forms.Form
    $ResForm.Text = "Ascension Audit"
    $ResForm.Size = New-Object System.Drawing.Size(500, 550)
    $ResForm.BackColor = [System.Drawing.Color]::FromArgb(5, 5, 5)
    $ResForm.ForeColor = [System.Drawing.Color]::White
    $ResForm.StartPosition = "CenterScreen"
    $ResForm.FormBorderStyle = "FixedDialog"

    $ResTitle = New-Object System.Windows.Forms.Label
    $ResTitle.Text = "AUDITORÍA TÉCNICA"
    $ResTitle.Font = New-Object System.Drawing.Font("Consolas", 18, [System.Drawing.FontStyle]::Bold)
    $ResTitle.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 128)
    $ResTitle.Size = New-Object System.Drawing.Size(450, 40)
    $ResTitle.Location = New-Object System.Drawing.Point(25, 20)
    $ResTitle.TextAlign = "MiddleCenter"
    $ResForm.Controls.Add($ResTitle)

    $ResTxt = New-Object System.Windows.Forms.Label
    $ResTxt.Font = New-Object System.Drawing.Font("Consolas", 11)
    $ResTxt.Size = New-Object System.Drawing.Size(460, 320)
    $ResTxt.Location = New-Object System.Drawing.Point(20, 80)
    $ResTxt.Text = @"
MÉTRICA        | ANTES            | DESPUÉS
--------------------------------------------------
Energía        | $($Global:StateBefore.Power.PadRight(15)) | $($after.Power)
Kernel         | $($Global:StateBefore.Kernel.PadRight(15)) | $($after.Kernel)
Red            | $($Global:StateBefore.Network.PadRight(15)) | $($after.Network)
Seguridad VBS  | $($Global:StateBefore.Security.PadRight(15)) | $($after.Security)
Timers         | $($Global:StateBefore.Timer.PadRight(15)) | $($after.Timer)

--------------------------------------------------
RESULTADO: SISTEMA RECALIBRADO AL MÁXIMO.

[!] ATENCIÓN: El Kernel ha sido modificado.
DEBES REINICIAR EL EQUIPO PARA ACTIVAR LOS 
CAMBIOS DE NIVEL DIOS.
"@
    $ResForm.Controls.Add($ResTxt)

    $CloseBtn = New-Object System.Windows.Forms.Button
    $CloseBtn.Text = "ENTENDIDO. REINICIARÉ LUEGO."
    $CloseBtn.Size = New-Object System.Drawing.Size(440, 50)
    $CloseBtn.Location = New-Object System.Drawing.Point(25, 430)
    $CloseBtn.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    $CloseBtn.FlatStyle = "Flat"
    $CloseBtn.Add_Click({ $ResForm.Close() })
    $ResForm.Controls.Add($CloseBtn)

    $ResForm.ShowDialog()
}

$Footer = New-Object System.Windows.Forms.Label
$Footer.Text = "PaolozkyBot Ultra Optimizer 🚀 Pure Performance Architecture."
$Footer.Size = New-Object System.Drawing.Size(600, 30)
$Footer.Location = New-Object System.Drawing.Point(0, 780)
$Footer.TextAlign = "MiddleCenter"
$Footer.Font = New-Object System.Drawing.Font("Consolas", 8, [System.Drawing.FontStyle]::Italic)
$Form.Controls.Add($Footer)

$Form.ShowDialog()
