@echo off
setlocal
cd /d "%~dp0"
set "DUMP1090=%~dp0tools\dump1090\dump1090.exe"

if not exist "%DUMP1090%" (
  echo Dump1090 est absent. Lance d'abord install-windows.ps1.
  pause
  exit /b 1
)

if not exist "%~dp0data" mkdir "%~dp0data"
start "F4MYH Radar Web" cmd /c "py -m http.server 8765 --bind 127.0.0.1"
timeout /t 2 /nobreak >nul
start "F4MYH ADS-B Receiver" "%DUMP1090%" --interactive --net --write-json "%~dp0data" --write-json-every 1
start "" http://localhost:8765/
