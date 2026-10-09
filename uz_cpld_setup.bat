@echo off
setlocal
rem Use a process-local policy so the downloaded setup script can run.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0uz_cpld_setup.ps1" %*
set "setupExitCode=%ERRORLEVEL%"
if not "%setupExitCode%"=="0" (
    echo.
    echo Setup failed. See the error above.
    pause
)
exit /b %setupExitCode%
