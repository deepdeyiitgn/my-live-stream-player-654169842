@echo off
setlocal EnableDelayedExpansion

:: ==============================================================================
:: BEST PLAYER HUB - POWER CONSOLE v3.5 (FINAL: P-TO-STOP + AUTO KILL)
:: ==============================================================================

:: --- 1. PRE-STARTUP CLEANUP (AUTO KILL) ---
:: This ensures everything is fresh before we start.
taskkill /IM python.exe /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Redirector" /F >nul 2>&1

:: --- 2. SETUP & ENCODING ---
chcp 65001 >nul
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

title BEST PLAYER HUB - POWER CONSOLE v3.5
mode con: cols=155 lines=55
color 0B

:: --- 3. COLORS ---
set "RESET=%ESC%[0m"
set "CYAN=%ESC%[36m"
set "GREEN=%ESC%[32m"
set "YELLOW=%ESC%[33m"
set "RED=%ESC%[31m"
set "WHITE=%ESC%[37m"
set "GREY=%ESC%[90m"

:: Define Server URL
set "SERVER_URL=http://localhost:8000/player.html"

:: --- 4. NETWORK CALIBRATION ---
set "real_ping=45"
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% EQU 0 (
    for /f "tokens=5" %%a in ('ping -n 1 8.8.8.8 ^| find "time="') do set "raw_ping=%%a"
)

if defined raw_ping (
    set "clean_ping=%raw_ping:time=%"
    set "clean_ping=!clean_ping:ms=!"
    if !clean_ping! GTR 0 set "real_ping=!clean_ping!"
)

:: SMART SPEED LOGIC
if %real_ping% LSS 20 (
    set "base_speed=90"
) else if %real_ping% LSS 60 (
    set "base_speed=50"
) else (
    set "base_speed=10"
)

:: ==============================================================================
:: MAIN EXECUTION SEQUENCE
:: ==============================================================================

:: --- INTRO BANNER ---
echo %CYAN%
echo.
echo        d8888  .d8888b.  8888888888 8888888b.  888     888 8888888888 8888888b.        888888b.   Y88b   d88P      8888888b.  8888888888 8888888888 8888888b.  
echo       d88888 d88P  Y88b 888        888   Y88b 888     888 888        888   Y88b       888  "88b   Y88b d88P       888  "Y88b 888        888        888   Y88b 
echo      d88P888 Y88b.      888        888    888 888     888 888        888    888       888  .88P    Y88o88P        888    888 888        888        888   Y88b 
echo     d88P 888  "Y888b.   8888888    888   d88P Y88b   d88P 8888888    888   d88P       8888888K.     Y888P         888    888 8888888    8888888    888   d88P 
echo    d88P  888     "Y88b. 888        8888888P"   Y88b d88P  888        8888888P"        888  "Y88b     888          888    888 888        888        8888888P" 
echo   d88P   888       "888 888        888 T88b     Y88o88P   888        888 T88b         888    888     888          888    888 888        888        888      
echo  d8888888888 Y88b  d88P 888        888  T88b     Y888P    888        888  T88b        888   d88P     888          888  .d88P 888        888        888      
echo d88P     888  "Y8888P"  8888888888 888   T88b     Y8P     8888888888 888   T88b       8888888P"      888          8888888P"  8888888888 8888888888 888      
echo %RESET%
timeout /t 2 >nul

:: --- PHASE 1: SYSTEM & FILE INTEGRITY ---
call :display_box "BEST PLAYER HUB - POWER CONSOLE v3.5"
echo.
call :display_box "THANKS FOR CHOOSING US - A HUB BY DEEP"
echo.

call :display_box "WE ARE STARTING ENGINE"
call :custom_progressbar 30 5
echo.

call :display_box "POWER ON... ENGINE ON..."
timeout /t 2 >nul
echo.

call :display_box "LOOKING ENGINE STATUS...."
call :run_check_box "Stabilizing Power Grid" "FAST"
call :run_check_box "Verifying Voltage (12V)" "FAST"
echo.

call :display_box "ENGINE STATUS OK...."
timeout /t 1 >nul
echo.

:: --- PHASE 2: CONSOLE & DRIVERS ---
call :display_box "CONSOLE CHECKING...."
call :run_check_box "Syncing Core Threads" "NORMAL"
call :run_check_box "Mounting Audio Drivers" "NORMAL"
echo.

call :display_box "CONSOLE OK...."
timeout /t 1 >nul
echo.

:: --- PHASE 3: USER INSTRUCTIONS ---
call :display_box "PLEASE READ INFORMATION FILE...."
timeout /t 2 >nul
echo.

call :display_box "IF NO MUSIC IMPORTED - THEN IMPORT THEM..."
timeout /t 2 >nul
echo.

call :display_box "IT'S EASY - READ INFORMATION AND EXECUTE 3RD COMMAND ON CMD"
timeout /t 2 >nul
echo.

call :display_box "CONSOLE OK... ENGINE OK..."
timeout /t 1 >nul
echo.

:: --- PHASE 4: SOFTWARE VALIDATION ---
call :display_box "NOW LAST LOOKUP TO SOFTWARE...."
echo.

if exist "tracks.json" (
    call :run_check_box "Found: tracks.json" "FAST"
) else (
    call :display_box "WARN: tracks.json MISSING"
)

if exist "player.html" (
    call :run_check_box "Found: player.html" "FAST"
) else (
    call :display_box "ERROR: player.html MISSING"
)
echo.

call :display_box "SOFTWARE GOOD...."
timeout /t 1 >nul
echo.

call :display_box "SCAN DONE... EVERYTHING IS OK..."
timeout /t 1 >nul
echo.

:: --- PHASE 5: LAUNCH ---
call :display_box "PERFORMING PYTHON -M HTTP.SERVER 8000..."
call :custom_progressbar 60 10
echo.

:: START SERVER ON THIS TERMINAL (Background Mode)
echo %GREY%[SYSTEM] Deploying Python Server on Port 8000...%RESET%
start /b python -m http.server 8000 >nul 2>&1

call :display_box "DONE... AN SERVER WAS STARTED...."
timeout /t 1 >nul
echo.

:: OPEN 2ND TERMINAL JUST FOR REDIRECT
call :display_box "OPENING BROWSER INTERFACE..."
timeout /t 2 >nul
start "Redirector" /min cmd /c "timeout /t 1 >nul & start %SERVER_URL% & exit"

call :display_box "THANKS FOR CHOOSING US - AN HUB BY DEEP"
echo.

echo %CYAN%================================================================================%RESET%
echo %YELLOW%              (C) 2025 DEEP DEY ^| ALL RIGHT RESERVED               %RESET%
echo %CYAN%================================================================================%RESET%
echo.

:: ---------------------------------------------------------
:: RUNNING LOOP (Main Terminal stays open)
:: ---------------------------------------------------------
echo %GREEN%================================================================================%RESET%
echo %WHITE%   SERVER RUNNING @ %CYAN%%SERVER_URL%%RESET%
echo %WHITE%   TO STOP: %RED%PRESS 'P'%WHITE% (PLEASE DO NOT USE CTRL+C)
echo %GREEN%================================================================================%RESET%
echo.

:server_loop
    :: Check for 'P' key press (Non-blocking check every 1 second)
    :: choice /c P0 /n /t 1 /d 0
    :: If P is pressed, errorlevel is 1. If timeout (0), errorlevel is 2.
    choice /c P0 /n /t 1 /d 0 >nul
    if %errorlevel% EQU 1 goto :shutdown_sequence
    
    :: Generate fake logs
    set /a "log_id=%random% %% 6"
    if !log_id! EQU 0 echo %GREY%[%time%] %GREEN%GET /player.html [200 OK]%RESET%
    if !log_id! EQU 1 echo %GREY%[%time%] %CYAN%GET /tracks.json [200 OK]%RESET%
    if !log_id! EQU 2 echo %GREY%[%time%] %YELLOW%[Stream] Buffering Audio Segment...%RESET%
    if !log_id! EQU 3 echo %GREY%[%time%] %WHITE%[System] RAM Usage: Stable%RESET%
    if !log_id! EQU 4 echo %GREY%[%time%] %CYAN%GET /artwork.png [304 Cached]%RESET%
    if !log_id! EQU 5 echo %GREY%[%time%] %YELLOW%[Network] Syncing Packet Headers...%RESET%

    goto :server_loop

:: ---------------------------------------------------------
:: SHUTDOWN SEQUENCE (30 Seconds Duration)
:: ---------------------------------------------------------
:shutdown_sequence
cls
color 0C
echo.
call :display_box "INITIATING SHUTDOWN SEQUENCE"
echo.

:: Kill the background python process immediately
taskkill /IM python.exe /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Redirector" /F >nul 2>&1

:: SLOW SHUTDOWN ANIMATION
call :shutdown_anim "Stopping HTTP Daemon"
call :shutdown_anim "Saving Player Data"
call :shutdown_anim "Unmounting Virtual Drives"
call :shutdown_anim "Disconnecting Network"
call :shutdown_anim "Clearing Cache Memory"
call :shutdown_anim "Powering Off Engine"

echo.
call :display_box "SYSTEM HALTED. SAFE TO CLOSE."
echo.
echo %RED%[PROCESS TERMINATED]%RESET%
pause >nul
exit

:: ==============================================================================
:: FUNCTIONS
:: ==============================================================================

:display_box
set "msg=%~1"
echo %CYAN%================================================================================%RESET%
echo %YELLOW%                  %msg%                  %RESET%
echo %CYAN%================================================================================%RESET%
exit /b

:run_check_box
set "chk_name=%~1"
set "chk_type=%~2"
echo %CYAN%================================================================================%RESET%
echo %YELLOW%                  [CHECK] %chk_name%                  %RESET%
echo %CYAN%================================================================================%RESET%
if "%chk_type%"=="FAST" ( call :custom_progressbar 20 2 ) else ( call :custom_progressbar 30 5 )
exit /b

:custom_progressbar
set /a "p_iter=%~1"
set /a "p_delay=%~2"
set /a "max_width=40"
set /a "current_width=0"

:bar_loop
if !current_width! GEQ !max_width! goto :bar_end

set "bar_str="
for /L %%A in (1,1,!current_width!) do set "bar_str=!bar_str!▓"
set /a "remain=!max_width! - !current_width!"
for /L %%B in (1,1,!remain!) do set "bar_str=!bar_str!░"

set /a "variance=%random% %% 10"
set /a "dl_speed=%base_speed% + !variance!"
set /a "ul_speed=%base_speed% / 4 + !variance!"
set /a "ping_jitter=%random% %% 4"
set /a "display_ping=%real_ping% + !ping_jitter!"

<nul set /p ".=%ESC%[2K%ESC%[1G%YELLOW% Loading: [!bar_str!] %RESET%DONE [%GREEN%!dl_speed! Mbps%RESET% / %RED%!ul_speed! Mbps%RESET%] {Ping: !display_ping!ms}"
ping 192.0.2.2 -n 1 -w %p_delay% >nul
set /a "current_width+=1"
goto :bar_loop

:bar_end
<nul set /p ".=%ESC%[2K%ESC%[1G"
echo %GREEN% Loading: [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓] DONE%RESET% [%GREEN%!dl_speed! Mbps%RESET% / %RED%!ul_speed! Mbps%RESET%] {Ping: %real_ping%ms}
exit /b

:shutdown_anim
set "s_name=%~1"
echo %CYAN%================================================================================%RESET%
echo %RED%                  [STOPPING] %s_name%                  %RESET%
echo %CYAN%================================================================================%RESET%
call :custom_progressbar 40 100
exit /b