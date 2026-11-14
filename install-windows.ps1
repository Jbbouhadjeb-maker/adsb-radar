$ErrorActionPreference = "Stop"
$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ToolsDir = Join-Path $ProjectDir "tools\dump1090"
$ZipPath = Join-Path $env:TEMP "dump1090-windows.zip"
$DownloadUrl = "https://github.com/gvanem/Dump1090/releases/download/v1.0.1/Dump1090-for-Windows-1.0.1-x64.zip"

Write-Host "Installation F4MYH ADS-B Radar pour Windows" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
  Write-Host "winget est nécessaire pour installer Python automatiquement." -ForegroundColor Yellow
  Write-Host "Installe Python depuis https://www.python.org/downloads/windows/ puis relance ce fichier."
  Read-Host "Appuie sur Entrée pour fermer"
  exit 1
}

if (-not (Get-Command py -ErrorAction SilentlyContinue)) {
  Write-Host "Installation de Python..."
  winget install --id Python.Python.3.13 -e --accept-package-agreements --accept-source-agreements
}

New-Item -ItemType Directory -Force -Path $ToolsDir, (Join-Path $ProjectDir "data") | Out-Null
if (-not (Test-Path (Join-Path $ToolsDir "dump1090.exe"))) {
  Write-Host "Téléchargement de Dump1090 Windows..."
  Invoke-WebRequest -Uri $DownloadUrl -OutFile $ZipPath
  Expand-Archive -Path $ZipPath -DestinationPath $ToolsDir -Force
  $nested = Get-ChildItem -Path $ToolsDir -Recurse -Filter "dump1090.exe" | Select-Object -First 1
  if ($nested -and $nested.DirectoryName -ne $ToolsDir) {
    Copy-Item $nested.FullName (Join-Path $ToolsDir "dump1090.exe") -Force
  }
}

Write-Host ""
Write-Host "Pilote USB requis : installe WinUSB avec Zadig pour la clé RTL-SDR V3 ou V5." -ForegroundColor Yellow
Write-Host "Téléchargement Zadig : https://zadig.akeo.ie/"
Write-Host "Dans Zadig : Options > List All Devices > RTL2832U / Bulk-In, Interface 0 > WinUSB > Install Driver."
Write-Host ""
Read-Host "Après l'installation du pilote, appuie sur Entrée pour lancer le radar"
Start-Process (Join-Path $ProjectDir "start-windows.bat")
