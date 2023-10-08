@echo off
setlocal
set filename=reload.trigger
powershell Set-ItemProperty %filename% -name LastWriteTime -value $(Get-Date)
endlocal