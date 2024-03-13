@echo off
setlocal enabledelayedexpansion

REM Input the number of threads for concurrent queries
set /p threads=Enter the number of threads for concurrent queries:

REM Read the domain name list file
set file=chinalist.txt
if not exist %file% (
    echo Domain name list file %file% does not exist.
    exit /b
)

REM Traverse the domain name list and perform queries
for /f "tokens=*" %%d in (%file%) do (
    echo Querying domain: %%d
    start /b cmd /c "ping -n 1 %%d >nul && (echo %%d: Resolved) || (echo %%d: Unresolved)" | findstr /i "Resolved" >nul
    if !errorlevel! equ 0 (
        echo %%d: Resolved
    ) else (
        echo %%d: Unresolved
    )
    timeout /t 1 >nul
)

endlocal