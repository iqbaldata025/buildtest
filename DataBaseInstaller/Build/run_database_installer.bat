@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
  echo Usage: run_database_installer.bat ENVNAME
  exit /b 1
)

set ENVNAME=%~1
set SRC=C:\DataBaseInstaller\Source_Packages\%ENVNAME%
set DST=C:\DataBaseInstaller\Final_Packages\%ENVNAME%

echo.
echo === Running Database Installer for ENV=%ENVNAME% ===
echo SRC: %SRC%
echo DST: %DST%
echo.

REM Ensure destination folders exist
if not exist "%DST%" mkdir "%DST%"
if not exist "%DST%\DataIntegration" mkdir "%DST%\DataIntegration"

REM Simulate packaging by copying DataIntegration payload to Final_Packages
if exist "%SRC%\DataIntegration" (
  xcopy /s /i /y "%SRC%\DataIntegration" "%DST%\DataIntegration\"
) else (
  echo WARNING: "%SRC%\DataIntegration" not found. Nothing to package.
)

REM Create a simple build-info file
echo Build ENV=%ENVNAME%> "%DST%\build-info.txt"
echo Timestamp=%DATE% %TIME%>> "%DST%\build-info.txt"
echo Source=%SRC%>> "%DST%\build-info.txt"

echo.
echo === Installer finished successfully ===
exit /b 0
