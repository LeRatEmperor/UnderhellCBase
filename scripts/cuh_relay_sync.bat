@echo off
REM cuh_relay_sync.bat
REM
REM Run this on your Windows machine to sync relay commands between
REM GitHub and your GMod data directory.
REM
REM Prerequisites:
REM   - Git installed (https://git-scm.com)
REM   - The cuh_console_relay.lua script installed in your GMod addon
REM
REM Usage:
REM   1. Edit GMOD_DATA_DIR below to match your GarrysMod data folder
REM   2. Run this batch file
REM   3. It will loop forever, syncing commands every 2 seconds
REM   4. Press Ctrl+C to stop

set GMOD_DATA_DIR=W:\SteamLibrary\steamapps\common\GarrysMod\garrysmod\data
set RELAY_DIR=%GMOD_DATA_DIR%\cuh_relay
set TMP_DIR=%TEMP%\cuh_relay_sync
set REPO_URL=https://github.com/LeRatEmperor/UnderhellCBase.git

echo [CUH Relay] GMod data dir: %GMOD_DATA_DIR%
echo [CUH Relay] Relay dir: %RELAY_DIR%
echo [CUH Relay] Temp dir: %TMP_DIR%
echo.

REM Create relay directory in GMod data
if not exist "%RELAY_DIR%" mkdir "%RELAY_DIR%"

REM Clone or pull the repo to temp
if not exist "%TMP_DIR%" (
    echo [CUH Relay] Cloning repo...
    git clone --depth 1 -b cuh-relay %REPO_URL% "%TMP_DIR%" 2>nul
    if errorlevel 1 (
        echo [CUH Relay] Branch cuh-relay not found, trying main...
        git clone --depth 1 %REPO_URL% "%TMP_DIR%" 2>nul
    )
) else (
    cd "%TMP_DIR%"
    git fetch origin cuh-relay 2>nul
    git checkout cuh-relay 2>nul
    git pull origin cuh-relay 2>nul
)

echo [CUH Relay] Starting sync loop. Press Ctrl+C to stop.
echo.

:LOOP
REM Check for new command from GitHub (cuh-relay branch)
if exist "%TMP_DIR%\cmd.txt" (
    REM Read the command
    for /f "delims=" %%a in (%TMP_DIR%\cmd.txt) do set CMD_LINE=%%a
    
    REM Check if it's different from what we already have
    if exist "%RELAY_DIR%\cmd.txt" (
        fc "%TMP_DIR%\cmd.txt" "%RELAY_DIR%\cmd.txt" >nul 2>nul
        if errorlevel 1 (
            echo [CUH Relay] New command detected, copying to GMod...
            copy /Y "%TMP_DIR%\cmd.txt" "%RELAY_DIR%\cmd.txt" >nul
        )
    ) else (
        echo [CUH Relay] First command, copying to GMod...
        copy /Y "%TMP_DIR%\cmd.txt" "%RELAY_DIR%\cmd.txt" >nul
    )
)

REM Check for output files from GMod
if exist "%RELAY_DIR%\out_*.txt" (
    for %%f in ("%RELAY_DIR%\out_*.txt") do (
        echo [CUH Relay] Found output: %%~nxf
        copy /Y "%%f" "%TMP_DIR%\%%~nxf" >nul
        del "%%f"
        
        REM Push output back to GitHub
        cd "%TMP_DIR%"
        git add "%%~nxf"
        git commit -m "Relay output: %%~nxf" 2>nul
        git push origin cuh-relay 2>nul
        echo [CUH Relay] Output pushed to GitHub.
    )
)

REM Wait 2 seconds
timeout /t 2 /nobreak >nul
goto LOOP
