@echo off
setlocal
where pwsh.exe >nul 2>nul
if %errorlevel% equ 0 (
  pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\publish.ps1" -InstallPrerequisites %*
) else (
  powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\publish.ps1" -InstallPrerequisites %*
)
set "PUBLISH_EXIT=%errorlevel%"
if not "%PUBLISH_EXIT%"=="0" echo Publication stopped. Read the message above, fix the problem, and run this launcher again.
pause
exit /b %PUBLISH_EXIT%
