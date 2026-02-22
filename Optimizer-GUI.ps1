# PaolozkyBot Ultra Optimizer - Master GUI Interface
# Versión: 1.0 (Interactive)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "PaolozkyBot Ultra Optimizer 🚀"
$Form.Size = New-Object System.Drawing.Size(450,550)
$Form.StartPosition = "CenterScreen"
$Form.BackColor = [System.Drawing.Color]::FromArgb(15, 15, 15)
$Form.ForeColor = [System.Drawing.Color]::LimeGreen
$Form.Font = New-Object System.Drawing.Font("Consolas", 10)

# Icono (opcional)
# $Form.Icon = ...

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "NIVEL DIOS OPTIMIZER"
$Label.Font = New-Object System.Drawing.Font("Consolas", 18, [System.Drawing.FontStyle]::Bold)
$Label.Size = New-Object System.Drawing.Size(400, 40)
$Label.Location = New-Object System.Drawing.Point(25, 20)
$Label.TextAlign = "MiddleCenter"
$Form.Controls.Add($Label)

$SubLabel = New-Object System.Windows.Forms.Label
$SubLabel.Text = "Selecciona los módulos a ejecutar:"
$SubLabel.Size = New-Object System.Drawing.Size(400, 20)
$SubLabel.Location = New-Object System.Drawing.Point(25, 70)
$SubLabel.TextAlign = "MiddleCenter"
$Form.Controls.Add($SubLabel)

$Y = 110
$Scripts = @(
    @{ Name = "Turbo Gaming (Kernel & Red)"; File = "turbo_gaming.ps1" },
    @{ Name = "Minimalist Hacker (Interfaz)"; File = "minimalist_hacker.ps1" },
    @{ Name = "Absolute Zero (Pureza OS)"; File = "absolute_zero.ps1" },
    @{ Name = "Ghost Protocol (Privacidad)"; File = "ghost_protocol.ps1" },
    @{ Name = "System Ascension (Latencia)"; File = "system_ascension.ps1" },
    @{ Name = "Limpieza de Archivos"; File = "cleanup.ps1" },
    @{ Name = "Setup Dev (VSCode, Git...)"; File = "dev_env_setup.ps1" }
)

$Checkboxes = @()

foreach ($S in $Scripts) {
    $CB = New-Object System.Windows.Forms.CheckBox
    $CB.Text = $S.Name
    $CB.Size = New-Object System.Drawing.Size(350, 30)
    $CB.Location = New-Object System.Drawing.Point(50, $Y)
    $CB.Checked = $true
    $CB.Tag = $S.File
    $Form.Controls.Add($CB)
    $Checkboxes += $CB
    $Y += 40
}

$RunBtn = New-Object System.Windows.Forms.Button
$RunBtn.Text = "¡OPTIMIZAR AHORA!"
$RunBtn.Size = New-Object System.Drawing.Size(350, 50)
$RunBtn.Location = New-Object System.Drawing.Point(45, $Y + 20)
$RunBtn.BackColor = [System.Drawing.Color]::DarkGreen
$RunBtn.FlatStyle = "Flat"
$RunBtn.Cursor = "Hand"

$RunBtn.Add_Click({
    $Selected = $Checkboxes | Where-Object { $_.Checked }
    if ($Selected.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Selecciona al menos un módulo.", "Error")
        return
    }

    $Confirm = [System.Windows.Forms.MessageBox]::Show("¿Seguro que quieres aplicar las optimizaciones seleccionadas? El sistema puede requerir reinicio.", "Confirmar", [System.Windows.Forms.MessageBoxButtons]::YesNo)
    if ($Confirm -eq "No") { return }

    $Form.Enabled = $false
    $RunBtn.Text = "PROCESANDO..."
    
    foreach ($CB in $Selected) {
        $FilePath = Join-Path $PSScriptRoot "scripts/$($CB.Tag)"
        if (Test-Path $FilePath) {
            powershell.exe -ExecutionPolicy Bypass -File $FilePath
        }
    }

    [System.Windows.Forms.MessageBox]::Show("¡Optimización completada con éxito! Se recomienda reiniciar el PC.", "Éxito")
    $Form.Close()
})

$Form.Controls.Add($RunBtn)

# Footer
$Footer = New-Object System.Windows.Forms.Label
$Footer.Text = "Desarrollado por PaolozkyBot 💻"
$Footer.Size = New-Object System.Drawing.Size(400, 20)
$Footer.Location = New-Object System.Drawing.Point(25, 480)
$Footer.TextAlign = "MiddleCenter"
$Footer.Font = New-Object System.Drawing.Font("Consolas", 8)
$Form.Controls.Add($Footer)

$Form.ShowDialog()
