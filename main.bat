@echo off
setlocal EnableDelayedExpansion

set "filename=chinalist.txt"

for /f "usebackq delims=" %%a in ("%filename%") do (
    set "domain=%%a"
    echo.
    echo Resolving !domain!...
    nslookup !domain! >nul 2>nul
    if !errorlevel! equ 0 (
        echo !domain! resolved successfully.
    ) else (
        echo Failed to resolve !domain!
    )
)

endlocal
